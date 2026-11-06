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

**Why:** Vith wants future projects to start faster, using what already worked in Vith's earlier projects, and wants to give it to others.

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

## D005 — Every question is an MCQ, and choices wait for every answer

*6 Nov 2026 · Vith*

- In `/v-start`, `/v-spec` and `/v-discover`, every question goes to the user as an AskUserQuestion MCQ. None is written as text in a reply, including in the final reports.
- Before making a choice, or building on one, an agent asks until it has every answer the choice needs. It never fills a gap with a default.
- When a question can't be asked (AskUserQuestion isn't available or errors, as in a headless run), it goes under Open in `docs/PRD.md` as TBD, to be asked in the next live session. For `/v-spec` it goes in the spec's Open questions table. An unanswered placeholder gets TBD, never a guess.
- The project template carries both rules. A person who picked "chat" in round 0 still gets a short list; the v-start commands always use MCQ.

**Why:** Vith, 6 Nov 2026: "claude sometimes replies back with a bunch of non mcq questions in the outputs, these should be mcq questions" and "never make a choice without getting all u need to build it". This extends D003's "every choice is asked as multiple choice". (#15)

## D006 — The CI behaviour test's shape, and no spend yet

*6 Nov 2026 · Vith*

When #7 is built, the behaviour test runs `claude plugin eval --model claude-sonnet-5-5 --runs 1 --ablation none` (plus `--max-cost-usd`, set from the cap), only on PRs that touch `skills/`, with 3 cases: a new project, adopt mode, and a headless run with open questions. [Inference] That's about $1.04 per trigger, estimated from Opus token counts; the first real run measures it. **No money is spent yet:** #7 waits until Vith sets a monthly cap.

**Why:** an Opus 5.5 run measured $0.55–0.60 (VERIFIED). [Inference] Sonnet 5.5 would cost about 40% less at its list prices, if it uses the same tokens. Running only when `skills/` changes, with 1 run per case, keeps a busy day to about 4 triggers. Vith picked each of these from multiple-choice options, and chose "not yet" for the cap. (#7)

## D007 — Private project names come out of the repo and its history

*6 Nov 2026 · Vith*

- Every current file and every commit stops naming Vith's earlier private projects and local folder paths. They become "my earlier projects" or similar.
- **One-off exception to hard rule 4:** D001's "Why" was reworded to drop the names. Its meaning is unchanged. No other entry was rewritten.
- History is rewritten with `git filter-repo` and force-pushed, and the old remote branches are deleted, as part 2 of #18 once the current files are clean. GitHub Support is then asked to remove cached PR views.
- Guarantee 5's list of names moved out of the repo, into a gitignored `.private-names` file and the `PRIVATE_NAMES` CI secret. Without it, the check skips with a notice, except on this repo's own CI, where a missing secret fails. A hit prints file names only, so a name never reaches a public CI log.

**Why:** v-start is being shared publicly. Vith chose a full scrub over leaving the names in old files and commits. (#18)

**Status:** the GitHub Support step is dropped by D008. The rest stands.

## D008 — No GitHub Support request after the history rewrite

*6 Nov 2026 · Vith*

GitHub Support is not asked to remove cached views or PR refs. Old PR pages on GitHub can still show diffs from before the rewrite. This replaces D007's Support step.

**Why:** Vith, 6 Nov 2026: "no need github support". (#18)

## D009 — The plugin icon

*6 Nov 2026 · Vith*

v-start's icon is a dark terminal window showing `/v` and a coral cursor, on a blue-to-violet gradient. It's a full-bleed 1024×1024 PNG at `.claude-plugin/icon.png`, with no transparent corners.

**Why:** Vith picked it from three drafts, because it says "a Claude Code command" at a glance and still reads at 32 px. It's a decision because the developer portal takes the icon only the first time the plugin is saved there, so changing it later won't update the listing. (#8)

## D010 — List v-start in the Claude plugin directory

*6 Nov 2026 · Vith*

v-start will be submitted to the Claude plugin directory at claude.ai/directory/manage, under the permanent name `v-start`, from the repo root of `sovithyea/v-start`. The listing's short description is the plain-language one now in `plugin.json`. Vith submits, because the portal needs Vith's paid account and Vith's own answers to its data-handling and compliance questions.

**Why:** Vith asked to list it. The name stays `v-start` because it matches the command, the repo and the install lines in the LinkedIn post. The portal fixes the name, the repo and the icon (D009) on submission. (#23)

## D011 — Modify the bundled pr-screenshots skill, and leave the other portal holds for review

*6 Nov 2026 · Vith*

- The Azure DevOps upload section is removed from v-start's copy of `skills/pr-screenshots` (from github/awesome-copilot, MIT). `THIRD_PARTY.md` marks it as modified. Anyone re-syncing it from upstream must leave that section out.
- The portal's other findings stay as they are, and a note for the reviewer explains each one. They are: `gh` using the user's own GitHub login for github.com, the icon path named in the docs, the pinned gstack clone-and-setup, and the root `CLAUDE.md`.

**Why:** the portal put a credential hold on the Azure section, because it read the user's Azure token and sent it to visualstudio.com, and v-start is GitHub-only. The other findings are either the same vendor (GitHub's own login going to GitHub), documentation, or an install already pinned and asked about (D004). The portal says a reviewer clears those. (#23)

## D012 — The listing's links, keywords and privacy statement

*6 Nov 2026 · Vith*

- `plugin.json` sets `displayName` to `v-start`, so the directory doesn't show "V Start". It also sets keywords (claude-code, project-setup, ai-agents, spec-driven, workflow, harness) and six links. Homepage and repository go to the GitHub repo, documentation to the README, and support to GitHub issues. Privacy goes to `PRIVACY.md`, and terms to the MIT `LICENSE`.
- `PRIVACY.md` is Vith's statement to users, approved word for word. v-start collects nothing, has no telemetry and no servers, and uses the user's own tools and accounts only after they say yes.

**Why:** the portal's Listing details step showed the name as "V Start" and "Links: 0 of 6 filled in". It reads all of these from `plugin.json`. (#23)
