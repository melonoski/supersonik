---
provider: crustdata
category: data
env_vars: [CRUSTDATA_API_KEY]
base_url: https://api.crustdata.com
docs_url: https://docs.crustdata.com/
rate_limits: depends on plan; credits-based
auth_type: api_key
reusable: true
---

# Crustdata Integration

B2B people + company intelligence (800M+ profiles, 200M+ companies). Source for ICP-fit prospect lists, enrichment, signals (funding, hiring, leadership changes), and job listings.

## Setup

1. Sign up at https://crustdata.com.
2. Generate an API key in dashboard → API Access.
3. Add to `.env`:
   ```
   CRUSTDATA_API_KEY=...
   ```
4. Optional: install the Crustdata MCP server for Claude-driven lookups (see `crustdata_install_skills` MCP tool).

## Auth

```
curl -H "Authorization: Token $CRUSTDATA_API_KEY" https://api.crustdata.com/...
```

## Tool selection (cost-aware order)

Use this preference order — the cheap/free option first, fall back only if needed:

| Need | Preferred tool | Cost | Fallback |
|---|---|---|---|
| Company lookup by name/domain | `company_identify` | FREE | `company_enrich` (1–4 credits) |
| People search | `people_search_db` | 3 credits/100 | `people_search` (live LinkedIn — only if DB returns 0) |
| Company search | `company_search_db` | 1 credit | `company_search` (live LinkedIn) |
| Contact info (email/phone) | `people_enrich` | 2–5 credits | — |
| Social posts (by profile) | `social_posts` | per-post | — |
| Social posts (by keyword) | `company_social_posts` | per-post | — |
| Job listings (filterable/aggregations) | `job_search` | 1 credit/job | `job_search_live` (realtime scrape) |
| Batch jobs (up to 10 companies, async) | `batch_job_search` | — | `batch_job_search_live` |
| Alerts / webhooks | `watcher_create` → `watcher_list` | — | — |
| Discover valid filter values | `autocomplete_company` / `autocomplete_person` / `autocomplete_filter` | FREE | — |

**Critical rules:**
1. NEVER invent field names — only use names from each tool's documented parameters.
2. Use autocomplete tools to discover valid values for filters before passing them.
3. Check `credits_check` if unsure about remaining balance.

## Recommended workflows

1. **Find people at a company:** `company_identify` (free) → `people_search_db` (filter `current_employers.company_id`) → `people_enrich` for contact info.
2. **Research a company:** `company_identify` (free) → `company_enrich` (include all fields).
3. **Find decision-makers:** `people_search_db` (filter `current_employers.seniority_level` + company + title) → `people_enrich` for emails/phones.
4. **Market research:** `company_search_db` (filter industry, headcount, location, funding).
5. **Hiring-trend signals:** `job_search` with aggregations by company/title/location.

## Data flow into the GTM system

- **Account enrichment:** `company_identify` → `company_enrich` fills `accounts` table (industry, hq_country, arr_band, employees).
- **Contact enrichment:** `people_search_db` → `people_enrich` fills `contacts` table (full_name, title, linkedin_url, email).
- **Signals:** Funding events, hiring spikes, leadership changes — write to `signals` table with `signal_type` matching the 12-signal inventory in `../../12_icp.md`.

## Rate limits + retry strategy

- Credit-based — check balance with `credits_check` before large batches.
- For large pulls, use `batch_*` async endpoints.

## Known issues / gotchas

- DB endpoints return cached data — for absolute-freshest signals, use the `_live` variants (more credits).
- Filter syntax: nested dot-notation (`current_employers.seniority_level`, not `seniority`).
- Some live LinkedIn scrapes have a 6+ second latency.

## Cost

Credits-based; see https://crustdata.com/pricing. Each tool's cost is documented above.

## Health check

```
curl -H "Authorization: Token $CRUSTDATA_API_KEY" https://api.crustdata.com/healthz
```

Or via MCP: `crustdata_healthz`.

---

## Project-specific notes (Supersonik GTM)

- Default tier filters drawn from `gtm/icp/tiers.md` (ARR bands, employee bands, HQ countries).
- Signal types to ingest match the 12-signal inventory in `../../12_icp.md` (funding, hiring SE/SDR/AE, multilingual landing pages, demo form, competitor stack, new CRO/VP Sales tenure <6mo, etc.).
- Archetype mapping: filter `current_employers.title` against archetype titles in `gtm/icp/archetypes/<id>_*.md` frontmatter.
