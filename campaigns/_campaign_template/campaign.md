---
name: "<campaign_name_lower_snake_case>"
type: "<outbound | awareness | feedback | event_promotion | event_post | customer_winback>"
framework: "<framework_id from frameworks_list.md or 'none'>"
sequence: "<sequence_template_filename or 'custom'>"
voice: "<voice_identifier from content/voices/*.md>"
archetype: "<archetype_id a-i — or 'mixed' for multi-archetype list>"
status: "draft"
created_at: "<YYYY-MM-DD>"
launched_at: null
kpis:
  leads_total: 0
  emails_sent: 0
  opens: 0
  replies: 0
  meetings_booked: 0
  bounce_rate: 0
  open_rate: 0
  reply_rate: 0
notes: ""
---

# <Campaign Name>

Campaign metadata + KPI tracker. Edit frontmatter for structured fields; use body for narrative notes.

## Goal

[What this campaign is trying to do. One paragraph.]

## ICP / target

- Tier: [1/2/3 or mix]
- Archetype: [a–i or mix]
- Geos: [list]
- Signals required: [list signal types from `../../../12_icp.md` inventory]

## Framework + sequence

- Framework: see `../frameworks/frameworks_list.md` → [framework_id]
- Sequence: see `../sequences/templates/<sequence_template>.yml`

## Voice

See `../../content/voices/<voice>.md`.

## Files in this campaign

- `lead_list.csv` — leads (mirrored to `campaign_leads` table)
- `messages_step_<N>.md` — generated messages per sequence step

## Launch checklist

- [ ] Lead list validated and imported to SQLite
- [ ] Messages generated for all steps
- [ ] Anti-slop check passed on every message
- [ ] Voice consistency confirmed
- [ ] Trust devices distributed (max one per sequence)
- [ ] Pushed to Instantly (see `../../integrations/instantly.md`)
- [ ] Campaign row added to `../active_campaigns.md`

## Notes

[Free-form. Observations, A/B variants, learnings.]
