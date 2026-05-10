---
file: active_campaigns
status: empty
campaigns: []
---

# Active Campaigns — Running Index

Edit the frontmatter `campaigns:` array to add/update entries. The body table mirrors it.

| Name | Type | Framework | Sequence | Voice | Archetype | Status | Started | Leads | Replies |
|---|---|---|---|---|---|---|---|---|---|
| _(no campaigns running yet)_ | | | | | | | | | |

## Status values

- `draft` — created but not launched
- `active` — sending in progress
- `paused` — temporarily halted
- `completed` — sequence ended (replied / unresponsive)
- `archived` — historical reference only

## How rows get here

`/create-campaign` step 6 (review) writes a new row to this file AND to the `campaigns` table in SQLite.

## Updating a row

When KPIs change (replies come in, leads complete the sequence), update the row in frontmatter. Source of truth for live KPIs is the `campaigns` + `messages` SQLite tables — this file is a human-readable snapshot.

## Filtering

For larger sets, query SQLite directly:

```sql
SELECT name, type, status, created_at,
       (SELECT COUNT(*) FROM campaign_leads WHERE campaign_id = c.id) AS leads,
       (SELECT COUNT(*) FROM messages m WHERE m.campaign_id = c.id AND m.status = 'replied') AS replies
FROM campaigns c
WHERE c.status = 'active'
ORDER BY c.created_at DESC;
```
