# gtm/db — Local SQLite Database

Lightweight, file-based DB for runtime GTM data. Single `gtm.db` file. No server.

## Bootstrap

```bash
sqlite3 gtm/db/gtm.db < gtm/db/init.sql
```

After running, you should have:
- 10 tables (accounts, contacts, archetypes, signals, signal_scores, frameworks, sequences, campaigns, campaign_leads, messages)
- 9 seed rows in `archetypes`
- 8 indexes

`gtm.db` is git-ignored (see `gtm/.gitignore`).

## Verify

```bash
sqlite3 gtm/db/gtm.db ".schema"
sqlite3 gtm/db/gtm.db "SELECT * FROM archetypes;"
```

Should output the 10 CREATE TABLE statements + 8 indexes, and 9 archetype rows.

## Foreign keys

SQLite requires `PRAGMA foreign_keys = ON;` per connection — `init.sql` sets it at session start, but if you connect from a different client, set it explicitly:

```sql
PRAGMA foreign_keys = ON;
```

## Common queries

### List all active Tier-1 accounts with a recent funding signal

```sql
SELECT a.name, a.domain, s.occurred_at
FROM accounts a
JOIN signals s ON s.account_id = a.id
WHERE a.tier = 1
  AND a.status = 'active'
  AND s.signal_type = 1
  AND s.occurred_at > date('now', '-90 days')
ORDER BY s.occurred_at DESC;
```

### Find all CROs (archetype 'a') at companies with multilingual landing pages (signal 4)

```sql
SELECT c.full_name, c.email, a.name
FROM contacts c
JOIN accounts a ON c.account_id = a.id
JOIN signals s  ON s.account_id = a.id
WHERE c.archetype_id = 'a'
  AND s.signal_type = 4
ORDER BY a.name;
```

### Campaign performance summary

```sql
SELECT
    c.name,
    c.type,
    c.status,
    (SELECT COUNT(*) FROM campaign_leads cl WHERE cl.campaign_id = c.id) AS leads,
    (SELECT COUNT(*) FROM messages m WHERE m.campaign_id = c.id AND m.status = 'sent') AS sent,
    (SELECT COUNT(*) FROM messages m WHERE m.campaign_id = c.id AND m.status = 'replied') AS replied
FROM campaigns c
WHERE c.status IN ('active', 'completed')
ORDER BY c.created_at DESC;
```

### Generated messages awaiting send

```sql
SELECT
    m.id, c.name AS campaign, ct.full_name, m.step, m.channel, m.subject
FROM messages m
JOIN campaigns c  ON c.id  = m.campaign_id
JOIN contacts  ct ON ct.id = m.contact_id
WHERE m.status = 'draft'
ORDER BY c.name, m.step;
```

## Backup

Just copy the file:

```bash
cp gtm/db/gtm.db gtm/db/gtm.db.backup-$(date +%Y%m%d-%H%M)
```

## Reset

Drop and rebuild (loses all data):

```bash
rm gtm/db/gtm.db
sqlite3 gtm/db/gtm.db < gtm/db/init.sql
```

## Migrations (v2)

When the schema needs to evolve:
1. Add `migrations/001_<description>.sql` (don't modify `init.sql` after v1 lands).
2. Document the change in `schema.md`.
3. Run with `sqlite3 gtm/db/gtm.db < migrations/<file>.sql`.

## Schema

See `schema.md` for the human-readable schema + ERD prose.
