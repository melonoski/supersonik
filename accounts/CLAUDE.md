---
folder: accounts
shared_across: [outbound, marketing_nurture, ads]
---

# accounts/ folder rules

This folder is **top-level on purpose** — it holds account-level data that is shared across every GTM motion. v1 = outbound consumes it. v2+ marketing nurture and ads will consume the same data.

## Why top-level (not nested under campaigns)

If accounts/contacts lived inside `campaigns/`, every new motion would need its own copy → drift, dedup nightmare, no single source of truth. By keeping accounts top-level:

- One canonical record per company / per person.
- Signals attach to accounts once and feed every motion.
- v2 nurture content + v3 ads target the same `account_id` and inherit tier + archetype + score.

## What lives here

- `README.md` — data flow + DB mapping documentation.
- `scoring/` — signal → score model (v2 stake; placeholder for now).

## What does NOT live here

- Lead lists for a specific campaign → `campaigns/<campaign_name>/lead_list.csv` (and mirrored to `campaign_leads` table).
- Per-archetype detail / value props → `icp/archetypes/`.
- Voice / content → `content/`.

## Database mapping

| Concept | Table | Notes |
|---|---|---|
| Company | `accounts` | Keyed on `domain` or `name` |
| Person | `contacts` | FK to `accounts`, archetype_id (a–i) |
| Signal event | `signals` | FK to `accounts`, typed per the 12-signal inventory |
| Score | `signal_scores` | FK to `accounts`; v2 implementation |

See `../db/schema.md` for full schema.

## Ingestion sources

| Source | How |
|---|---|
| CSV import (manual lead lists) | See `../integrations/csv_input.md` |
| Crustdata enrichment | See `../integrations/crustdata.md` |
| Manual entry | Direct SQL insert (rare, for one-offs) |

## Data hygiene

- **Dedupe on `domain`** (preferred) or `name` (fallback) for accounts.
- **Dedupe on `email`** (preferred) or `linkedin_url` (fallback) for contacts.
- **Never** delete an account or contact — set `status = 'archived'` to preserve history for attribution.
