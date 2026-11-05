# CLAUDE.md

Guidance for Claude Code (and every other agent) in this repo. Humans should start at [`README.md`](README.md).

## What this repo is

**{{PROJECT}}**: {{ONE_LINER}}

- **Users:** {{USERS}}.
- **{{OWNER}} decides product questions. {{APPROVER}} approves specs and merges PRs.**

**`docs/PROGRESS.md` is the only current record of where things stand.** Read its front section and the newest session-log entry before doing anything. If this file disagrees with PROGRESS, trust PROGRESS and fix this file.

## Commands

```bash
{{CHECK}}   # green before any PR
```

## Read before doing anything

| File | What it gives you |
|---|---|
| `docs/PROGRESS.md` | Where things stand, what's open, what's next |
| `docs/DECISIONS.md` | Every settled call, append-only (D-numbers) |
| `docs/VERIFIED.md` | Observed facts with sources, and the correction log (C-numbers) |
| `docs/RISKS.md` | What reading the code won't tell you (R-numbers) |
| `docs/WORKFLOW.md` | Issues, branches, commits, PRs |
| `docs/PRD.md` | What {{OWNER}} confirmed vs. what is still open or assumed |
| `specs/N-name/` | `spec.md` (what and why) and `plan.md` (how) for each piece of work |

## Before you start a task

Answering a question needs none of this. Changing anything does.

1. **Issue first.** Find the GitHub issue in `{{REPO}}`, or write one with the template: **Why / Done when / Blocked by / Refs**, plus a `type:` label.
2. **Put it on the board** as In Progress: `gh project item-add TBD --owner TBD --url <issue>`.
3. **Check nobody else has it.** Look at the board, open PRs (`gh pr list`) and PROGRESS. Other sessions work in parallel. If someone has it, ask; don't start a parallel version.
4. **Check it's ready.** Application code needs its spec and plan approved (hard rule 1). Use `/v-spec` to write them. Any blockers the issue lists must be closed.
5. **Work in your own worktree** off a fresh `origin/main`, never in the shared checkout: `git worktree add <scratchpad>/<name> -b <type>/<name> origin/main`. Copy in the gitignored files you need (`.env.local`…), because a new worktree has none of them and nothing tells you.
   **Stage files by name, never `git add -A`.** A worktree whose files are behind its HEAD stages a revert nobody wrote. First run `git status`, then `git fetch`.
6. **Take numbers carefully.** Before using a D, R or C number, check the logs **and open PRs**. Other sessions claim numbers in unmerged branches.
7. **Finish properly.** The PR says `Closes #N` and lists the evidence. {{APPROVER}} merges. Add a PROGRESS session entry.

## Hard rules

### Before code

**1. No application code before that work's `spec.md` and `plan.md` are approved by {{APPROVER}}.** If asked to build something whose spec is still a draft, finish the spec and stop for review. **The one exception is a labelled spike:** throwaway code to learn something, on a `spike/<name>` branch, recorded in PROGRESS as "pre-spec, unreviewed", and never merged as-is.

**2. Documentation is a lead, not evidence.** That includes this file. Read the source or run the thing. Record what you saw in `docs/VERIFIED.md`, with the file, command or URL that showed it. When a doc turns out wrong, fix it and log a C-number. Check PROGRESS and the specs before assuming a part of the system exists.

**3. Never write a domain fact from memory.** Names, rules, dates, API names and prices come from a real source, recorded in VERIFIED with that source. Anything unchecked goes in its Unverified section.

**4. Append to `docs/DECISIONS.md`, never rewrite it.** A reversal gets a new entry, and the old one gains a `**Status:**` line. Decisions are written in the session that makes them: no transfer files, no "paste this in later". **If a task conflicts with a live decision, stop and say so.**

### Building

**5. Write the least code that does the job well.** No dead code, no speculative options, no abstraction with one caller, no handling for cases that can't happen. Before opening a PR, reread the diff and delete what the task doesn't need. Guards that protect data or money are part of the job, not extra. New dependencies need a reason in `docs/DECISIONS.md`.

**6. Guarantees are code, not prompts.** Anything that must never happen is enforced by a check, with a test that fails if the check is removed. Prompts get talked around; checks don't.

**7. Tests exercise real behaviour against real-shaped fixtures, not mocks of it.** Use real exports, real schemas and a real database, filled with synthetic people (rule 8). A test that would still pass if the feature broke isn't evidence.

**8. Secrets and data.**
- Secrets live in environment config only. Never commit, log or print them, not even in chat. Read a password from its file; don't echo it.
- Synthetic data only, in fixtures, tests, screenshots, issues and PRs.
- No personal data in URLs.
- Never show a raw ID, JSON or an internal name to a user.

**9. Production is look-only.** Development never points at production. Production queries run read-only and return aggregates only. A change reaches production only through the release path, when {{OWNER}} says so.

**10. Format every file you add** with the repo's formatter. No minified one-liners.

### Working

**11. Stay in scope.** Anything else you notice becomes a new issue, not part of this PR.

**12. Commits follow Conventional Commits 1.0.0**, and so do branch names and PR titles.
- A commit carrying a decision, a reversal, a defect or a non-obvious trade-off MUST have a body explaining *why*, plus `Refs:` footers naming D/R/C numbers, so `git log --grep=D004` works.
- Never bypass a hook with `--no-verify`.
- **Merge only when {{APPROVER}} says to.** Nobody merges their own PR.

**13. Spending: {{BUDGET}}** Any paid API call, card, paid plan or billed key needs {{OWNER}}'s yes first, with the expected cost.

**14. Match the model to the work.**
- **Opus:** specs, plans, decisions, and reviewing anything touching security, auth, permissions or user data.
- **Sonnet:** builds, docs, research and routine review.
- When you spawn a subagent, set its `model` to fit the task.

### Reporting

**15. Say what you verified and what you assumed.** When you report work as done, split it into what a test checks (one that would fail if it broke) and what you only checked by reading. Passing tests don't prove the untested part works. Label reasoning **[Inference]** or **[Assumption]**. When an open question blocks you, stop and ask {{OWNER}}. Never pick an answer on their behalf, not even as a labelled default.

**16. Leave a trail someone else can pick up.** End every session with a `docs/PROGRESS.md` entry and update its "Last updated" line. Write so another person's session could carry on without you. Don't invent effort estimates.

**17. Plain language.** Docs, PRs, issues and anything a user reads are written as one person talking to another. Use short sentences, no jargon, and no "simply", "just" or "easy".

Process docs use RFC 2119 keywords: MUST can be rejected at review; SHOULD needs a stated reason to depart from it.

## Layout

```
CLAUDE.md          this file, the contract
AGENTS.md          a pointer to this file, never a copy
docs/              PRD, progress, decisions, verified facts, risks, workflow
specs/N-name/      spec.md + plan.md per piece of work
```

## Reference projects

{{REFERENCES}}

Read their source, not their prose.

## Working here

- **Report back in detail:** what changed and why, file by file; the evidence (commands run and their output); what's unverified; what you need from {{OWNER}}.
- **Docs for other people** (clients, testers, friends) go in **Claude Docs**. The repo copy stays the source of truth for agents; link the shared copy from `docs/PROGRESS.md`.
