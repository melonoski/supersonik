---
phase: v1_outbound
status: in_build
started: 2026-05-10
owner: pdr@keemail.me
---

# Supersonik GTM — Project Status

## Current phase

**v1 — Outbound campaigns (email + LinkedIn DMs).**

Architecture skeleton + templates + the few pre-fillable files (voices, tiers, archetypes, default email sequence). Actual campaigns/frameworks/messages produced via the `/create-campaign` workflow.

---

## Build checklist (v1)

### Architecture
- [x] Folder layout under `gtm/`
- [x] Root `CLAUDE.md` + per-folder `CLAUDE.md`s
- [x] `.gitignore` (db/*.db, integrations/.env)

### Integrations
- [x] `.env.example` with `INSTANTLY_API_KEY` + `CRUSTDATA_API_KEY`
- [x] `_provider_template.md` (reusable across projects)
- [x] `instantly.md` (from `Infra/infra_email.txt`)
- [x] `crustdata.md` (full reusable findings)
- [x] `csv_input.md` (lead import schema)

### Content
- [x] `voices/_template.md` — combined Voice DNA + Voice Guide
- [x] `voices/dani_carmona_voice.md`
- [x] `voices/dale_boltaev_voice.md`
- [x] `platform_adaptation/global.md` (hygiene + anti-slop + voice-stays-format-changes)
- [x] `platform_adaptation/linkedin.md`
- [x] `platform_adaptation/email.md`
- [x] `platform_adaptation/blog.md`

### ICP
- [x] `icp/tiers.md` (3 tiers from `12_icp.md`)
- [x] `icp/archetypes/_index.md` (master table, 9 rows)
- [x] `icp/archetypes/_template.md` (per-archetype + value-prop template)
- [x] 9 per-archetype files: `a_alex_cro` … `i_iris_head_of_growth`

### Scoring (v2 stake only — under accounts/)
- [x] `accounts/scoring/scoring_placeholder.md`

### Campaigns
- [x] `campaign_types.md` (6 types from appendix)
- [x] `active_campaigns.md` (empty index)
- [x] `_campaign_template/` (campaign.md + lead_list.csv + messages_step_1.md)
- [x] `frameworks/_template.md` + `frameworks_list.md` (empty)
- [x] `sequences/_schema.yml` + 3 mode docs
- [x] `sequences/templates/email_3step_default.yml`
- [x] `messages/{global,email,linkedin}_composition_rules.md` + `_generation_flow.md`

### Accounts + DB
- [x] `accounts/CLAUDE.md` + `accounts/README.md`
- [x] `db/schema.md` + `db/init.sql` + `db/README.md`
- [x] `gtm.db` initialized (10 tables + 9 seed archetype rows)

### Workflows
- [x] `workflows/create_campaign.md`
- [x] `.claude/commands/create-campaign.md`

---

## v1 Definition of Done

1. All folders + files above exist.
2. `sqlite3 gtm/db/gtm.db < gtm/db/init.sql` succeeds; `.schema` lists 10 tables.
3. `/create-campaign` walks through the 7-step flow without missing references.
4. `content/platform_adaptation/global.md` is the single source of hygiene + anti-slop rules.
5. 9 archetype files exist under the new letter-keyed names with pains/value/trust pre-filled from `12_icp.md`.
6. `dani_carmona_voice.md` + `dale_boltaev_voice.md` follow the combined template, merging both source files for each person.

---

## Out of scope (deferred)

| Item | Phase target | Notes |
|---|---|---|
| Workflow #2 (signal → Slack to AE) | v2 | Drop until Slack integration is wired |
| Real campaigns / frameworks / sequences / messages | runtime | Generated via `/create-campaign` after v1 ships |
| Scoring engine implementation | v2 | Placeholder doc only |
| CRM sync (HubSpot / Salesforce) | v2 | Not in v1 integrations |
| LinkedIn outreach automation (Heyreach/Unipile) | v2 | Manual DMs only in v1 |
| Ads (LinkedIn / Meta) | v3 (marketing motion) | Marketing nurture uses same `accounts/` data |
| LinkedIn post generation command | v2 | Voices + linkedin.md ready, no command yet |
| HTML artifact generator script | v2 | MDs structured for it; generator itself downstream |
| Voice files for the other 7 team members | as samples arrive | Only Dani + Dale in v1 |

---

## Roadmap (high-level)

- **v1 (now):** Outbound — campaigns/sequences/messages via `/create-campaign`.
- **v2:** Signal-driven workflows, scoring engine, Slack alerts, CRM sync, LinkedIn outreach automation.
- **v3:** Marketing motion — nurture content per account, ads. Reuses `accounts/` data.
- **v4:** Analytics + KPI dashboards across motions.

---

## Last update

2026-05-10 — initial skeleton built.
