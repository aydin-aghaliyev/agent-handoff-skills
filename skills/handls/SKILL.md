---
name: handls
description: List task handoffs in docs/tasks/ with their status and Git creation date; filter by status or today.
---

# Handls

Use this skill when the user wants to browse, triage, or select task handoffs in `docs/tasks/`.

Run the helper bundled with this skill: resolve `scripts/handls.sh` relative to
the directory containing this `SKILL.md`, not relative to the target repository.
Set the command's working directory to the repository root so the helper can read
`docs/tasks/` and Git history. Pass zero or more filters:

- `open`, `closed`, or `all` filters status. A handoff without a `- STATUS:` header is `CLOSED` for backward compatibility.
- `today` filters to handoffs first added to Git today, using the local date.

The script prints a Markdown table ordered with open work first and then by Git creation timestamp, newest first. Pass the table through unchanged unless the user asks for analysis. If no matching handoffs exist, say so concisely.

For a selected handoff, use the `handon` workflow before implementing it. For a new investigated handoff, use the `handoff` workflow so it receives an explicit status.
