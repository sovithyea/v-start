---
name: v-spec
description: Write the spec and plan for one piece of work in a v-start project (specs/N-name/spec.md and plan.md), grounded in the real source, with a belief, a pass mark and numbered acceptance criteria, then stop for approval. Use when the user says "/v-spec", "write a spec", "spec this", "plan this feature", or asks to build something whose spec doesn't exist yet.
---

# v-spec

Turn one piece of work into a `spec.md` and a `plan.md` that the approver can say yes to. **No application code in this command** (hard rule 1). This is Opus work (hard rule 14).

**Ask every choice as AskUserQuestion multiple choice**, in as many rounds as needed, with the recommended option first. Keep the prose short.

## 1. Read first

`CLAUDE.md`, `docs/PROFILE.md` and `CLAUDE.local.md` (adapt to them: the experience level sets how much you explain, the priority sets the trade-offs, and the platforms set where things get checked), `docs/PROGRESS.md`, `docs/DECISIONS.md`, `docs/VERIFIED.md`, `docs/RISKS.md`, `specs/README.md`, and any existing spec this one depends on.

## 2. Ask (MCQ rounds)

1. **Which piece of work?** Offer what PROGRESS, the PRD and discovery suggest, plus "I'll describe it".
2. **Who is it for, and what belief does it test?** Offer 2–3 drafts of "we believe X will Y for Z".
3. **The pass mark:** offer measurable numbers, using the baseline from VERIFIED where there is one.
4. **Scope:** what's in, and what's explicitly out (multiSelect).
5. **Any open question** a spec can't settle → ask the owner now, or list it under Open questions. Never pick the answer yourself.

## 3. Check the number and the issue

- Next spec number: `ls specs/`, **and** open PRs (`gh pr list`), because other sessions claim numbers in unmerged branches.
- Find or write the issue (Why / Done when / Blocked by / Refs) and put it on the board (CLAUDE.md, "Before you start a task"). Ask before creating anything on GitHub.

## 4. Write `specs/N-name/`

Start from `specs/0-example/`.

- **spec.md:** context; belief and pass mark; **current state**, read from the source and cited as `path:line` at a named commit (nothing from memory); what changes; numbered acceptance criteria a reviewer can observe; open questions. Keep it to 1–3 pages. If it needs more, split it into two specs and say so.
- **plan.md:** prerequisites; where (worktree and branch); checkbox steps, each ending in a commit line; a test per criterion that fails before the change; a spike step first when something unproven blocks the rest (hard rule 1's exception).
- Add a row to `specs/README.md`.

## 5. Stop for review

- Commit on a `docs/spec-N-<name>` branch, staging files by name: `docs(spec): N. <name> spec and plan`.
- Open a PR only on the user's yes.
- PROGRESS: "spec N drafted, waiting on the approver".
- When this spec later merges, the check-in in `CLAUDE.md` (Personalisation) runs.
- Report in a short table: the belief, the pass mark, the criteria count, and the open questions with who answers each one. **Then stop.** Building starts only after approval.
