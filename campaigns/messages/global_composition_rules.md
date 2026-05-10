---
file: global_composition_rules
applies_to: all_outbound_messages
parent_rules: ../../content/platform_adaptation/global.md
---

# Global Composition Rules (Outbound Messages)

These rules apply to **every outbound message** regardless of channel. Channel-specific rules (`email_composition_rules.md`, `linkedin_composition_rules.md`) layer on top.

Always load `../../content/platform_adaptation/global.md` first for hygiene + anti-slop. This file extends it with outbound-specific guidance.

---

## Anti-patterns (never do these)

- ❌ "Hope this finds you well" / "Quick question" / "Following up"
- ❌ Generic value-prop dump in line 1 — no anchor
- ❌ Multiple CTAs ("would you like a call OR a demo OR a whitepaper?")
- ❌ Stat without source attribution
- ❌ "I noticed your company is in [VERY-COMMON-INDUSTRY]" — too vague
- ❌ Calling out a signal that's already 90+ days old without acknowledgment
- ❌ Using a Tier-2 signal in a Tier-1 cadence (and vice versa) — wrong scale framing
- ❌ Mixing archetypes mid-cadence (start as Alex, switch to Carla on touch 3)
- ❌ Trust devices on every touch — once per sequence is enough

---

## Words to ban

| Instead of | Write |
|---|---|
| leverage | use |
| utilize | use |
| streamline | speed up, simplify |
| game-changer | [be specific: "cut our enrichment time from 2 hours to 4 minutes"] |
| cutting-edge | new, latest |
| revolutionary | [just describe what it does] |
| synergy | [delete the sentence] |
| elevate | improve, raise |
| robust | solid, strong |
| unlock | get, access, enable |
| deep dive | look at, dig into |

(This table mirrors `../../content/platform_adaptation/global.md`. Single source of truth lives there.)

---

## Patterns to ban

- **"In today's [anything]..."** — delete the whole sentence. Start with the point.
- **"Let me be clear:"** — just be clear. You don't need to announce it.
- **"Here's the thing:"** — used sparingly and only if it's actually your voice. Most people don't talk like this.
- **Opening with a question you immediately answer** — "What if I told you..." No.
- **Three em dashes in one paragraph** — unless that's genuinely how you write.
- **Ending every section with a one-sentence power line** — most detectable AI pattern on LinkedIn right now.

---

## Required structure (every outbound message)

1. **Anchor (line 1):** A specific reference to the recipient. Signal, prior post, company action. Not "I saw your company is growing" — too vague.
2. **Connection (1–2 lines):** Why the anchor matters in their context. Pain or implication.
3. **Value frame (1–2 lines):** How Supersonik addresses it — tied to the archetype's `what_lands` field.
4. **One ask:** A 15-minute conversation. Or a click-through. Not both. Not three options.

---

## Trust device rules

- **Once per sequence, not per touch.** First touch can use a trust device. Don't repeat it on touches 2/3.
- Trust devices come from the archetype's `trust_devices` field (`../../icp/archetypes/<id>_*.md`).
- Don't stack — one device per message.

---

## Signal-recency handling

- Signal age < 30 days: open with it directly.
- Signal age 30–90 days: open with it, acknowledge timing ("noticed back in [month]...").
- Signal age > 90 days: DO NOT use as an anchor. Find a fresher signal or skip this contact.

---

## Citation rule (from `../../content/platform_adaptation/global.md`)

- Every Supersonik-specific claim must trace to a sourced research file (`../../../00_index.md` … `../../../12_icp.md`).
- Category benchmarks are fair game with attribution (e.g. "interactive demos +32%, RevenueHero 2025").
- Never invent customer names, ARR, demo counts, conversion lifts.

---

## Voice override priority

If a voice-specific rule (from `../../content/voices/<voice>.md`) conflicts with a rule here, **the voice rule wins for that voice**. Voice files own the personal-style override.

Exception: hygiene rules + anti-slop kill list NEVER get overridden. They're absolute.

---

## Validation checklist

Before any message gets written:

- [ ] Loads `../../content/platform_adaptation/global.md` rules
- [ ] Loads channel-specific rules (`email_composition_rules.md` or `linkedin_composition_rules.md`)
- [ ] Loads selected voice
- [ ] Loads archetype detail file
- [ ] Anchored in a specific signal
- [ ] One ask
- [ ] No banned words / patterns
- [ ] Trust device count ≤ 1 for this sequence
- [ ] Word count within channel rules
- [ ] No fabricated Supersonik-specific claims
