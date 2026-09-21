---
name: handon
description: Read a task handoff in docs/tasks/, summarize it, and present its implementation plan before work begins.
---

# Hand On

Use this skill when the user names a task handoff document and wants to review it before implementation.

## Read the handoff

Resolve the requested name within `docs/tasks/`, appending `.md` if it is absent, then read `docs/tasks/<name>.md`. If it does not exist, use the `handls` workflow to list the available handoffs and ask which one the user intended.

Read an optional `- STATUS: OPEN` or `- STATUS: CLOSED` header near the top of the document. Treat a missing header as `CLOSED` for compatibility with existing handoffs. State the resolved status before the summary; if it is closed, say that it is historical/completed and ask the user to confirm that they want to reopen or revisit it. Do not alter the status unless the user explicitly asks.

## Present the plan

Give a short summary (three to five sentences) covering the problem or feature, why it matters, and key decisions or constraints already made.

Then extract the document's concrete steps into a numbered checklist. Use stated steps directly when provided; otherwise synthesize actionable steps from the document.

End by asking whether the user is ready to start or wants to adjust the plan. Do not begin implementation until they explicitly confirm.
