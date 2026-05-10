---
workflow: linkedinpost
trigger: /linkedinpost
phase: v1_content_creation
---

# Workflow #2 — Create LinkedIn Post

Generate authentic LinkedIn posts using established brand voices. This workflow guides you through selecting a voice, choosing a content pillar, gathering ideas, and producing a post that follows voice guidelines and LinkedIn platform rules.

---

## Step order (locked)

```
1. Select voice
2. Choose content pillar
3. Gather ideas
4. Generate post draft
5. Validate & output
```

---

## Step 1 — Select voice

- **Source:** `content/voices/*.md` (list all voice files except `_template.md`)
- **Action:** Display available voices with their full names and titles. User selects one.
- **Output:** `post.voice_id` set (e.g., `dani_carmona`). Load the selected voice file into context for all downstream steps.

## Step 2 — Choose content pillar

- **Source:** "Topics & Content Pillars" section from selected voice MD file (table format)
- **Action:** Display the pillars with engagement signals. User selects one.
- **Output:** `post.content_pillar` set (e.g., "AI Agent", "GTM Strategy"). Extract pillar name for step 4 reference.

## Step 3 — Gather ideas

- **Source:** User input (free-form text)
- **Action:** Prompt "What ideas, angles, or recent context do you want to explore in this post?" Accept multi-line input.
- **Output:** `post.ideas` captured as raw text block. This becomes the seed for post generation.

## Step 4 — Generate post draft

- **Source:** 
  1. Selected voice file (entire MD, prioritize: Post Structure (LinkedIn), Tone Markers, Replicable Post Templates, Formatting Rules, Anti-patterns)
  2. `content/platform_adaptation/global.md` (hygiene + anti-slop — always required)
  3. `content/platform_adaptation/linkedin.md` (LinkedIn-specific format rules)
  4. `post.content_pillar` + `post.ideas` from prior steps
- **Action:** Generate a draft post that:
  - Follows the voice's hook patterns (first line), body structure, and CTA patterns
  - Incorporates all ideas provided by user into the post body
  - Respects all formatting rules (line breaks, emoji usage, bold/italics per voice)
  - Avoids all anti-slop patterns (global + voice-specific)
  - Adheres to LinkedIn rules: under 200 words, short paragraphs (1–2 sentences max), hook in line 1, no body links
  - Uses a Replicable Post Template as skeleton where applicable (match pillar to template name)
- **Output:** Draft post (plain text, ready to copy/paste to LinkedIn). Include header: `Post generated for [Voice Name] • [Content Pillar] • [Date]`

## Step 5 — Validate & output

- **Source:** Generated post + voice file + global rules + LinkedIn rules
- **Action:** Run validation checklist:
  - Does it match the voice tone? (Check against Tone Markers + Example Posts)
  - Does it avoid anti-slop? (Check Anti-patterns section + global.md)
  - Does it follow LinkedIn format? (Check Formatting Rules + linkedin.md)
  - Is it actionable? (Contains hook, body, CTA pattern from voice)
  - Report pass/fail on each check
- **Gate:** If validation fails, offer to adjust ideas and regenerate (loop back to Step 3) or skip validation and output as-is
- **Output:** Final post ready to paste into LinkedIn composer, or regenerate option

---

## Failure handling

- **Voice not found:** Validate voice exists in `gtm/content/voices/`. If not, re-prompt Step 1.
- **Content pillar not found:** Validate pillar exists in voice file's table. If table missing, alert user and suggest updating voice file first.
- **Ideas missing:** Allow empty ideas block (user can proceed with pillar alone); regenerate will work but post may be more generic.
- **Incomplete voice file:** If voice file missing required sections (Post Structure, Tone Markers, Formatting Rules, Anti-patterns), alert user and defer to voice file maintenance.
- **Validation failures:** Show which checks failed. Do not block output — offer regenerate loop or proceed as-is.
