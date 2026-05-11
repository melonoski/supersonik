---
command: /linkedinpost
description: Generate an authentic LinkedIn post using an established brand voice.
---

# /linkedinpost

Run the full LinkedIn post creation workflow. Source of truth: `gtm/workflows/linkedinpost.md`.

## Step order (locked — do not reorder)

1. **Select voice** — list `gtm/content/voices/*.md` (exclude `_template.md`), show full names + titles, capture choice as `post.voice_id`. Load the selected voice file into context.
2. **Choose content pillar** — read the "Topics & Content Pillars" table from the selected voice file, show pillars + engagement signals, capture choice as `post.content_pillar`.
3. **Gather ideas** — prompt "What ideas, angles, or recent context do you want to explore in this post?" Accept multi-line input. Store as `post.ideas`.
4. **Generate post draft** — always load `gtm/content/platform_adaptation/global.md` (hygiene + anti-slop) first, then `gtm/content/platform_adaptation/linkedin.md`. Use the voice's Post Structure (LinkedIn), Tone Markers, Replicable Post Templates, Formatting Rules, and Anti-patterns. Match pillar to a template skeleton where applicable. Under 200 words, short paragraphs, hook in line 1, no body links.
5. **Validate & output** — run the checklist (voice tone, anti-slop, LinkedIn format, hook/body/CTA). Report pass/fail per check. On fail, offer regenerate (loop to step 3) or output as-is.

## Outputs

- Final post (plain text, ready to paste into LinkedIn composer).
- Header: `Post generated for [Voice Name] • [Content Pillar] • [Date]`.

## Rules

- Use only sourced claims (see `gtm/content/platform_adaptation/global.md`).
- Match the chosen voice; respect `content/voices/<voice>.md` anti-patterns.
- Never invent metrics, customers, or dates.
- Do not skip validation silently — always report check results before final output.
