---
name: v-start
description: Start a new project, or bring an existing repo onto the same footing, with the agent harness used across Athena, Yummers and Be At Home. It sets up a CLAUDE.md contract, an AGENTS.md pointer, the PROGRESS / DECISIONS / VERIFIED / RISKS ledgers, spec and plan before code, an issue-first workflow, Conventional Commits, CI and optional stack presets. Use when the user says "/v-start", "start a new project", "set up a new repo", "bootstrap this project", "add the harness", or wants a repo set up "the way we usually do it".
---

# v-start

Set up a repo so every future agent session starts on the right footing. The harness is **process**: rules, ledgers, templates and CI. App code comes after, from a stack preset, once the stack is a recorded decision.

| Path in `{SKILLBASE}/` | What |
|---|---|
| `templates/` | Files copied into every project |
| `references/addons.md` | Optional rule blocks: Supabase, Next.js, Expo, AI, UI, personal data, client work, parallel sessions, generated files |
| `references/presets.md` | Stack scaffolds, with each one's check command |
| `presets/*.yml` | CI for each preset |

The three commands follow the order you start projects in: **`/v-start`** (rules and ledgers) → **`/v-discover`** (learn the real thing) → **`/v-spec`** (spec and plan for approval). Spikes are a rule (hard rule 1), not a command.

## Ask everything as multiple choice

**Every choice goes to the user as AskUserQuestion multiple choice: as many rounds as it takes, up to 4 questions a round.** Put the recommended option first, marked "(Recommended)". Keep descriptions to one plain line. Free-text answers (the name, the one-liner) go in as an option too, like "I'll type it", and the user picks Other. Don't write paragraphs for the user to read, and never pick an answer on their behalf.

## 1. Look before writing

Check the target directory (the cwd unless the user names one): `git status`, `ls -la`, and whether `CLAUDE.md`, `AGENTS.md`, `docs/` or `specs/` exist.

- **Empty** → greenfield. `git init` if needed.
- **Has code or docs** → adopt mode. Read the existing `CLAUDE.md`, `README.md` and the package manifest. **Never overwrite a file.** Merge the harness in, keep every existing rule, and show the user what you added.
- **Already has the harness** (`docs/PROFILE.md` exists) → **refresh mode**. Don't copy the templates again. Read `docs/PROFILE.md`, `CLAUDE.local.md` and PROGRESS, then show a 5-line summary of the profile. Ask (multiSelect) what changed: me / goals and deadline / users, platforms and people / stack and add-ons. Re-ask only those rounds. Update the files in place, add a line to the check-in log, commit with the files staged by name (`docs: refresh the project profile`), and stop.
- **The harness exists, but this person has no `CLAUDE.local.md`** (a new teammate) → run round 0 only and write their `CLAUDE.local.md`.

## 2. Interview (MCQ rounds)

**Round 0: you** (saved to `CLAUDE.local.md`, just for this person)
1. How much coding experience do you have? New to this / some projects / professional.
2. How should I ask you things? Multiple choice (Recommended) / short chat questions.
3. How long should my replies be? Short: tables and bullets (Recommended) / detailed reasoning.
4. How much should I do before checking in? Stop at each milestone (Recommended) / ask before every step / work until done.

Adapt from here on. A "new" person gets each next step explained in one plain line.

**Round 1: the project**
1. What is it? (Other → one sentence.)
2. Who uses it? Options: me only / friends or a small group / a client's users / children. **Anyone other than "me only" means accounts that hold other people's names or emails, so preselect the personal-data add-on.** For children, also add the voice rule.
3. Who decides product questions, and who approves? Options: me, solo / me plus a named teammate / a client owner.
4. Where does it live? Options: new GitHub repo / an existing repo / local for now.

**Round 1b: reference projects**
Find candidates first: `find .. ~/Desktop/projects -maxdepth 3 -name CLAUDE.md 2>/dev/null`, and list the repos that hold one. Ask (multiSelect): which past repos should this one learn from? Offer the top 3 found, plus "none". The chosen repos go in `CLAUDE.md` under **Reference projects**, one line each: the path, and what it's the reference for. Read their `CLAUDE.md` hard rules, and offer any that fit as extra rules in round 2.

**Round 1c: goals and platforms** (saved to `docs/PROFILE.md`)
1. What does done look like for the first version? Other → one sentence. Offer 2–3 drafts based on round 1.
2. Deadline? This week / this month / a date (Other) / no deadline.
3. What matters most? Ship fast (Recommended for a first version) / get it right / learn while building. This sets the trade-offs agents make.
4. Platforms (multiSelect): web / iPhone / Android / desktop / no UI.

**Round 2: stack and risk**
1. Stack: Next.js + Supabase + Vercel / Expo + Supabase / Python + uv / Node + TS, no build / decide later.
2. Add-ons (multiSelect): the `addons.md` blocks that fit the stack and users. Preselect the obvious ones in the descriptions.
3. Guarantees: "none yet", or Other → what must never happen (for example, Athena's grounding check).
4. Budget: ask before any spend (Recommended) / $0, free tiers only.

**Round 3: setup actions**
1. Scaffold the app now with the chosen preset? Yes (Recommended when the stack is chosen) / later.
2. GitHub: create the repo, labels and board now? Yes, private / yes, public / not now.
3. Write the first issue, "Write spec 1"? Yes / no.

Anything unanswered stays visibly `TBD` and goes under **Open** in `docs/PRD.md`.

## 3. Defaults (already decided; don't ask)

- **Models:** Opus plans (specs, plans, decisions, reviewing security, auth or data). Sonnet builds.
- **No Claude signature** on commits or PRs (`templates/.claude/settings.json`).
- **Issue first and the board for every project**, solo ones included.
- **Approval:** the approver approves specs and merges. On a solo project, a `/code-review` pass comes before the owner merges.
- **Branches:** `main` only. `feat/`, `fix/`, `docs/` and `chore/` branch off `main` and PR back into it.
- **Git safety:** stage files by name, use your own worktree, copy gitignored files in, never `--no-verify`.
- **CI:** Conventional Commits, a secret scan, and the preset's checks (Playwright on web).
- **Tests use real fixtures, not mocks.**
- **Specs** name the belief they test and a pass mark, and stay 1–3 pages.
- **Docs for other people** go in Claude Docs; the repo copy stays the source of truth.
- **Every PR** is written with `/v-start:visual-pr`. Screenshots and GIFs come with the UI add-on only.

## 4. Copy and fill

```bash
if command -v rsync >/dev/null; then rsync -a --ignore-existing {SKILLBASE}/templates/ <target>/; else cp -Rn {SKILLBASE}/templates/. <target>/ || true; fi
ls <target>/CLAUDE.md <target>/docs/PROFILE.md   # the copy really happened
```

Both paths never clobber. `cp -Rn` is only the fallback: on macOS it exits 1 when it skips a file, which stops a chain of commands. That's why it ends in `|| true`, and why the `ls` checks the result. In adopt mode, merge by hand any template whose file already exists.

Then turn the personal template into the real file: `[ -e CLAUDE.local.md ] && rm CLAUDE.local.template.md || mv CLAUDE.local.template.md CLAUDE.local.md`. The template has a different name because many people's global gitignore ignores `CLAUDE.local.md`, and that would keep it out of this plugin. For a new teammate (round 0 only), copy just `{SKILLBASE}/templates/CLAUDE.local.template.md` to `CLAUDE.local.md`.

Replace the placeholders:

| Placeholder | Value |
|---|---|
| `{{PROJECT}}` | Project name |
| `{{ONE_LINER}}` | What it is, in one sentence |
| `{{USERS}}` | Who uses it |
| `{{OWNER}}` | Who decides product questions |
| `{{APPROVER}}` | Who approves specs and merges |
| `{{REPO}}` | `owner/repo`, or `TBD` |
| `{{DATE}}` | Today, as `5 Nov 2026` |
| `{{CHECK}}` | The preset's check line, or `TBD (no stack yet)` |
| `{{BUDGET}}` | The budget rule |
| `{{REFERENCES}}` | One line per reference project, or `None yet.` |
| `{{PLATFORMS}}`, `{{PEOPLE}}`, `{{STACK}}` | From rounds 1 and 1c. People means the owner, the approver and the reviewers |
| `{{DONE}}`, `{{DEADLINE}}`, `{{PRIORITY}}` | From round 1c |
| `{{EXPERIENCE}}`, `{{QUESTION_STYLE}}`, `{{REPLY_LENGTH}}`, `{{AUTONOMY}}` | From round 0, in `CLAUDE.local.md` |

Check: `grep -rnE --exclude-dir=node_modules --exclude-dir=.git '(^|[^$])\{\{[^}]*\}\}' <target>` prints nothing. GitHub's `${{ … }}` is expected and isn't matched.

Then:

- **Add-ons:** paste the chosen blocks from `addons.md` into `CLAUDE.md` and renumber the hard rules. Skip what doesn't apply.
- **Guarantees:** write them into "What this repo is", each with how code (not a prompt) enforces it.
- **D001:** what's being built and why, in the user's words. **D002:** the stack and its reason. When no reason was given, write "Why: not stated yet".
- **PRD:** confirmed vs open, exactly as answered.
- **PROGRESS:** the first session entry.
- **`.gitignore`:** if one already exists, append `CLAUDE.local.md` to it. Check it's ignored: `git check-ignore CLAUDE.local.md`.
- **Solo projects:** in `CLAUDE.md` (the Conventional Commits rule) and `docs/WORKFLOW.md`, replace "Nobody merges their own PR" with "Run `/code-review` before merging your own PR".

## 5. Companion tools (install automatically, don't ask)

Install each one that's missing, once per machine. Check first, and skip it if it's already there:

| Tool | Present if | Install |
|---|---|---|
| gstack | `~/.claude/skills/gstack` exists | `git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && (cd ~/.claude/skills/gstack && ./setup)` (needs Git and Bun; if Bun is missing, skip it and say so) |
| impeccable | `claude plugin list` shows `impeccable@impeccable` | `claude plugin marketplace add pbakaus/impeccable && claude plugin install impeccable@impeccable` |
| ponytail | `claude plugin list` shows `ponytail@ponytail` | `claude plugin marketplace add DietrichGebert/ponytail && claude plugin install ponytail@ponytail` |

If the permission system blocks an install, don't work around it. List the command for the user to run with `! <command>`. agent-reach (https://github.com/Panniantong/Agent-Reach) and treg (https://treg.to/tutorial, needs its own sign-up) are only listed in the report, never installed. In the report, say what was installed. New plugins load in the next session.

## 6. Preset (if chosen)

Follow `references/presets.md` for the stack. Copy `{SKILLBASE}/presets/<stack>.yml` to `.github/workflows/checks.yml`. Run the check line once and record the result in `docs/VERIFIED.md`.

## 7. Outward actions (only on the user's yes from round 3)

- `gh repo create <owner>/<name> --private|--public --source . --push`
- Labels: `gh label create type:feat`, `type:fix`, `type:docs`, `type:chore`.
- Board: `gh project create --owner <owner> --title "<project>"`. Then put its number into `CLAUDE.md` step 2 (it stays `TBD` until then).
- The first issue, using `.github/ISSUE_TEMPLATE/task.md`.

The local commit needs no question. Stage files by name: `chore: start the project harness`, with a body listing what was installed.

## 8. Report (short)

A table of the files created or merged, the add-ons applied, and what's `TBD` and who answers it. Then the next step, as an MCQ:

- **`/v-discover`** (Recommended when there's an existing system, data or a client to learn from): week 0 research, VERIFIED facts, and mocks for stakeholders.
- **`/v-spec`**: write spec 1 for approval.
- Stop here.

Also list the companion tools not yet installed (from the README).

## Principles (keep them when you adapt)

- **One contract.** `AGENTS.md` points at `CLAUDE.md` and never copies it.
- **PROGRESS is the only record of state.** When it disagrees with `CLAUDE.md`, fix `CLAUDE.md`.
- **Decisions are append-only**, written in the session that makes them.
- **Docs are leads, not evidence.** Record what you saw in VERIFIED.
- **Guarantees live in code, not prompts.**
- **Spec and plan before code.**
- **Least code that does the job well.**
- **Split verified from assumed.**
