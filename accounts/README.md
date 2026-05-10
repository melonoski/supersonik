---
folder: accounts
purpose: Shared account + contact + signal data across all GTM motions
---

# Accounts — Data Flow & DB Mapping

## Why this folder is top-level

Account-level data (companies, contacts, signals, scores) is **motion-agnostic**:

- **v1 (outbound):** lead lists for campaigns are JOINs across `accounts` + `contacts` + `signals`.
- **v2 (marketing nurture):** the same `accounts` records get nurture content per account, tracked by `account_id`.
- **v3 (ads):** the same `accounts` records become audiences in LinkedIn/Meta ad platforms — `account_id` maps to ad-platform IDs.

By keeping accounts top-level, every motion shares the same source of truth.

## Tables (see `../db/schema.md`)

```
accounts (1) ──< (N) contacts
   │
   └──< (N) signals ──> (1) signal_scores

contacts (M) ──< campaign_leads >── (N) campaigns
```

### `accounts`

One row per company. Key on `domain`. Fields:
- `id` — internal int PK
- `name`, `domain`, `tier` (1/2/3), `industry`, `hq_country`, `arr_band`, `employees`, `crm_id`, `created_at`

### `contacts`

One row per person. FK to `accounts`. Key on `email` or `linkedin_url`. Fields:
- `id`, `account_id`, `full_name`, `title`, `archetype_id` (a–i), `linkedin_url`, `email`, `crm_id`, `created_at`

### `signals`

One row per signal event. FK to `accounts`. The 12 signal types come from `../../12_icp.md`:
1. Series A/B/C in last 90 days
2. Hiring open SE / Demo Engineer / International SDR
3. International expansion press
4. Multilingual landing pages (≥3 langs)
5. Demo form on homepage
6. Walnut/Storylane/Reprise/Consensus in stack
7. Product launch announcement
8. New CRO/VP Sales tenure <6 mo
9. G2/Capterra negative review on demo experience
10. Open SDR/AE reqs > 5
11. Engagement on Lechà LinkedIn post
12. Site visit from named account (reverse-IP)

Fields: `id`, `account_id`, `signal_type` (1–12), `source`, `raw_payload` (JSON), `occurred_at`, `ingested_at`.

### `signal_scores` (v2)

Aggregate score per account. FK to `accounts`. Updated when new signals arrive. See `scoring/scoring_placeholder.md`.

## Data flow

```
External providers (Crustdata, Apollo, BuiltWith, etc.)
        │
        ▼
   accounts + contacts (canonical store)
        │
        ▼
   signals (events arrive over time, scored later)
        │
        ▼
   campaign_leads (join into a specific campaign)
        │
        ▼
   messages (generated per contact × step)
        │
        ▼
   Instantly.ai (sends, polls, replies back)
        │
        ▼
   messages.status update (sent/opened/replied/bounced)
```

## Ingestion modes

1. **Bulk CSV import** — see `../integrations/csv_input.md`. Upserts accounts + contacts + (optional) signals.
2. **Provider pull** — Crustdata `people_search_db` or `company_search_db` filtered by ICP. Writes to accounts + contacts. See `../integrations/crustdata.md`.
3. **Webhook / event** — future: signal providers push events directly into `signals`.

## Common queries

```sql
-- Tier-1 accounts in Western Europe with an active funding signal
SELECT a.* FROM accounts a
JOIN signals s ON s.account_id = a.id
WHERE a.tier = 1
  AND a.hq_country IN ('UK', 'DE', 'NL', 'FR', 'ES')
  AND s.signal_type = 1
  AND s.occurred_at > date('now', '-90 days');

-- All CROs (archetype 'a') at companies with multilingual landing pages
SELECT c.full_name, c.email, a.name FROM contacts c
JOIN accounts a ON c.account_id = a.id
JOIN signals s ON s.account_id = a.id
WHERE c.archetype_id = 'a'
  AND s.signal_type = 4;
```

## Future (v2/v3)

- `scoring/` will hold the weights + recency-decay rules for `signal_scores`.
- Marketing nurture: a new table `nurture_assets` will FK to `account_id`, store per-account personalized content.
- Ads: a `ad_audiences` table will FK to `account_id` and store ad-platform audience IDs.

All v2/v3 additions are **extensions on top of the same `accounts` records** — no migration needed.
