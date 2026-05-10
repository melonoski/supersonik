---
folder: integrations
---

# Integrations folder rules

This folder holds provider integration documentation + environment variable templates.

## File pattern

- One MD file per provider, named `<provider>.md`.
- All MD files follow the structure in `_provider_template.md` so future projects can reuse them.
- Env vars live in `.env.example` (committed, placeholder values) and `.env` (git-ignored, real values).

## v1 providers (in scope)

| Provider | File | Env var(s) | Purpose |
|---|---|---|---|
| Instantly.ai | `instantly.md` | `INSTANTLY_API_KEY` | Cold email sequencing |
| Crustdata | `crustdata.md` | `CRUSTDATA_API_KEY` | People + company data, signals |
| CSV input | `csv_input.md` | — | Manual lead list import |

## Adding a new provider

1. Copy `_provider_template.md` → `<provider>.md`.
2. Fill the template sections.
3. Add env var(s) to `.env.example`.
4. Update the table above.
5. Update `gtm/CLAUDE.md` if the provider affects a workflow step.

## Out of scope (v1)

CRM (HubSpot/Salesforce), LinkedIn outreach (Heyreach/Unipile), Slack, Ads — see `gtm/project_status.md` "Out of scope".
