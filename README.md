# Agent handoff skills

Three standalone skills for carrying investigation work cleanly between coding-agent sessions:

- `handoff` investigates a codebase problem and writes a self-contained task handoff.
- `handon` reads a handoff, summarizes it, and presents the implementation plan before work begins.
- `handls` lists handoffs with their status and Git creation date.

The skills use `docs/tasks/` in the repository where the agent is working. They are independent skill folders under [`skills/`](skills/), so an agent can install all three or only the ones it needs.

## Install with Codex

Point Codex at this repository and ask:

```text
Use $skill-installer to install the handoff, handon, and handls skills from
https://github.com/aydin-aghaliyev/agent-handoff-skills.
```

Equivalently, the installer paths are:

```text
skills/handoff
skills/handon
skills/handls
```

Codex discovers newly installed skills automatically. If one does not appear, restart Codex.

## Use in a project

From the target project, invoke one of the skills explicitly:

```text
$handoff investigate the failing ingestion retry and leave a handoff
$handls open
$handon task-fix-ingestion-retry
```

The skills can also activate automatically when the request matches their descriptions.
