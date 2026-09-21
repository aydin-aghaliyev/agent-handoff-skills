---
name: handoff
description: Investigate a codebase problem and write a self-contained handoff in docs/tasks/ for a fresh agent.
---

# Handoff

Investigate the described problem and write a task handoff that another session can pick up without prior context. The handoff should orient that agent to the verified facts, relevant code, and sensible next work; it need not prescribe an implementation.

## Investigation

Before writing, gather enough verified context to let a new agent continue productively:

| Action | Expectations |
| --- | --- |
| Confirm the problem | Reproduce or otherwise verify it using relevant commands, logs, dashboards, or state. |
| Trace the path | Read the failing code, its callers, relevant infrastructure or orchestration definitions, existing tests, and referenced design documents. |
| Find the cause | Separate symptoms from likely technical causes when the evidence supports a conclusion. |
| Find precedent | Locate relevant behavior elsewhere in the codebase when it helps frame the next work. |
| Avoid duplication | Search `docs/tasks/` for prior work on the topic; update an existing handoff when appropriate. |
| Preserve evidence | Record concrete IDs, timestamps, counts, and exact errors when available. |

Do not present unconfirmed speculation as fact.

## File and document

Write the handoff to `docs/tasks/` using a kebab-case name that describes the fix: use `task-<slug>.md` for implementation work and `test-improvement-handoff-<slug>.md` for test-focused work.

Use this structure:

```markdown
# Task Handoff: <Verb> <What> <Where/Why>

- STATUS: OPEN

## Objective

## Current Behaviour

## Root Cause

## Required Fix

### 1. <First change>

## Key Files

| File | Purpose |
| --- | --- |

## Tests Required

## Acceptance Criteria

## Out of Scope
```

`STATUS` must be either `OPEN` or `CLOSED`. New handoffs begin `OPEN`; change it to
`CLOSED` only when the documented work is complete. The `handls` skill treats older
handoffs without the header as `CLOSED`.

Add these sections when relevant: **Incident Evidence**, **Suggested Implementation Order**, **Verification Commands**, and **Reprocessing Guidance**.

## Quality bar

- Cite concrete code references with paths and line numbers for every factual claim.
- Include useful existing patterns, possible approaches, or examples when they clarify the handoff; paste-ready implementation code is optional.
- Record decision points and tradeoffs when they are known, and clearly mark material unresolved questions.
- Separate verified findings, reasonable hypotheses, and remaining investigation so the next agent knows where to resume.
- Where the intended outcome is known, state observable checks or acceptance criteria; do not invent a complete implementation plan merely to fill the document.
- Keep the writing direct and concise. Prefer tables and code blocks to generic explanation; omit investigation narrative and unconfirmed claims.

## Handoff

After writing the document, report its path and give a short summary of its coverage. Ask whether the user wants adjustments before another session implements it.
