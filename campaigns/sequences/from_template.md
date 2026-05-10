---
mode: from_template
input: template_filename (from sequences/templates/)
output: sequence.yml (copy of template, optionally customized)
---

# Mode 2 — Sequence from Template

Pick a stored sequence template and use it as-is or with light edits.

## When to use

- No framework chosen at step 2 (or framework lacks `sequence_steps`).
- You want a known-good cadence shape without reinventing.
- Default offer: `templates/email_3step_default.yml` (mail → +2d mail → +3d mail).

## Available templates (v1)

| Template | Steps | Channels | Total span | Use case |
|---|---|---|---|---|
| `email_3step_default.yml` | 3 | email | 5 days | Default for all tiers. Lightweight outbound. |

(Add more templates over time. Each must conform to `_schema.yml`.)

## Procedure

1. Present the available templates from `templates/*.yml`.
2. User picks one.
3. (Optional) User edits step asks, delays, or CRM actions.
4. Copy the chosen template to `campaigns/<campaign_name>/sequence.yml`.
5. Validate against `_schema.yml`.
6. Reference in `campaign.md`.

## Customization rules

- **Can change:** `ask`, `subject_hint`, `delay_days`, `crm_actions`, `description`, `notes`.
- **Cannot change without good reason:** number of steps, channel mix (creates a new sequence kind — save as a new template instead).
- **Must change:** `name` (give it a campaign-specific identifier).

## Adding a new template

1. Copy an existing template → `templates/<new_name>.yml`.
2. Edit to fit the new pattern.
3. Validate against `_schema.yml`.
4. Add a row to the "Available templates" table above.
