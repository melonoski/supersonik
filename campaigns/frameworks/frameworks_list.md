---
file: frameworks_list
status: empty
frameworks: []   # Each entry: {id, name, source, added_at, sequence_steps, messaging_guidelines, title_guidelines, linked_campaign_kpis: [{campaign_name, leads, open_rate, reply_rate, meetings}]}
---

# Frameworks — Stored List

All stored outbound frameworks live here. HTML-friendly: one section per framework. Edit the frontmatter `frameworks:` array to add or update; the body mirrors it.

**Before adding a new framework: check this file to dedupe.**

---

## (empty)

No frameworks stored yet. Use `_template.md` to add the first one.

When populated, each framework renders as a section like:

```
### <Framework Name> (id: <framework_id>)

**Source:** [URL]
**Added:** YYYY-MM-DD

**Sequence steps:**
| Step | Channel | Delay (days) | Ask |
|---|---|---|---|
| 1 | email | 0 | ... |
| 2 | email | 2 | ... |

**Messaging guidelines:**
- ...

**Title / subject-line guidelines:**
- ...

**Linked campaign KPIs:**
| Campaign | Leads | Open rate | Reply rate | Meetings |
|---|---|---|---|---|
| <campaign_name> | 200 | 38% | 7.2% | 12 |
```

---

## How to add a new framework

1. Check this list first to avoid duplicates.
2. Copy `_template.md` → `<framework_id>.md` (or just add to this file's frontmatter).
3. Fill the structured fields.
4. Add a section in the body mirroring frontmatter.
5. When a campaign uses the framework, append an entry to `linked_campaign_kpis` so the KPI history is visible in one place.

## How KPIs get linked back

When `/create-campaign` selects a framework at step 2, the campaign captures `campaign.framework_id`. After the campaign runs, KPIs from the `campaigns` SQLite table (sent, opened, replied, meetings) get summarized and appended to the framework's `linked_campaign_kpis` array. Over time, this answers "which frameworks have produced the best results across what archetypes / tiers".
