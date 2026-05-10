---
file: linkedin_composition_rules
applies_to: linkedin_dms + linkedin_posts (outbound context)
parent_rules: global_composition_rules.md
channel_rules: ../../content/platform_adaptation/linkedin.md
---

# LinkedIn Composition Rules

Layer on top of `global_composition_rules.md` + `../../content/platform_adaptation/linkedin.md`. This file defines the specifics of outbound *LinkedIn* — direct messages primarily, with notes on outbound-context posts.

---

## DM rules

### Length

- **Under 75 words.** DMs longer than that get bounced or ignored.
- **Connection request note:** always empty

### Structure

- **First line is the hook.** Same rule as email — a specific reference to the recipient (signal, post they wrote, company action).
- **No greeting filler.** Skip "Hope this finds you well" — start with the anchor.
- **One ask per DM.** Same as email.
- **No links in the first DM.** Save them for the second message after a reply.

```
<Signal-anchored opener — 1 sentence>

<Why this matters in their context — 1 sentence>

<Light ask — 1 sentence>
```

### Connection request notes (CR)

Always empty

```

### Follow-up DMs (after they accept/reply)

- Match their register.
- Drop the connection-request anchor — they already saw it.
- One concrete next step: 15-min call, link to a specific resource, intro to a teammate.

---

## Post rules (when posting outbound-style content)

Most LinkedIn rules live in `../../content/platform_adaptation/linkedin.md`. For outbound-context posts:

- **Tag selectively.** Don't tag the prospect's whole company in a "we'd love to work with X" post — feels desperate.
- **Soft mention** is OK: "Companies like [X] are doing this right" with no @ tag — gets the algorithm boost without the cringe.
- **Hook in line 1.** Same as DMs.
- **No links in body.** Drop the link in first comment.

---

## Voice consistency

For voices with heavy emoji patterns (e.g. Dale Boltaev):
- DMs may use 1 functional emoji at the open (🚀, 🇺🇸, etc.) — match the voice file.
- Cold DMs from non-emoji-heavy voices (e.g. Dani Carmona) stay emoji-free.

For voices that use "we" vs "I":
- Default DM is first-person singular ("I").
- Founder/co-founder voices may override to "we" if voice file specifies.

---

## Signal-anchored DM opens (by signal type)

| Signal | DM open shape |
|---|---|
| 8 — New CRO tenure <6 mo | "Saw you started as [title] at [company] in [month] — congrats. Curious what's at the top of your pipeline math." |
| 11 — Founder-post engagement | "Noticed you engaged with [Dani's / Lechà's] post on [topic]. Worth a quick chat?" |
| 1 — Series A/B/C in last 90 days | "Saw the [round] news — congrats. The next bottleneck after a round is usually demo capacity. Worth comparing notes?" |
| 7 — Product launch | "Saw your [product] launch. The post-launch demand surge usually exposes the demo-capacity gap fast." |

---

## Length validation

```
word_count(dm_body) <= 75
char_count(connection_request_note) <= 300
```

If a draft exceeds the cap, cut — don't water down.

---

## Examples

### Cold DM — founder-post engagement signal, Hugo the GTM Engineer

```
Saw you reacted to Carmona's post on AI demos. We expose every conversation
event + qualification field as a webhook — figured you'd want to see the schema.

Happy to send if useful.

— [First name]
```

### Connection request — new CRO tenure signal, Alex the CRO

```
Saw you started as CRO at [Company] in March — congrats. Curious how you're
thinking about demo capacity at this stage. Worth connecting?
```

### Follow-up DM — after accepted connection, Iris the Head of Growth

```
Thanks for connecting. Saw your post last week on funnel experiments — we just
ran a 4-week pilot with [peer company] that lifted form-to-meeting by 2.8pp.
Want me to send the writeup?
```
