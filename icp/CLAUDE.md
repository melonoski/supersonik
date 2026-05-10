---
folder: icp
---

# ICP folder rules

Tier + archetype definitions for Supersonik. Source: `../../12_icp.md` (research file).

## Structure

- `tiers.md` — master table, 3 rows (Tier 1 / 2 / 3) with firmographics, channel mix, cadence shape.
- `archetypes/_index.md` — master table, 9 rows. Cols: id (a–i), tier, name, role_category, link to detail file.
- `archetypes/_template.md` — per-archetype detail + value-prop template.
- `archetypes/<id>_<name>.md` — 9 detail files, one per archetype.

## Relationships

- **Archetype depends on tier.** Each archetype file frontmatter has a `tier` field referencing 1/2/3 from `tiers.md`.
- **Letter convention encodes role category:**
  - a / d / g = Decision Maker
  - b / e / h = Implementator
  - c / f / i = Champion
- Letters a–c are Tier 1, d–f are Tier 2, g–i are Tier 3.

## Renaming map (from `../../12_icp.md` source archetypes)

| New id | Tier | Role | New name | Source archetype |
|---|---|---|---|---|
| a | 1 | Decision Maker | Alex the CRO | 1A Carlos the CRO |
| b | 1 | Implementator | Ben the RevOps Lead | 1C Dani the RevOps Lead |
| c | 1 | Champion | Carla the Demand Gen Lead | 1B Marta the Demand Gen Lead |
| d | 2 | Decision Maker | Dan the International CEO | 2A Hiroshi the Intl CEO |
| e | 2 | Implementator | Eric the Enablement Lead | 2C Jordan the Enablement Lead |
| f | 2 | Champion | Felix the Regional VP | 2B Emma the Regional VP |
| g | 3 | Decision Maker | Gabriel the AI-Native CEO | 3A Asha the AI-Native CEO |
| h | 3 | Implementator | Hugo the GTM Engineer | 3C Sam the GTM Engineer |
| i | 3 | Champion | Iris the Head of Growth | 3B Ben the Head of Growth |

## Used by

- `/create-campaign` → step 4 (lead-list archetype mapping)
- `campaigns/messages/_generation_flow.md` → archetype detail is a generation input
- `accounts/scoring/scoring_placeholder.md` → scoring rules reference archetypes
