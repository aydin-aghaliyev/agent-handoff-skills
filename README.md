# Agent handoff skills

Four skills for carrying investigation work cleanly between coding-agent sessions:

- `handoff` investigates a codebase problem and writes a self-contained task handoff.
- `handon` reads a handoff, summarizes it, and presents the implementation plan before work begins.
- `handls` lists handoffs with their status and Git creation date.
- `handreview` reviews an implementation against its handoff and, after approval, writes a follow-up handoff for fixes.

The skills use `docs/tasks/` in the repository where the agent is working. They are separate skill folders under [`skills/`](skills/), so an agent can install all four or only the ones it needs. Install `handreview` with `handoff` and `handls` for its follow-up and missing-handoff workflows.

## Install with Codex

Point Codex at this repository and ask:

```text
Use $skill-installer to install the handoff, handon, handls, and handreview skills from
https://github.com/aydin-aghaliyev/agent-handoff-skills.
```

Equivalently, the installer paths are:

```text
skills/handoff
skills/handon
skills/handls
skills/handreview
```

Codex discovers newly installed skills automatically. If one does not appear, restart Codex.

## Use in a project

From the target project, invoke one of the skills explicitly:

```text
$handoff investigate the failing ingestion retry and leave a handoff
$handls open
$handon task-fix-ingestion-retry
$handreview task-fix-ingestion-retry
```

The skills can also activate automatically when the request matches their descriptions.
