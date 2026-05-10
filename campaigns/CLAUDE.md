---
folder: campaigns
---

# campaigns/ folder rules

This folder owns every outbound campaign — types, active list, per-campaign data, and the three building blocks underneath it: frameworks, sequences, and messages.

## Structure

```
campaigns/
├── campaign_types.md            # 6 types: outbound, awareness, feedback, event_promo, event_post, winback
├── active_campaigns.md          # Index of running campaigns (one row each)
├── _campaign_template/          # Skeleton for new campaigns
├── frameworks/                  # Reusable outbound frameworks
├── sequences/                   # Sequence schemas, modes, stored templates
└── messages/                    # Composition rules + generation flow
```

## Per-campaign convention

Each new campaign gets its own folder: `campaigns/<campaign_name>/`. Contents:

```
<campaign_name>/
├── campaign.md          # frontmatter: name, type, framework, sequence, voice, archetype, status, kpis
├── lead_list.csv        # Mirrored to campaign_leads in SQLite
├── messages_step_1.md   # Generated message file per step
├── messages_step_2.md
└── ...
```

## Creation flow

Use `/create-campaign` (slash command). Source-of-truth doc: `../workflows/create_campaign.md`.

Step order (locked):
1. Campaign type
2. Framework
3. Sequence
4. Lead list
5. Voice
6. Review
7. Generate messages

## Source-of-truth rules

- **Hygiene + anti-slop:** `../content/platform_adaptation/global.md` (load first, always).
- **Composition rules:** `messages/global_composition_rules.md` + `messages/email_composition_rules.md` + `messages/linkedin_composition_rules.md`.
- **Generation inputs:** `messages/_generation_flow.md` (the skip-if-empty input list).

## Active campaigns index

Add a new row to `active_campaigns.md` whenever `/create-campaign` finishes step 6. Mirror the campaign row into the `campaigns` table in SQLite.
