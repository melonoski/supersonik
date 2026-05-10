---
file: scoring_placeholder
phase: v2_stake
status: design_only_no_implementation
---

# Scoring — Architecture Stake (v2)

> **v1 status:** not implemented. This file documents the design so the schema + workflow can absorb scoring cleanly when v2 ships.

## Purpose

Translate scattered signals into a single per-account score so outbound + nurture + ads can route activity to the right accounts at the right time.

## Inputs

- Rows in `signals` table (see `../../db/schema.md`).
- 12 signal types from `../../../12_icp.md` "Signal inventory."
- Account context: `accounts.tier`, `accounts.employees`, `accounts.arr_band`.

## Output

One row per account in `signal_scores`:

```
signal_scores
├── id
├── account_id (FK)
├── score             (numeric, e.g. 0–100)
├── weights (JSON)    (per-signal contribution breakdown)
└── updated_at
```

## Weighting model (initial design)

Each signal type has a **base weight** and **modifiers** based on account context. Recent signals weight more (recency decay). Stale signals drop out after a window.

### Base weights per signal type (illustrative — calibrate empirically in v2)

| # | Signal | Base weight | Notes |
|---|---|---|---|
| 1 | Series A/B/C in last 90 days | 8 | Strong intent + budget |
| 2 | Hiring SE / Demo Engineer / Intl SDR | 9 | Capacity pressure is acute |
| 3 | International expansion press | 7 | Tier 2 / Tier 1 multilingual |
| 4 | Multilingual landing pages (≥3 langs) | 6 | Standing signal (less time-sensitive) |
| 5 | Demo form on homepage | 5 | Common — modifier-dependent |
| 6 | Competitor stack (Walnut/Storylane/Reprise) | 8 | Direct displacement opportunity |
| 7 | Product launch announcement | 7 | Demand spike incoming |
| 8 | New CRO/VP Sales tenure <6 mo | 9 | Wants-to-make-mark window |
| 9 | G2 negative review on demo experience | 10 | Direct pain admission |
| 10 | Open SDR/AE reqs > 5 | 7 | Pipeline scaling |
| 11 | Founder-post engagement | 6 | Warm-warm angle |
| 12 | Site visit from named account | 8 | Web intent |

### Context modifiers (illustrative)

| Modifier | Effect |
|---|---|
| `employees > 100` | +2 to base weight (more pipeline volume) |
| `employees < 100` | -2 (smaller motion) |
| `tier = 1` | +1 (primary segment) |
| `tier = 2 AND signal in [3, 4, 8]` | +2 (T2-relevant signals) |
| Account already in active campaign | -3 (avoid stacking) |

### Recency decay

```
effective_weight = base_weight * exp(-days_since_signal / half_life_days)
```

Default `half_life_days = 30`. Signals older than 90 days drop to <10% effective weight.

### Total score

```
score = sum(effective_weight) across all active signals on the account
      (capped at 100 if you want bounded scores; or unbounded)
```

## Update triggers

Recompute on:
1. New signal ingested for an account.
2. Daily batch (recency decay).
3. Account tier/firmographic change.

## Workflow integration (v2)

| Workflow | How it uses score |
|---|---|
| `/create-campaign` (lead list) | Optionally filter `campaign_leads` by `signal_scores.score >= N` |
| Signal-driven cadence triggers | Auto-enroll high-score accounts in appropriate cadence by archetype |
| Slack alerts (also v2) | Notify AE owner when score crosses threshold |

## Open questions for v2

- Boundedness: cap at 100 (intuitive but compresses high signal density) or unbounded (precise but harder to threshold)?
- Per-tier score thresholds: Tier 1 likely needs lower threshold than Tier 2 (fewer raw signals per account).
- Decay half-life: 30 days assumed — validate empirically.
- Anti-signal handling: should a signal like "G2 positive review of competitor" *decrease* the score?

## Out of scope (until v2)

- Implementation (no code).
- Signal ingestion automation (manual SQL inserts only in v1).
- Slack alerting (deferred along with Workflow #2).

When v2 starts: convert this file into `scoring_model.md` with the calibrated weights and add `scoring_rules.yml` for runtime config.
