---
mode: from_scratch
input: user-written prose describing the sequence
output: sequence.yml (AI-formatted, validated against _schema.yml)
---

# Mode 3 — Sequence from Scratch

User writes the sequence in prose; AI formats it into the YAML schema.

## When to use

- No framework or template fits.
- User has a specific cadence in mind that's not yet a template.
- Quick ad-hoc sequences for one-off campaigns.

## Procedure

1. User describes the sequence in prose. Examples that work:
   - "Three emails over a week. First on day 0, second on day 3, third on day 7."
   - "Two emails and a LinkedIn DM. Email day 0, LinkedIn day 2, email day 5."
   - "Day 0 email signal-anchored, day 2 email with peer reference, day 4 LinkedIn DM."
2. AI parses the prose into the YAML structure:
   - Identifies step count
   - Maps each step's channel and delay
   - Assigns step numbers 1..N
3. Asks user for missing details:
   - Per-step `ask` (one-line description of what each step asks)
   - Optional: `subject_hint`, CRM actions, expected KPIs
4. Generates the YAML.
5. Validates against `_schema.yml`.
6. **Asks user to confirm** before writing to `campaigns/<campaign_name>/sequence.yml`.

## Required AI behavior

- Do not infer step intent — ask if unclear.
- Do not invent delay_days when the user is vague ("a few days" → ask "how many").
- Always run schema validation.
- Default `crm_actions` to:
  ```yaml
  crm_actions:
    - on_send: log_to_crm
    - on_reply: log_to_crm
    - on_no_reply_after_step_N: mark_unresponsive
  ```

## Save as template?

After running successfully, ask the user: "Should I save this as a reusable template under `templates/<name>.yml`?" If yes, copy with a generic name (no campaign-specific data) into `templates/`.

## Example transcript

> User: "I want 4 touches over 2 weeks. Email day 0, email day 2, LinkedIn DM day 5, email day 10."

> AI: "Got it. What's the ask for each step? Let me suggest:
> - Step 1 (email, day 0): signal-anchored open + 15-min call ask
> - Step 2 (email, day 2): peer reference bump
> - Step 3 (LinkedIn DM, day 3 after step 2 = day 5): light DM referencing email
> - Step 4 (email, day 5 after step 3 = day 10): soft break-up
> Should I generate the YAML?"

> User: "Yes."

> AI: [generates YAML, validates, presents for confirmation]

> User: "Looks good, save it."

> AI: [writes to campaigns/<campaign_name>/sequence.yml]
