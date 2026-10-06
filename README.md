# Agent handoff skills

Four skills for carrying investigation work cleanly between coding-agent sessions, packaged for both Codex and Claude Code:

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

## Install with Claude Code

This repository is also a Claude Code plugin marketplace. Add it and install the `agent-handoff` plugin:

```text
/plugin marketplace add aydin-aghaliyev/agent-handoff-skills
/plugin install agent-handoff@agent-handoff-skills
```

Or from a shell:

```bash
claude plugin marketplace add aydin-aghaliyev/agent-handoff-skills
claude plugin install agent-handoff@agent-handoff-skills
```

Plugin skills are namespaced, so they are invoked as `/agent-handoff:handoff`, `/agent-handoff:handon`, and so on. Run `/reload-plugins` or restart Claude Code if they do not appear.

To use the skills without the namespace, copy the skill folders into your personal (or a project's) skills directory instead:

```bash
cp -r skills/handoff skills/handon skills/handls skills/handreview ~/.claude/skills/
```

## Use in a project

From the target project, invoke one of the skills explicitly. In Codex:

```text
$handoff investigate the failing ingestion retry and leave a handoff
$handls open
$handon task-fix-ingestion-retry
$handreview task-fix-ingestion-retry
```

In Claude Code, with the plugin installed:

```text
/agent-handoff:handoff investigate the failing ingestion retry and leave a handoff
/agent-handoff:handls open
/agent-handoff:handon task-fix-ingestion-retry
/agent-handoff:handreview task-fix-ingestion-retry
```

With the skill folders copied into `~/.claude/skills/`, drop the prefix: `/handoff`, `/handls`, `/handon`, `/handreview`.

The skills can also activate automatically when the request matches their descriptions.
