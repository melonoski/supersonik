---
file: tiers
source: ../../12_icp.md
tiers:
  - id: 1
    name: "PRIMARY — High-velocity mid-market B2B SaaS with multilingual demand"
    weight_pct: 70
    arr_band: "$5M–$50M"
    employees: "50–500"
    hq: "US (Bay Area, NY, Boston) or Western Europe (London, Berlin, Amsterdam, Paris, Barcelona, Madrid)"
    sales_motion: "Inbound-heavy with active outbound. Demo is the core conversion event."
    acv: "$5K–$50K"
    funding_stage: "Series A through C; post-PMF, pre-mega-scale"
    cadence_shape: "4 touches over 14–21 days. Email + LinkedIn interleaved."
    channel_mix:
      outbound: 60
      founder_voice: 20
      abm: 10
      seo: 10
  - id: 2
    name: "SECONDARY 1 — Enterprise SaaS scaling internationally"
    weight_pct: 20
    arr_band: "$50M–$500M+"
    employees: "500–5,000"
    hq: "Multi-country, with active expansion into LatAm, EU, APAC"
    sales_motion: "Established regional sales orgs with VP Sales per region."
    acv: "$100K–$500K+"
    funding_stage: "Late stage / public; real procurement; legal review; SOC2/GDPR scrutiny"
    cadence_shape: "6 touches over 6 weeks. More personalization per touch. First touch often founder LinkedIn message."
    channel_mix:
      abm: 50
      founder_voice: 25
      partnership: 25
  - id: 3
    name: "SECONDARY 2 — Fast-growth AI / dev-tool SaaS with demo bottleneck"
    weight_pct: 10
    arr_band: "$5M–$30M, growing 3x+ YoY"
    employees: "30–200"
    hq: "US (esp. Bay Area, NY) or Europe (London, Berlin, Paris, Barcelona)"
    sales_motion: "Product-led or hybrid; technical product requires walkthrough"
    acv: "varies; willing to pilot fast"
    funding_stage: "Backed by tier-1 VCs (a16z, Sequoia, Benchmark, Founders Fund, Index, Accel)"
    cadence_shape: "4 touches over 14–21 days. Lighter and more personalized; many come inbound from founder content."
    channel_mix:
      founder_voice: 50
      product_led_trial: 30
      outbound: 20
---

# Tier Table

Source: `../../12_icp.md` (full ICP research). Edit the frontmatter to update the data — the table below is a human-readable mirror.

| Tier | Name | Weight | ARR | Employees | ACV | Cadence shape |
|---|---|---|---|---|---|---|
| 1 | PRIMARY — High-velocity mid-market B2B SaaS with multilingual demand | 70% | $5M–$50M | 50–500 | $5K–$50K | 4 touches / 14–21 days |
| 2 | SECONDARY 1 — Enterprise SaaS scaling internationally | 20% | $50M–$500M+ | 500–5,000 | $100K–$500K+ | 6 touches / 6 weeks |
| 3 | SECONDARY 2 — Fast-growth AI / dev-tool SaaS with demo bottleneck | 10% | $5M–$30M (3x+ YoY) | 30–200 | Varies (fast pilot) | 4 touches / 14–21 days |

## Tier filters (firmographics — for `account` ingestion)

| Filter | Tier 1 | Tier 2 | Tier 3 |
|---|---|---|---|
| ARR | $5M–$50M | $50M–$500M+ | $5M–$30M (3x+ YoY) |
| Employees | 50–500 | 500–5,000 | 30–200 |
| HQ | US / Western Europe | Multi-country, expanding | US / Europe |
| Funding stage | Series A–C | Late / public | Tier-1 VC backed |
| ACV | $5K–$50K | $100K–$500K+ | Varies |

## Channel mix by tier

| Channel | Tier 1 | Tier 2 | Tier 3 |
|---|---|---|---|
| Outbound (email + LinkedIn) | 60% | 20% | 20% |
| Founder voice | 20% | 25% | 50% |
| ABM (gifting, direct mail, ads) | 10% | 50% | 0% |
| Pain-point SEO / content | 10% | 5% | 30% (community + sandbox) |
| Partnership / a16z portfolio | 0% | 25% (formal) | 20% (informal) |

## Signals per tier

See `../../12_icp.md` "Signal inventory" for the full 12-signal library. Quick reference:

- **Tier 1 cadences:** signals 1–6 and 9–12 (funding, hiring SE, multilingual landing pages, demo form, competitor stack, G2 reviews, open AE reqs, founder-post engagement, web intent).
- **Tier 2 cadences:** signals 2, 3, 4, 8, 11, 12 (hiring, international expansion press, multilingual sites, new CRO, founder-post engagement, reverse-IP).
- **Tier 3 cadences:** signals 1, 7, 11 (funding, product launch, founder-post engagement).

## Anti-ICP (not now)

See `../../12_icp.md` "Anti-ICP" section. Tag as **`Not-Now`** in CRM with quarterly review trigger.
