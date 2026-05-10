---
file: schema
engine: sqlite
tables: 10
---

# Database Schema

SQLite database for runtime GTM data. Config + templates stay in MD/YAML.

## ERD (text form)

```
accounts (1) ──< (N) contacts
   │                    │
   │                    └──< (N) campaign_leads >── (1) campaigns
   │                                                     │     │
   │                                                     │     ├──> (1) frameworks
   │                                                     │     └──> (1) sequences
   │                                                     │
   └──< (N) signals                                      └──< (N) messages
   │
   └──< (1) signal_scores
```

## Tables (10)

### `accounts`

One row per company. Canonical record. Shared across motions.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | Internal |
| `name` | TEXT NOT NULL | Company name |
| `domain` | TEXT UNIQUE | Root domain (preferred dedup key) |
| `tier` | INTEGER | 1, 2, or 3 (FK semantics — links to `icp/tiers.md`) |
| `industry` | TEXT | |
| `hq_country` | TEXT | ISO-2 or full name |
| `arr_band` | TEXT | e.g. "$5M-$50M" |
| `employees` | INTEGER | Headcount |
| `crm_id` | TEXT | External CRM record ID (HubSpot/Salesforce) — v2 |
| `status` | TEXT | `active` (default), `archived`, `not_now` |
| `created_at` | TEXT NOT NULL | ISO 8601 |
| `updated_at` | TEXT | ISO 8601 |

### `contacts`

One row per person.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `account_id` | INTEGER NOT NULL | FK → accounts.id |
| `full_name` | TEXT NOT NULL | |
| `title` | TEXT | Job title |
| `archetype_id` | TEXT | a–i (FK semantics — links to `icp/archetypes/_index.md`) |
| `linkedin_url` | TEXT | |
| `email` | TEXT UNIQUE | |
| `crm_id` | TEXT | External CRM ID — v2 |
| `status` | TEXT | `active`, `archived`, `bounced`, `replied` |
| `created_at` | TEXT NOT NULL | |
| `updated_at` | TEXT | |

### `archetypes`

Seed table — 9 rows from `icp/archetypes/_index.md`.

| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | One of a, b, c, d, e, f, g, h, i |
| `tier` | INTEGER NOT NULL | 1, 2, or 3 |
| `name` | TEXT NOT NULL | "Alex the CRO", etc. |
| `role_category` | TEXT NOT NULL | "Decision Maker", "Implementator", "Champion" |

### `signals`

One row per signal event. The 12 signal types from `../../12_icp.md`.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `account_id` | INTEGER NOT NULL | FK → accounts.id |
| `signal_type` | INTEGER NOT NULL | 1–12 from the inventory |
| `source` | TEXT | Provider that surfaced it (crustdata, manual, etc.) |
| `raw_payload` | TEXT | JSON dump of original payload |
| `occurred_at` | TEXT | When the underlying event happened |
| `ingested_at` | TEXT NOT NULL | When we recorded it |

### `signal_scores`

v2 scoring placeholder. One row per account.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `account_id` | INTEGER NOT NULL UNIQUE | FK → accounts.id |
| `score` | REAL | Composite score (calc model in `accounts/scoring/scoring_placeholder.md`) |
| `weights` | TEXT | JSON: per-signal contribution breakdown |
| `updated_at` | TEXT NOT NULL | |

### `campaigns`

One row per running/historical campaign.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `name` | TEXT NOT NULL UNIQUE | lower_snake_case |
| `type` | TEXT NOT NULL | One of: outbound, awareness, feedback, event_promotion, event_post, customer_winback |
| `framework_id` | INTEGER | FK → frameworks.id (nullable) |
| `sequence_id` | INTEGER | FK → sequences.id |
| `voice_id` | TEXT | identifier from `content/voices/<voice>.md` frontmatter |
| `archetype_id` | TEXT | a–i, or "mixed" |
| `status` | TEXT NOT NULL | `draft`, `active`, `paused`, `completed`, `archived` |
| `kpis` | TEXT | JSON: {emails_sent, opens, replies, meetings_booked, etc.} |
| `instantly_campaign_id` | TEXT | External Instantly.ai campaign ID |
| `created_at` | TEXT NOT NULL | |
| `launched_at` | TEXT | |

### `frameworks`

Stored cold-email/DM frameworks.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `name` | TEXT NOT NULL UNIQUE | |
| `source` | TEXT | Origin (URL or attribution) |
| `sequence_steps` | TEXT | JSON: array of {step, channel, delay_days, ask} |
| `messaging_guidelines` | TEXT | |
| `title_guidelines` | TEXT | |
| `linked_campaign_kpis` | TEXT | JSON: array of {campaign_name, leads, open_rate, reply_rate, meetings} |
| `added_at` | TEXT NOT NULL | |

### `sequences`

Stored sequences (from template or custom).

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `name` | TEXT NOT NULL UNIQUE | |
| `source_framework_id` | INTEGER | FK → frameworks.id (nullable) |
| `steps` | TEXT NOT NULL | JSON: array per `sequences/_schema.yml` |
| `crm_actions` | TEXT | JSON: {on_send, on_reply, ...} |
| `created_at` | TEXT NOT NULL | |

### `campaign_leads`

Many-to-many — contacts in campaigns.

| Column | Type | Notes |
|---|---|---|
| `campaign_id` | INTEGER NOT NULL | FK → campaigns.id |
| `contact_id` | INTEGER NOT NULL | FK → contacts.id |
| `enriched_email` | TEXT | If different from contacts.email (post-enrichment) |
| `status` | TEXT | `pending`, `sending`, `replied`, `bounced`, `completed`, `unsubscribed` |
| `added_at` | TEXT NOT NULL | |

PK: (campaign_id, contact_id).

### `messages`

Generated outbound messages.

| Column | Type | Notes |
|---|---|---|
| `id` | INTEGER PK AUTOINCREMENT | |
| `campaign_id` | INTEGER NOT NULL | FK → campaigns.id |
| `contact_id` | INTEGER NOT NULL | FK → contacts.id |
| `step` | INTEGER NOT NULL | 1-indexed |
| `channel` | TEXT NOT NULL | `email` or `linkedin` |
| `subject` | TEXT | Email subject (NULL for LinkedIn DMs) |
| `body` | TEXT NOT NULL | Message body |
| `generated_at` | TEXT NOT NULL | ISO 8601 |
| `sent_at` | TEXT | ISO 8601, NULL until sent |
| `status` | TEXT | `draft`, `sent`, `opened`, `replied`, `bounced`, `paused` |

---

## Indexes

```
CREATE INDEX idx_contacts_account ON contacts(account_id);
CREATE INDEX idx_contacts_archetype ON contacts(archetype_id);
CREATE INDEX idx_signals_account ON signals(account_id);
CREATE INDEX idx_signals_type_occurred ON signals(signal_type, occurred_at);
CREATE INDEX idx_messages_campaign ON messages(campaign_id);
CREATE INDEX idx_messages_status ON messages(status);
CREATE INDEX idx_campaign_leads_campaign ON campaign_leads(campaign_id);
CREATE INDEX idx_campaign_leads_status ON campaign_leads(status);
```

## Seed data (in `init.sql`)

- 9 rows in `archetypes` (from `icp/archetypes/_index.md`)

## Foreign keys

SQLite requires `PRAGMA foreign_keys = ON;` per connection. Apply at session start.
