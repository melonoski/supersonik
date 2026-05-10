---
provider: <provider_name>
category: <data | email_sequencing | linkedin_sequencing | crm | ads | enrichment | signals | webhook | other>
env_vars: [<VAR_1>, <VAR_2>]
base_url: <https://...>
docs_url: <https://...>
rate_limits: <e.g. 100 req/min, 30 sends/day>
auth_type: <api_key | oauth | basic | jwt>
reusable: true
---

# <Provider Name> Integration

> Reusable across projects. Drop this file into any project's `integrations/` and fill in the project-specific details at the bottom.

## What this provider does

One paragraph: what data/action this provider offers, when to reach for it, when NOT to.

## Setup

1. Create an account at `<docs_url>`.
2. Generate an API key from the dashboard at `<dashboard_path>`.
3. Add the key to `.env`:
   ```
   <VAR_1>=...
   ```
4. (If applicable) connect external accounts (e.g. mailboxes, ad accounts) inside the provider dashboard.

## Auth

How auth works: header name, format, OAuth flow if relevant. Example request:

```
curl -H "Authorization: Bearer $<VAR_1>" <base_url>/<endpoint>
```

## Endpoints we use

| Endpoint | Method | Purpose | Returns |
|---|---|---|---|
| `/path` | GET | What we call it for | Schema / fields |

## Rate limits + retry strategy

- Hard cap: <e.g. 100 req/min>
- Soft cap: <e.g. 30 sends/day>
- Token bucket / cooldown: <how we handle>
- Retry: <strategy on 429 / 5xx>

## Data schemas (input + output)

### Input

```json
{
  "field": "..."
}
```

### Output

```json
{
  "id": "...",
  "field": "..."
}
```

## How it integrates with the GTM system

- **Reads:** what tables / files in this project consume data from this provider
- **Writes:** what tables / files this provider gets fed
- **Workflows that use it:** list workflow names

## Known issues / gotchas

- `<thing 1>`
- `<thing 2>`

## Cost

- Pricing tier(s) and what we're on
- Cost per API call / per record / per month

## Health check

How to verify the integration is live (`curl` or a tiny script).

---

## Project-specific notes (Supersonik GTM)

Add anything specific to how this project uses the provider — list IDs, mailbox IDs, custom workflows, gotchas observed locally.
