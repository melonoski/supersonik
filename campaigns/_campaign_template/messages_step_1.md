---
step: 1
channel: "<email | linkedin>"
delay_days: 0
campaign: "<campaign_name>"
generated_at: null
status: "draft"
---

# Step 1 Messages

Generated per-contact messages for step 1 of the sequence. One section per contact.

---

## <Contact Full Name> — <Company>

**Archetype:** <id> (<name>)
**Signal anchor:** <signal_type — when_occurred>

**Subject:** <subject line>

> <message body>

---

## Generation source

- Composition rules: `../messages/global_composition_rules.md` + `../messages/<channel>_composition_rules.md`
- Hygiene: `../../content/platform_adaptation/global.md`
- Voice: `../../content/voices/<voice>.md`
- Archetype: `../../icp/archetypes/<id>_<name>.md`
- Campaign prompt: `../campaign_types.md` → type `<type>`
- Signals: per-contact from `signals` table
