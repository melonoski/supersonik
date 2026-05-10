---
command: /create-campaign
description: Walk the user through creating a new outbound campaign end-to-end.
---

# /create-campaign

Run the full campaign creation workflow. Source of truth: `gtm/workflows/create_campaign.md`.

## Step order (locked — do not reorder)

1. **Campaign type** — read `gtm/campaigns/campaign_types.md`, present 6 types, capture user choice + the type's `prompt` field as `campaign_prompt`.
2. **Framework** — read `gtm/campaigns/frameworks/frameworks_list.md`, show options + KPIs, capture choice (or "none").
3. **Sequence** — read `gtm/campaigns/sequences/templates/*.yml`. Default offer: `email_3step_default.yml`. Three creation modes: `from_framework` / `from_template` / `from_scratch` — see corresponding mode docs under `sequences/`.
4. **Lead list** — accept CSV (schema in `gtm/integrations/csv_input.md`) or pull from SQLite. Mirror into `gtm/campaigns/<campaign_name>/lead_list.csv` + `campaign_leads` table.
5. **Voice** — read `gtm/content/voices/*.md`, capture user choice.
6. **Review** — print full summary, **wait for user confirmation before continuing**.
7. **Generate messages** — follow `gtm/campaigns/messages/_generation_flow.md`. Always load `gtm/content/platform_adaptation/global.md` (hygiene + anti-slop) first. Validate every message against banned words/patterns before writing.

## Outputs

- New folder `gtm/campaigns/<campaign_name>/` with `campaign.md` + `lead_list.csv` + `messages_step_<N>.md` files.
- Campaign row added to `gtm/campaigns/active_campaigns.md` index.
- Rows inserted into SQLite: `campaigns`, `campaign_leads`, `messages`.

## Rules

- Use only sourced claims (see `gtm/content/platform_adaptation/global.md`).
- One ask per email. Reference something specific per contact.
- Match the chosen voice; respect `content/voices/<voice>.md` anti-patterns.
- Never proceed past step 6 without explicit user confirmation.
