---
folder: db
engine: sqlite
db_file: gtm.db (git-ignored)
---

# db/ folder rules

Local SQLite database for the GTM system. Runtime data only — config and templates stay as MD/YAML files.

## Files

- `schema.md` — human-readable schema + ERD prose
- `init.sql` — `CREATE TABLE` statements for all tables
- `README.md` — how to bootstrap and query
- `gtm.db` — the actual database (git-ignored)

## Bootstrap

```bash
sqlite3 gtm/db/gtm.db < gtm/db/init.sql
```

## What lives in the DB vs MD/YAML

| Lives in DB (runtime data) | Lives in MD/YAML (config, templates) |
|---|---|
| Accounts (companies) | Tier definitions |
| Contacts (people) | Archetype definitions + value props |
| Signals (events) | Voice profiles |
| Campaign records | Composition rules |
| Generated messages | Sequence templates |
| Lead lists (`campaign_leads`) | Framework definitions |
| Sequence instances (when launched) | Workflow docs |

## Why this split

- **MD/YAML** is human-editable, git-diffable, HTML-renderable. Good for content that changes by hand.
- **SQLite** is queryable, transactional, fast at JOINs. Good for runtime/event data and large lists.

## Rules

- Never delete a row — set `status = 'archived'` or `deleted_at` to preserve history.
- Use FK constraints (`PRAGMA foreign_keys = ON;` at session start).
- All timestamps are ISO 8601 (`TEXT`).
- JSON columns (`raw_payload`, `weights`, `kpis`, etc.) stored as `TEXT` — Python/SQL clients parse on read.

## Migrations

v1 has no migration framework. When the schema needs to change in v2:
1. Add a new file `migrations/001_<description>.sql`.
2. Document the change in `schema.md`.
3. Run via `sqlite3 gtm.db < migrations/<file>.sql`.

## Queries

See `README.md` for common queries. For ad-hoc analysis:

```bash
sqlite3 gtm/db/gtm.db
```

Then `.schema`, `.tables`, etc.
