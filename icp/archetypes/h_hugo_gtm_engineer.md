---
id: h
tier: 3
name: "Hugo the GTM Engineer"
role_category: "Implementator"
title: "GTM Engineer / RevOps Lead at AI SaaS"
what_they_own: "The data layer at an AI-native company"
pains:
  - "Already runs Clay + Apollo + custom enrichment"
  - "Wants Supersonik to plug into the existing stack cleanly"
  - "Hates abstraction — wants direct API access to everything"
what_they_read:
  - "GTM Engineering blog (Clay)"
  - "Modern Sales Pros"
  - "AI Twitter for tooling threads"
  - "Specific Slack communities (RevOps Co-op, GTM-engineer groups)"
what_lands: "Technical content, integration documentation, founder-engineering credibility. APIs, not 'platforms.'"
trust_devices: ["Pol Ruiz CUDA/inference background", "Open API surface", "Clear technical documentation"]
value_prop: "Hugo plugs Supersonik into his existing stack with direct API calls — no platform lock-in, no bloated 'integration partner' setup. The agent writes back to his data layer the way he wants, via the schemas he controls."
linkedin_signals:
  - "Public mentions of Clay / Apollo / custom enrichment"
  - "GitHub activity in GTM-engineering tooling"
  - "Posts about specific signals / scoring / routing problems"
common_objections:
  - objection: "Is the API actually open?"
    response: "Yes — REST + webhook events. Authentication via API key. Full event schema published."
  - objection: "How do you handle our custom field model?"
    response: "Map your fields once in the config; agent writes to them. No proprietary schema."
---

# Hugo the GTM Engineer

T3 Implementator — GTM engineer / RevOps at AI SaaS. Already runs Clay + Apollo + custom enrichment. Hates abstraction; wants direct API access.

## What they own

The data layer at an AI-native company. Builds the plumbing: enrichment workflows, signal pipelines, routing, scoring, the lead-to-CRM path. Codes in Python / SQL / sometimes a bit of TypeScript.

## Pain

- Already runs Clay + Apollo + custom enrichment. The stack is patchwork.
- Wants Supersonik to plug into the existing stack cleanly — no "you have to use our platform for everything" lock-in.
- Hates abstraction. Wants direct API access to events, transcripts, qualification fields.

## What they read

GTM Engineering blog (Clay), Modern Sales Pros, AI Twitter for tooling threads, RevOps Co-op + GTM-engineer-specific Slack communities. GitHub repos for tooling.

## What lands in copy

Technical content, integration documentation, founder-engineering credibility. **APIs, not "platforms."** Real schemas. Sample webhook payloads. "Here's exactly how the data flows."

## Value prop (Supersonik → Hugo)

Hugo plugs Supersonik into his existing stack with direct API calls — no platform lock-in, no bloated "integration partner" setup. The agent writes back to his data layer the way he wants, via the schemas he controls. He stays in charge of the stack.

## Trust devices

- Pol Ruiz — CUDA/inference background. Speaks Hugo's language.
- Open API surface (REST + webhooks).
- Clear, public technical documentation.

## LinkedIn signals to look for

| Signal | Source | Why it matters |
|---|---|---|
| Public mentions of Clay / Apollo / custom enrichment | LinkedIn posts | Already invested in the modern stack |
| GitHub activity in GTM-engineering tooling | GitHub | Builder-mode signal |
| Posts about signals / scoring / routing problems | LinkedIn | Topical interest |
| Engagement with Lechà / Ruiz / Carmona posts | LinkedIn API | Warm-warm angle |

## Common objections + how to handle

- **"Is the API actually open?"**
  - Yes — REST + webhook events. Authentication via API key. Full event schema published.
- **"How do you handle our custom field model?"**
  - Map your fields once in the config; agent writes to them. No proprietary schema.
- **"Can I self-host?"**
  - Not in v1. Cloud-hosted only. SOC 2 + GDPR posture available for review.

## Example signal-anchored opens (3)

1. **Clay user (public mention)** — "Saw [Company] in the Clay customer list. Curious how you're handling the gap between Clay's enrichment and demo-time routing — that's the exact gap we close."
2. **Post on signals / scoring** — "Caught your post on signal weighting last week. We expose every conversation event + qualification field as a webhook — happy to send the schema."
3. **GitHub repo activity** — "Saw [repo name] — guessing the demo-to-CRM handoff is on the list. Want to walk through how Supersonik's webhooks plug into that workflow."
