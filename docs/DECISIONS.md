# Decision log

The contract. One entry per decision. The **why** matters most: it's what gets forgotten, and then argued over again when nobody wrote it down.

**Rules.**
- Append-only. Never rewrite an entry's reasoning.
- When a decision is replaced, the old entry keeps its body and gets a `**Status:**` line naming what replaced it.
- If a task conflicts with a live entry, stop and say so. Don't quietly work around it.
- Decisions are written here in the session that makes them.

---

## D001 — What we're building

*5 Nov 2026 · Vith*

A Claude Code plugin that starts any project with a proven agent harness and personalises it to the person and the project.

**Why:** Vith wants future projects to start faster, using what already worked in Athena, Rocket Athena, yummers and Be At Home, and wants to give it to others.

## D002 — A Claude Code plugin on GitHub, public

*5 Nov 2026 · Vith*

v-start ships as a plugin from `sovithyea/v-start`, installed with `/plugin marketplace add sovithyea/v-start`, and is public.

**Why:** a single command installs it, and installed copies update in place. Vith chose public so anyone can use it.

## D003 — How v-start behaves (the setup session's choices)

*5 Nov 2026 · Vith*

- Every choice is asked as multiple choice, in as many rounds as needed.
- Three commands: `/v-start`, `/v-discover`, `/v-spec`. Spikes are a rule, not a command.
- The 17 always-on hard rules in the template were picked one by one. Everything else is an add-on.
- Opus plans and Sonnet builds; no Claude signature; ask before any spend; `main` only; `/code-review` before a solo merge.
- Companion tools (gstack, impeccable, ponytail) install automatically when missing. agent-reach and treg are only listed.
- Every PR is written with visual-pr. Screenshots come with the UI add-on.
- Personalisation: the person's settings go in `CLAUDE.local.md` (gitignored) and the project's in `docs/PROFILE.md`. Corrections are saved, a check-in runs at milestones, and a re-run refreshes.

**Why:** chosen by Vith question by question in the setup session, from the patterns in the reference repos.

**Status:** the companion-tools line is replaced by D004 (6 Nov 2026). The rest stands.

## D004 — Ask before installing companion tools

*6 Nov 2026 · Vith*

`/v-start` asks (multiSelect MCQ) which missing companion tools to install, and installs only those. gstack is pinned to its newest release, `v1.96.0.0`, and the clone is checked against that release's commit (`6666b7296766`), so a moved tag can't slip through. This replaces D003's "install automatically" line.

**Why:** v-start is public (D002). Installing without asking runs other people's code, including gstack's `./setup` script, on a stranger's machine without their say. Pinning means nothing upstream can change what our users run until we bump it in a PR. The newest release was chosen over the oldest because release age alone says nothing about which one is safer. Raised while reviewing how to improve the skill (#5).
