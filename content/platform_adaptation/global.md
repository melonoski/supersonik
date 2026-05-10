---
file: global_platform_adaptation
applies_to: all_channels
sources:
  - ../../../00_index.md (hygiene rules)
  - ../../../todo/09-voice-dna-content.md (anti-slop)
---

# Global Content Rules

**Read this file before generating any outbound or content.** It contains the hygiene rules and anti-slop kill list that apply across every channel (email, LinkedIn DM, LinkedIn post, blog).

The principle: **your voice stays the same. The format changes per platform.** Voice rules live in `content/voices/<person>_voice.md`. Per-channel format rules live in this folder's other files.

---

## Hygiene rules (from `../../../00_index.md`)

These are the claim-tracing rails. Apply them on every generated piece.

1. **Every Supersonik-specific claim must trace to a sourced URL in the research files (`../../../00_index.md` through `../../../12_icp.md`).** If the claim isn't in one of those files, don't write it.
2. **Category benchmarks are fair game** (e.g. "interactive demos +32%", "75% rep-free preference") as long as attributed to the source.
3. **Founder quotes are quoted verbatim, with citation.** Don't paraphrase inside quotation marks.
4. **Never invent customer names, ARR, demo counts, or conversion figures.** Use category-benchmark fallbacks from `../../../04_industry.md` instead.
5. **The "why now" triplet** = LLM capability + voice latency + GTM cost pressure. Repeat consistently across copy.

### What's intentionally NOT public (do NOT speculate)

| Topic | Why off-limits |
|---|---|
| Pricing | Not public — site says "Talk to Sales" |
| SOC 2 / GDPR posture | Not publicly documented |
| Specific customer logos | "Leading SaaS companies" is the strongest public statement |
| Underlying tech stack (LLMs, voice provider) | Undisclosed |
| Specific ARR / demo volume / conversion lift | No published Supersonik numbers |
| Carmona's full prior-company list | Only YC + Unioncrate are consistently sourced |

---

## Anti-slop kill list

### Words to ban

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

### Patterns to ban

- **"In today's [anything]..."** — delete the whole sentence. Start with the point.
- **"Let me be clear:"** — just be clear. You don't need to announce it.
- **"Here's the thing:"** — used sparingly and only if it's actually your voice. Most people don't talk like this.
- **Opening with a question you immediately answer** — "What if I told you..." No.
- **Three em dashes in one paragraph** — unless that's genuinely how you write.
- **Ending every section with a one-sentence power line** — the most detectable AI pattern on LinkedIn right now.

### Outbound-specific anti-patterns

- ❌ "Hope this finds you well" / "Quick question" / "Following up"
- ❌ Generic value-prop dump in line 1 — no anchor
- ❌ Multiple CTAs ("call OR demo OR whitepaper?")
- ❌ Stat without source attribution
- ❌ "I noticed your company is in [VERY-COMMON-INDUSTRY]" — too vague
- ❌ Calling out a signal that's already 90+ days old without acknowledgment
- ❌ Using a Tier-2 signal in a Tier-1 cadence (and vice versa) — wrong scale framing
- ❌ Mixing archetypes mid-cadence (start as Alex, switch to Carla on touch 3)
- ❌ Trust devices on every touch — once per sequence is enough

---

## Voice rules (high-level — voice files own the details)

- Terse. No fluff. No rage-bait. No "great choice" energy.
- Operator-direct. Peer-to-peer, not vendor-to-buyer.
- First person singular ("I") for outbound emails. "We" for company-voice LinkedIn posts.
- Reference something specific about them in every cold message. Not "I saw your company is growing" — that's generic. "I saw you hired 3 AEs in the last month" — that's a signal.

---

## The test

Read the generated content out loud. If you wouldn't say it to a colleague over coffee, rewrite it.

---

## Where to go next

- Channel-specific format rules: `linkedin.md`, `email.md`, `blog.md` in this folder.
- Voice-specific rules: `../voices/<person>_voice.md`.
- Message composition (outbound copy rules per channel): `../../campaigns/messages/`.
