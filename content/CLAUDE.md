---
folder: content
---

# content/ folder rules

This folder holds only **Supersonik + team-member assets** for content generation:

- `voices/` — Voice DNA + post analytics per team member (one file per person, `<fullname>_voice.md`)
- `platform_adaptation/` — Hygiene rules + voice-stays-format-changes principle + per-channel composition guidance

**What does NOT live here:**
- Archetype value props → `gtm/icp/archetypes/<id>_*.md` (each archetype file owns its value prop)
- Message composition rules → `gtm/campaigns/messages/`
- Campaign content → `gtm/campaigns/<campaign_name>/`

## Voice files

Each voice MD has frontmatter (identifier, full_name, job_title, linkedin_url, sample_size) + body following `voices/_template.md`. The template merges:
1. Voice DNA fields (Identity, Tone Markers, Vocabulary, Sentence Structure, Anti-patterns, Platform Rules)
2. Voice Guide analytics (Post structure, formatting rules, topics, content pillars, replicable post templates, engagement boosters)

Both files for a person (compact DNA + analytics guide) get merged into one operational voice file.

## Platform adaptation files

- `global.md` — Hygiene + anti-slop kill list + voice-stays-format-changes principle. **Read this before generating ANY content.**
- `linkedin.md` / `email.md` / `blog.md` — Per-channel format rules.

The voice stays the same across channels; only the format changes per platform file.
