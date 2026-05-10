---
file: message_generation_flow
triggered_by: /create-campaign (step 7)
applies_to: all_outbound_message_generation
---

# Message Generation Flow

Defines the inputs Claude consumes when generating outbound messages and the order of precedence. **Skip-if-empty rule:** if an input source is empty/missing, skip it rather than failing — but log which inputs were skipped.

---

## Inputs (in load order)

| # | Input | Path | Required? | If empty |
|---|---|---|---|---|
| 1 | Hygiene + anti-slop | `../../content/platform_adaptation/global.md` | YES | FAIL — never proceed without |
| 2 | Global composition rules | `./global_composition_rules.md` | YES | FAIL |
| 3 | Channel composition rules | `./email_composition_rules.md` OR `./linkedin_composition_rules.md` (per step.channel) | YES | FAIL for that step |
| 4 | Selected voice | `../../content/voices/<voice>.md` | YES | FAIL — must pick a voice |
| 5 | Per-contact archetype detail | `../../icp/archetypes/<archetype_id>_*.md` | YES | If contact has NULL archetype_id, prompt for manual classification or skip the contact |
| 6 | Campaign type prompt | from `../campaign_types.md` → `prompt` field for `campaign.type` | YES | FAIL — campaign type required |
| 7 | Per-contact active signals | from `signals` SQLite table for `contact.account_id` | NO (recommended) | Generate without signal anchor; flag message as "no-signal" (lower priority for cold opens) |
| 8 | Per-contact firmographics | from `accounts` table (tier, industry, hq_country, employees, arr_band) | NO | Skip context |
| 9 | Step-specific context | the step row in the sequence (`step`, `channel`, `delay_days`, `ask`) | YES | FAIL — every message belongs to a step |
| 10 | Sequence framework messaging guidelines | from `frameworks/frameworks_list.md` if `campaign.framework_id != null` | NO | Skip (rely on global + channel rules) |

---

## Generation order

For each step in the sequence, for each contact in `campaign_leads`:

1. **Load inputs** (above order).
2. **Determine signal anchor** (input #7):
   - Pick the most recent eligible signal for the contact's account.
   - "Eligible" = signal age < 90 days AND signal_type matches the campaign's expected mix (see `campaign_types.md` → `primary_signals`).
3. **Map structure** (channel-specific):
   - Email: subject + body per `email_composition_rules.md` structure
   - LinkedIn DM: body per `linkedin_composition_rules.md` structure
4. **Apply voice** (input #4): vocabulary, sentence structure, tone markers, replicable templates.
5. **Pull value angle** from archetype (input #5): use `value_lands` + `value_prop` fields.
6. **Place trust device** if this is touch 1 of the sequence: pick from archetype.trust_devices (one only). Skip on touches 2+.
7. **Validate against**:
   - Global anti-slop kill list (banned words/patterns)
   - Channel word-count limits
   - One-ask rule
   - Citation rule (no fabricated Supersonik claims)
8. **Write output:**
   - File: `campaigns/<campaign_name>/messages_step_<N>.md` (one section per contact)
   - SQLite row in `messages`: `(campaign_id, contact_id, step, channel, subject, body, generated_at)`
9. **Log skipped inputs** for transparency (if signal anchor missing, etc.).

---

## Failure modes

| Failure | Behavior |
|---|---|
| Missing required input (#1, 2, 3, 4, 5, 6, 9) | HALT generation. Surface the missing input. |
| Banned word/pattern detected in draft | Reject draft. Regenerate. |
| Word count exceeded | Cut a paragraph (not paraphrase). Re-validate. |
| Fabricated Supersonik claim (no source) | Reject. Find a category benchmark with citation or drop the claim entirely. |
| Trust device already used in earlier step of same sequence | Remove from current draft. |
| No eligible signal for contact (input #7 empty) | Mark message as "no-signal" — generate without anchor but flag for review. |
| Contact has NULL archetype_id (input #5 missing) | Skip the contact OR prompt user to classify before proceeding. |

---

## Output format (per message in `messages_step_<N>.md`)

```markdown
---
step: <N>
channel: <email|linkedin>
contact_id: <id>
account_id: <id>
archetype_id: <a-i>
signal_anchor:
  signal_type: <1-12 or null>
  occurred_at: <date or null>
generated_at: <ISO timestamp>
inputs_used: [global, channel, voice, archetype, campaign_prompt, signal]
inputs_skipped: []
---

## <Contact Full Name> — <Company>

**Subject:** <subject line>

> <message body verbatim>
```

---

## Anti-slop check (every message, every time)

Before writing to file:

1. Run text against banned-words list (`../../content/platform_adaptation/global.md`).
2. Run text against banned-patterns list.
3. Check word count vs channel cap.
4. Confirm one ask only.
5. Confirm trust device count for this sequence ≤ 1 (cumulative across all earlier steps).

If any check fails: reject, regenerate, re-check. Three failures in a row → halt and surface to user.

---

## Logging

For every generation run, write a summary to `campaigns/<campaign_name>/_generation_log.md` (created if missing):

```
## <ISO timestamp> — step <N> generation
- Contacts: <N total>
- Generated: <N>
- Skipped (no signal): <N>
- Skipped (no archetype): <N>
- Rejected (anti-slop fail): <N>
- Inputs skipped (cumulative): [list]
```

Helps audit which messages had which inputs, especially when running multi-step generation.
