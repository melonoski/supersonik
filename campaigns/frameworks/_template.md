---
id: "<framework_id_lower_snake_case>"
name: "<Friendly Name>"
source: "<URL or attribution>"
added_at: "<YYYY-MM-DD>"
sequence_steps: []        # Array of step objects: {step, channel, delay_days, ask, summary}
messaging_guidelines: ""  # Voice/tone/structure rules this framework prescribes
title_guidelines: ""      # Subject-line / opening-line guidelines
typical_kpis: {}          # Expected KPI ranges if documented in source
linked_campaign_kpis: []  # Array of {campaign_name, leads, open_rate, reply_rate, meetings} for campaigns that used this framework
notes: ""
---

# <Framework Name>

Description of the framework. Where it came from. Why it works (the underlying insight or empirical evidence).

## Origin

[Author / company / publication. Link to source.]

## Core idea

[1–2 paragraph summary of the framework's central thesis.]

## Sequence steps

| Step | Channel | Delay (days) | Ask |
|---|---|---|---|
| 1 | <email/linkedin> | 0 | <one-line ask> |
| 2 | <email/linkedin> | <N> | <one-line ask> |
| 3 | <email/linkedin> | <N> | <one-line ask> |

(Edit frontmatter `sequence_steps:` array to update.)

## Messaging guidelines

[Voice / tone / structure rules this framework prescribes. Examples:
- Lead with a signal in line 1
- Use proof-by-numbers in line 2
- Keep body under 75 words
- One ask, deferred CTA]

## Title / subject-line guidelines

[How to write the subject line per this framework. Examples:
- 3–5 words
- Lowercase
- Reference the signal, not the product
- No questions]

## When to use

- Best for: [tiers, archetypes, signal types]
- Avoid when: [scenarios where this framework doesn't fit]

## Linked campaign KPIs

(Populated when campaigns use this framework. Pulled from the `campaigns` SQLite table.)

| Campaign | Leads | Open rate | Reply rate | Meetings |
|---|---|---|---|---|
| — | — | — | — | — |

## Notes

[Free-form. Variants, A/B observations, edits over time.]
