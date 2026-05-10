---
file: email_composition_rules
applies_to: outbound_email
parent_rules: global_composition_rules.md
channel_rules: ../../content/platform_adaptation/email.md
---

# Email Composition Rules

Layer on top of `global_composition_rules.md` + `../../content/platform_adaptation/email.md`. This file defines the specifics of outbound *email* — subject lines and body composition.

---

## Subject line rules

- **Length:** 4–7 words.
- **Case:** Lowercase preferred (matches inbox visual register; not gimmicky).
- **No clickbait.** No questions you immediately answer. No "Re:" or "Fwd:" fake-thread tricks.
- **Anchor in the signal, not the product.** Examples:
  - ✅ "open SE roles → quick question"
  - ✅ "your Series B + demo capacity"
  - ❌ "AI demos for your company"
  - ❌ "10 minutes to talk?"
- **One concept per subject.** Not "Series B & multilingual launches & demo capacity."
- **No emoji** in subject line for cold outbound. Reserved for warm/in-thread replies.

---

## Body rules — cold outbound

- **Word count:** under 100 words.
- **Paragraphs:** 1–3 sentences each. Max 4 paragraphs total.
- **First person singular:** "I", not "we." (Founders/co-founders may override to "we" if voice file specifies — see voice override priority in `global_composition_rules.md`.)
- **Reference something specific in line 1.** A signal. A post. A company action.
- **One ask.** A 15-minute conversation. Or a click-through. Not both.
- **No links in cold email.** Save them for follow-ups. Use the conversation ask.
- **Signature:** name + role + (optional) one-line company tagline. No banners, no logos, no quotes.

### Structure (cold)

```
Subject: <4–7 words, lowercase, signal-anchored>

<Signal-anchored opener — 1 sentence>

<Why this matters in their context — 1–2 sentences>

<How Supersonik addresses it (tied to archetype.what_lands) — 1–2 sentences>

<One ask — 1 sentence>

— <First name>
```

---

## Body rules — warm outbound

- **Word count:** under 150 words.
- **Reference the prior touch** in the first line.
- **Acknowledge what they did/said** (engaged with a post, attended an event, asked a question).
- **Still one ask.** Not "and also."

---

## Reply emails

- **Mirror their length.** 3 sentences → 3 sentences.
- **Drop the formality.** Match their register.
- **Keep moving the conversation forward** — propose a specific next step.

---

## Signal-anchored opens (by signal type)

Map to the 12-signal inventory in `../../../12_icp.md`. Examples:

| Signal | Opening line shape |
|---|---|
| 1 — Series A/B/C in last 90 days | "You announced your [round] last [month]. The first thing every [round]-stage SaaS underestimates is..." |
| 2 — Hiring SE/Demo Engineer | "Your careers page has [N] SE openings. [Specific implication]." |
| 4 — Multilingual landing pages | "You're running landing pages in [N] languages. The demo behind those pages is still English-only..." |
| 5 — Demo form on homepage | "Your homepage demo button still routes through a [N]-step form. [Cited category benchmark]." |
| 6 — Competitor stack | "Noticed you're running [competitor] for demos. The piece [competitor] can't do is..." |
| 8 — New CRO tenure <6 mo | "Saw you started as [title] at [company] in [month]. Curious what's at the top of your pipeline math right now." |
| 11 — Founder-post engagement | "Saw you engaged with [Dani's / Lechà's] post on [topic]. [Light invitation]." |

---

## Length validation

```
word_count(body) <= 100   # cold
word_count(body) <= 150   # warm
```

If a draft exceeds the cap, cut a paragraph before sending. Don't water down — cut.

---

## Examples (template form, fill from generation)

### Cold — Series B signal, Alex the CRO

```
Subject: your series b + demo capacity

You announced your Series B last month. The first thing every Series B SaaS
underestimates is how fast demo capacity becomes the pipeline bottleneck.

We work with mid-market SaaS that hit this wall — Supersonik runs the live demo
of your real product in the prospect's language, on day one of a new market.

a16z portfolio companies are already using us this way.

Worth 15 minutes to share what we're seeing?

— [First name]
```

### Cold — Hiring SE roles, Felix the Regional VP

```
Subject: 4 SE openings in iberia

Saw 4 open SE roles in Iberia on your careers page. The 9-month SE ramp is
brutal for a regional VP — corporate gives you half the budget you ask for.

We work with regional VPs in your exact shape — Supersonik runs the demo
coverage so your bench isn't gating high-intent inbound in Spanish-speaking
markets.

Worth a 15-min call to share what 2 of your peers are doing?

— [First name]
```
