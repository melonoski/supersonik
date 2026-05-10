---
provider: csv_input
category: lead_import
env_vars: []
reusable: true
---

# CSV Lead Import

Manual lead-list ingestion. Used when the lead source is a hand-curated or exported CSV (not Crustdata).

## Required columns

| Column | Type | Required | Notes |
|---|---|---|---|
| `full_name` | string | yes | "First Last" |
| `email` | string | one of email/linkedin | Validate format; bounce-check via Instantly later |
| `linkedin_url` | string | one of email/linkedin | Profile URL (`linkedin.com/in/...`) |
| `company` | string | yes | Company name |
| `domain` | string | recommended | Company root domain (`acme.com`) for account dedup |
| `title` | string | yes | Job title (used for archetype mapping) |
| `archetype_id` | string | optional | One of `a`–`i` (auto-inferred if blank) |
| `tier` | int | optional | 1 / 2 / 3 (auto-inferred from company if blank) |
| `hq_country` | string | optional | ISO-2 or full name |
| `signal_type` | string | optional | If the row was sourced from a specific signal |
| `signal_occurred_at` | ISO date | optional | When the signal fired |

## Import flow

1. Place CSV at `gtm/campaigns/<campaign_name>/lead_list.csv`.
2. Run import (manual for v1 — paste rows to Claude with this schema):
   - For each row, upsert into `accounts` (key on `domain` or `company`).
   - Upsert into `contacts` (key on `email` or `linkedin_url`).
   - Insert into `campaign_leads` (campaign_id + contact_id + status='pending').
   - If `signal_type` is set, insert into `signals` (account_id + signal_type + occurred_at).
3. Run archetype inference for any contact missing `archetype_id`:
   - Match `title` against archetype title patterns in `gtm/icp/archetypes/<id>_*.md` frontmatter (`title` field).
   - If no match, mark `archetype_id = NULL` and flag for manual review.

## Validation

- Reject rows missing `full_name`, `company`, AND both `email` and `linkedin_url`.
- Dedup within the CSV (same email or same linkedin_url).
- Dedup against `contacts` table (do not re-add an existing contact to a new campaign without explicit confirm).

## Example

```csv
full_name,email,linkedin_url,company,domain,title,archetype_id,tier
Jane Doe,jane@acme.com,https://linkedin.com/in/janedoe,Acme Corp,acme.com,VP Sales DACH,f,2
John Smith,,https://linkedin.com/in/johnsmith,Beta Inc,beta.io,Head of RevOps,b,1
```

---

## Project-specific notes (Supersonik GTM)

- Default lead-list location: `gtm/campaigns/<campaign_name>/lead_list.csv`.
- Mirror to SQLite: `campaign_leads` table.
- See `gtm/db/schema.md` for the full target schema.
