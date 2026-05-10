---
file: campaign_types
types:
  - id: outbound
    name: "Outbound"
    description: "Fill the sales pipeline."
    prompt: "Generate cold outreach to a target prospect. Anchor in a specific signal about the prospect's company. Lead with the archetype's pain → value mapping (see archetype detail file). One ask: a 15-minute conversation or a click-through to a relevant demo/case. Reference at most one trust device per sequence (see archetype trust_devices). Stay terse, peer-to-peer, no fluff."
    primary_signals: [1, 2, 5, 6, 8, 9, 10, 11, 12]
    typical_tier_mix: "T1: 70%, T2: 20%, T3: 10%"
  - id: awareness
    name: "Awareness"
    description: "Introducing your company and value proposition. Soft touch generic mass mailing."
    prompt: "Generate a soft-touch awareness message introducing Supersonik. Open with the why-now triplet (LLM capability + voice latency + GTM cost pressure). Keep the value-prop reference high-level — point them to a category-benchmark stat from `../../04_industry.md`. No hard CTA — invite a reply if curious. Under 80 words for email; under 60 for LinkedIn DM."
    primary_signals: []
    typical_tier_mix: "T1: 80%, T2: 0%, T3: 20% (broad)"
  - id: feedback
    name: "Feedback"
    description: "Gathering direct feedback on products, pricing, or messaging from the target market."
    prompt: "Generate a feedback-request message. Be explicit: not selling, asking for 10–15 minutes of their take on [topic]. Reference what makes them a relevant voice (title, prior post, company stage). Offer something in return — share findings, a curated peer benchmark, or simply a thank-you. No pitch, no demo, no product mention beyond context."
    primary_signals: []
    typical_tier_mix: "T1: 60%, T2: 20%, T3: 20% (depends on what's being researched)"
  - id: event_promotion
    name: "Event Promotion"
    description: "Driving registrations for meeting at an upcoming event, webinars, conferences, or product launches."
    prompt: "Generate an event-promotion message. Lead with the event name + date + the specific reason this person should attend (their geo, their role, their topical interest). Make the ask concrete: register here, or meet at the event. If meeting in person, propose a specific time slot or coffee. Include event hook (speaker, theme, peer attendees) but stay under 100 words."
    primary_signals: [11]
    typical_tier_mix: "Mix depends on event audience"
  - id: event_post
    name: "Event Post"
    description: "Warm leads (reference voice and invite to follow up on the conversation, get notes from CRM), cold leads outbound with event reference."
    prompt: "Two variants needed. WARM: reference the specific conversation at the event (pull from CRM notes). Acknowledge what they said. Propose the agreed next step. UNDER 75 words. COLD: reference the event itself + a specific session/theme + why they'd care. Open with the event mention, not the pitch. Same anti-slop + voice rules apply."
    primary_signals: [11]
    typical_tier_mix: "Mix depends on event audience"
  - id: customer_winback
    name: "Customer Win-Back"
    description: "Re-engaging former customers with new offers or updates to resume a business relationship."
    prompt: "Generate a re-engagement message for a churned/lapsed customer. Acknowledge their prior relationship without rehashing why they left. Reference what's *new* since they last engaged (product update, new use case, peer success in their segment). One ask: a 15-minute catch-up. No discount-led copy unless explicitly authorized. Pull contract history from CRM if available."
    primary_signals: []
    typical_tier_mix: "All tiers — depends on churn cohort"
---

# Campaign Types

6 types. Each has a `prompt` field that feeds directly into message generation (see `messages/_generation_flow.md`). Edit the frontmatter to update — table below mirrors it.

| ID | Name | Description |
|---|---|---|
| `outbound` | Outbound | Fill the sales pipeline |
| `awareness` | Awareness | Introducing the company and value proposition. Soft touch mass mailing |
| `feedback` | Feedback | Gathering direct feedback on products, pricing, or messaging |
| `event_promotion` | Event Promotion | Driving registrations for meetings at an event, webinar, conference, or launch |
| `event_post` | Event Post | Warm (reference conversation, CRM notes) + cold (event reference) variants |
| `customer_winback` | Customer Win-Back | Re-engaging former customers with new offers or updates |

## Choosing a type

| If you want to... | Pick |
|---|---|
| Generate net-new pipeline from cold prospects | `outbound` |
| Mass-introduce the company to a soft list | `awareness` |
| Get product/pricing/positioning feedback from buyers | `feedback` |
| Drive event registrations | `event_promotion` |
| Follow up after an event (warm or cold variants) | `event_post` |
| Bring back churned customers | `customer_winback` |

## How the `prompt` field is used

When `/create-campaign` reaches step 7 (generate messages), the selected type's `prompt` becomes one of the generation inputs (see `messages/_generation_flow.md`). It tells the generator the *intent* of the message — the rest (voice, archetype, signals) shape the *form*.

## Adding a new type

1. Add a new entry to the frontmatter `types:` array.
2. Update the table above.
3. Update `messages/_generation_flow.md` if the new type needs special inputs.
