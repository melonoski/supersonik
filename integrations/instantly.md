---
provider: instantly
category: email_sequencing
env_vars: [INSTANTLY_API_KEY]
base_url: https://api.instantly.ai/api/v2
docs_url: https://developer.instantly.ai/
rate_limits: 30 sends/day default (Unipile token bucket)
auth_type: api_key
reusable: true
---

# Instantly.ai Integration

Email sequencing provider. Sends cold/warm outbound emails on our behalf, manages mailbox health, surfaces opens/replies/bounces back to the system.

Source notes from previous integration: `../../Infra/infra_email.txt`.

## Setup

1. Sign up at https://instantly.ai.
2. Connect mailboxes (Gmail / Outlook / custom SMTP) inside the Instantly dashboard. Instantly handles SMTP/IMAP config and warm-up.
3. Generate an API key in dashboard → Settings → API.
4. Add to `.env`:
   ```
   INSTANTLY_API_KEY=...
   ```

## Auth

```
curl -H "Authorization: Bearer $INSTANTLY_API_KEY" https://api.instantly.ai/api/v2/...
```

## Endpoints we use

| Endpoint | Method | Purpose | Returns |
|---|---|---|---|
| `/campaigns` | POST | Create a campaign from a sequence | `{ campaign_id }` |
| `/campaigns/{id}/leads` | POST | Push leads (email, first_name, last_name, company) | per-lead status |
| `/campaigns/{id}/analytics` | GET | Poll sent/opened/replied/bounced counts | counters |
| `/email-accounts` | GET | List connected mailboxes | array |

## Rate limits + retry strategy

- Default 30 sends/day per campaign (Unipile token bucket).
- Acquire tokens before each send batch — back off on 429.
- Status polling: every N minutes via the tracker.

## Data flow

### Outbound (system → Instantly)

1. `/create-campaign` builds a sequence (`gtm/campaigns/<name>/sequence.yml`).
2. System calls `POST /campaigns` with step templates (subject + body + delay_days per step).
3. System calls `POST /campaigns/{id}/leads` with rows from `campaign_leads`. Each lead gets stamped with `instantly_campaign_id` in the `campaigns` SQLite row.

### Inbound (Instantly → system)

1. Tracker polls `/campaigns/{id}/analytics` on a schedule.
2. On reply detection:
   - Update `messages.status = 'replied'` in SQLite.
   - Fire webhooks (CRM logging, Slack notification — v2).
   - Stop further steps for that contact (blocklist).
3. On bounce:
   - Mark `campaign_leads.status = 'bounced'`.
   - Suppress future sends to that address.

## How it integrates with the GTM system

- **Reads:** `gtm/campaigns/<name>/sequence.yml`, `campaign_leads` table.
- **Writes:** `campaigns.instantly_campaign_id`, `messages.sent_at` / `messages.status`, `campaign_leads.status`.
- **Workflows that use it:** `/create-campaign` (step 7, push) and tracker (status sync).

## Known issues / gotchas

- Connected mailboxes need 2+ weeks of warm-up before high sending volume.
- Replies from auto-responders sometimes mark as `replied` — guard with content checks.
- A/B variants: track open/reply per variant; auto-pause losing variant on statistical significance (handled by tracker logic).

## Cost

Per-mailbox monthly fee + per-send overage above plan. See https://instantly.ai/pricing.

## Health check

```
curl -H "Authorization: Bearer $INSTANTLY_API_KEY" \
  https://api.instantly.ai/api/v2/email-accounts
```

Returns `[]` or `[{...}]` if auth is valid.

---

## Project-specific notes (Supersonik GTM)

- Mailboxes used: TBD (per `team.md` member identities).
- Default sequence: `gtm/campaigns/sequences/templates/email_3step_default.yml` (3 steps, days 0 / +2 / +3).
- Message validation: every message passes anti-slop check (`gtm/content/platform_adaptation/global.md`) before being pushed to Instantly.
