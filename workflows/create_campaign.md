---
workflow: create_campaign
trigger: /create-campaign
phase: v1_outbound
---

# Workflow #1 — Create Campaign

End-to-end flow to launch a new outbound campaign. The slash command `/create-campaign` runs this; this document is the source of truth for the step order, inputs, and outputs at each step.

---

## Step order (locked)

```
1. Choose campaign type
2. Choose framework
3. Choose sequence
4. Load lead list
5. Choose voice
6. Review all selections
7. Generate messages
```

---

## Step 1 — Choose campaign type

- **Source:** `campaigns/campaign_types.md`
- **Action:** Present the 6 types (outbound, awareness, feedback, event_promotion, event_post, customer_winback). User picks one.
- **Output:** `campaign.type` field set. The `prompt` field for that type is captured as `campaign.campaign_prompt` — fed into message generation at step 7.

## Step 2 — Choose framework

- **Source:** `campaigns/frameworks/frameworks_list.md`
- **Action:** Show stored frameworks with their KPI links. User picks one or chooses "none" (sequence-only flow).
- **Output:** `campaign.framework_id` set; framework's `sequence_steps`, `messaging_guidelines`, `title_guidelines` become inputs to step 3 and step 7.
- **Note:** Before searching for new frameworks, always check `frameworks_list.md` first to dedupe.

## Step 3 — Choose sequence

- **Source:** `campaigns/sequences/templates/*.yml` (default present: `email_3step_default.yml`)
- **3 modes:**
  - `from_framework` (see `sequences/from_framework.md`) — derive sequence from the chosen framework's `sequence_steps`
  - `from_template` (see `sequences/from_template.md`) — pick a stored template (default: `email_3step_default.yml` — mail day 0 / +2 days / +3 days)
  - `from_scratch` (see `sequences/from_scratch.md`) — user writes steps in prose, AI formats into the YAML schema (`sequences/_schema.yml`)
- **Output:** `campaign.sequence_id` set; sequence YAML written to the campaign folder.

## Step 4 — Load lead list

- **Source options:**
  - CSV file uploaded by user (schema in `integrations/csv_input.md`)
  - SQL pull from `accounts/` + `contacts/` filtered by tier / archetype / signal
- **Action:** Validate the list (required columns: full_name, email or linkedin_url, company, title). Map contacts to archetypes (`a`–`i`) where missing.
- **Output:** Rows written to `campaigns/<campaign_name>/lead_list.csv` and mirrored into the `campaign_leads` table in SQLite.

## Step 5 — Choose voice

- **Source:** `content/voices/*.md`
- **Action:** Show available voices (currently: `dani_carmona_voice.md`, `dale_boltaev_voice.md`). User picks one.
- **Output:** `campaign.voice_id` set. The selected voice file is loaded as input to step 7.

## Step 6 — Review all selections

- **Action:** Print a summary of: campaign name, type, type prompt, framework, sequence, voice, archetype mix in the lead list, lead count.
- **Gate:** Wait for user confirmation before proceeding to generation. **Do not generate messages until confirmed.**

## Step 7 — Generate messages

- **Source:** `campaigns/messages/_generation_flow.md`
- **Inputs (skip-if-empty rule):**
  1. `content/platform_adaptation/global.md` (hygiene + anti-slop — always required)
  2. `campaigns/messages/global_composition_rules.md`
  3. `campaigns/messages/email_composition_rules.md` *(if any step is email)*
  4. `campaigns/messages/linkedin_composition_rules.md` *(if any step is linkedin)*
  5. Selected voice file
  6. Per-contact archetype detail file (`icp/archetypes/<id>_*.md`)
  7. `campaign.campaign_prompt` (from step 1)
  8. Active signals on the contact's account (from `signals` table)
- **Output per step:**
  - `campaigns/<campaign_name>/messages_step_<N>.md` (one file per step number, starting at 1)
  - Row in `messages` table: `(campaign_id, contact_id, step, channel, subject, body, generated_at)`
- **Validation:** Each generated message must pass `global.md` anti-slop checks (banned words/patterns) before being written.

---

## Failure handling

- If any required input is missing (e.g. user has no voices, no frameworks chosen and no sequence selected), pause and ask. Do not proceed with placeholders.
- If a generated message violates hygiene (fabricated logos/ARR/numbers), reject and regenerate with citation to the research file the claim should trace to.
