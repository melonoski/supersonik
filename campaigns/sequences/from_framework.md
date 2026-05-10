---
mode: from_framework
input: framework_id (from frameworks/frameworks_list.md)
output: sequence.yml (conforming to _schema.yml)
---

# Mode 1 — Sequence from Framework

Generate a sequence by deriving steps from a stored framework's `sequence_steps`.

## When to use

- A framework has been chosen at step 2 of `/create-campaign`.
- The framework has well-defined `sequence_steps` (step / channel / delay_days / ask).
- You want the framework's cadence and messaging guidance applied directly.

## Procedure

1. Load `frameworks/frameworks_list.md` and extract the framework's `sequence_steps` array.
2. Validate against `_schema.yml`:
   - Steps numbered 1..N
   - Channels are `email` or `linkedin`
   - delay_days >= 0
3. Inherit the framework's `messaging_guidelines` and `title_guidelines` as inputs to step 7 of `/create-campaign` (message generation).
4. Write the sequence YAML to `campaigns/<campaign_name>/sequence.yml`.
5. Reference the resulting file in `campaign.md` (`sequence: ./sequence.yml`).

## Example

If the framework is "Sara Wilson — Multi-thread B2B Cold (2025)" with:

```yaml
sequence_steps:
  - step: 1
    channel: email
    delay_days: 0
    ask: "Signal-anchored open + 15-min call ask"
  - step: 2
    channel: linkedin
    delay_days: 1
    ask: "Light DM referencing email"
  - step: 3
    channel: email
    delay_days: 3
    ask: "Peer reference bump"
  - step: 4
    channel: email
    delay_days: 4
    ask: "Soft break-up"
```

The derived sequence inherits all 4 steps and feeds the framework's `messaging_guidelines` into message generation at step 7.

## Output validation

After generating, re-validate against `_schema.yml`. Reject if:
- Any step has invalid channel
- delay_days is negative
- Steps are not 1-indexed and contiguous

## CRM actions

Default CRM actions:

```yaml
crm_actions:
  - on_send: log_to_crm
  - on_reply: log_to_crm
  - on_no_reply_after_step_N: mark_unresponsive
```

User can override during step 6 (review).
