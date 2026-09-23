---
name: handreview
description: Review an implementation against a task handoff in docs/tasks/, report defects and gaps, then (after user go-ahead) write a follow-up handoff that handon can pick up.
---

# Hand Review

Use this skill when the user names a task handoff and wants its implementation checked against it. The review comes first; a follow-up handoff is written only after the user explicitly approves.

## Resolve the handoff

Resolve the requested name within `docs/tasks/`, appending `.md` if it is absent, then read `docs/tasks/<name>.md`. If it does not exist, use the `handls` workflow to list the available handoffs and ask which one the user intended.

Report the `- STATUS:` header (missing means `CLOSED`). Status does not block the review, but do not change it unless the user asks.

Also read the documents the handoff links to (specs, plans, downstream handoffs) that define the contract the implementation must meet.

## Locate the implementation

Do not trust the handoff's own claims of completion or verification. Establish where the work actually is:

- Run `git status` and `git log` for the files the handoff names. Implementation may be committed, uncommitted, or untracked; say which, and flag uncommitted work prominently.
- Find new or changed files with `git diff --stat`, untracked-file listings, and greps for the module, table, or function names the handoff specifies.
- If no implementation exists, say so and stop.

## Review

Check the implementation against every required fix, test requirement, and acceptance criterion in the handoff, and against general correctness:

| Check | Expectations |
| --- | --- |
| Run the tests | Run the tests the handoff or implementation names; record the pass/fail counts. |
| Read all of it | Code, tests, infrastructure, packaging, and the spec or docs it produced. Compare documented contracts against the code's actual behaviour. |
| Hunt for defects | Retries/idempotency, race and ordering issues, state-machine holes, error classification, input validation, contention, IAM/permission scope, and consistency between docs and code. |
| Check coverage | Mark each handoff requirement met, partly met, or missing. Note tests that exist in name but don't exercise the risky path. |
| Reproduce | Confirm every suspected defect with a minimal script or test (use the project's mocks, e.g. moto) before calling it confirmed. Keep the script; it goes into the follow-up handoff. |
| Check intent | Search plans and downstream handoffs to see whether an apparent defect is actually a decided behaviour or an open question. |

Do not modify implementation files during the review. Temporary reproduction scripts are fine; do not leave them in the repo.

## Report findings

Present the results in the conversation, grouped as:

1. **Should fix**: confirmed defects, each with `path:line`, what happens, the reproduction result, and a suggested direction. Mark items that need a user decision instead of a fix.
2. **Smaller gaps**: verified but lower-impact issues (missing validation, untested paths, docs drift, CI coverage, brittle infrastructure).
3. **Looks correct**: a brief list of the requirements that were verified as met, so the user can see what was covered.

Label anything not reproduced or verified as a hypothesis. End with a recommendation and ask whether the user wants a follow-up handoff written. **Do not write the handoff until the user explicitly agrees.** Answer their questions or revise the findings first if they ask.

## Write the follow-up handoff

After the go-ahead, follow the `handoff` skill's structure, status rules, and quality bar, with these additions:

- **Name:** `docs/tasks/<original-name-without-.md>-review-fixes.md`. If that exists, check whether it covers the same findings and update it, or add a numeric suffix (`-review-fixes-2.md`).
- **Title:** `# Task Handoff: Fix <Subject> Review Findings`, with `- STATUS: OPEN`.
- **Objective:** link to the original handoff and to the spec it produced; state the repository state at review time (branch, HEAD, and which files were uncommitted or untracked) and the baseline test result.
- **Current Behaviour:** one table of confirmed defects (with evidence and observed output) and one of gaps. Include the reproduction script so the next session can rerun it.
- **Required Fix:** one subsection per defect, then one for the gaps. Mark decision points explicitly with the options and a recommendation; tell the implementing agent to confirm them with the user before implementing.
- **Acceptance Criteria:** include "the reproduction script now shows the fixed behaviour" and that the original handoff's tests still pass.
- Add **Suggested Implementation Order** and **Verification Commands**.

Do not change the original handoff's status or content unless the user asks.

After writing, report the path and a short summary of its coverage, name any open decisions, and ask whether the user wants adjustments. The document must be readable by `handon` in a fresh session with no access to this conversation.
