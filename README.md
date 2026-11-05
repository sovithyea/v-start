# v-start

Start any project with the agent harness from an earlier project, an earlier project and an earlier project. Type `/v-start`, answer a few multiple-choice rounds, and the repo is ready for agents to work in safely.

## Install

```
/plugin marketplace add sovithyea/v-start
/plugin install v-start@v-start
```

## Use

```
mkdir my-project && cd my-project && claude
> /v-start
```

It also works on an existing repo: it reads what's there, never overwrites a file, and merges the harness in.

## It gets to know you

`/v-start` asks about **you** (your experience, how you like questions, reply length, autonomy) and about **the project** (goals, deadline, what matters most, platforms, people).

| Saved to | Holds | Shared? |
|---|---|---|
| `docs/PROFILE.md` | The project: goals, deadline, priorities, platforms, people, and a check-in log | Yes, it's in git |
| `CLAUDE.local.md` | You: how you like to work, plus preferences learned over time | No, it's gitignored |

It keeps up as you go:
- Every command reads both files and adapts to them.
- When you correct an agent, it offers to save the correction as a preference.
- After each spec ships, it checks in with a few questions.
- Running `/v-start` again refreshes the profile instead of setting up from scratch.

## What you get

| Piece | What it does |
|---|---|
| `CLAUDE.md` | The contract: what the repo is, who decides, the before-you-start checklist, hard rules |
| `AGENTS.md` | A pointer to `CLAUDE.md`, never a copy |
| `docs/` | PROGRESS (state), DECISIONS (D, append-only), VERIFIED (facts, C corrections), RISKS (R), PRD, WORKFLOW |
| `specs/N-name/` | `spec.md` (belief + pass mark) and `plan.md`; no code until they're approved |
| `.github/` | Issue and PR templates; CI for Conventional Commits and a secret scan |
| Stack presets | Next.js + Supabase + Vercel · Expo + Supabase · Python + uv · Node + TS, with their checks and CI |
| Add-ons | Rule blocks for Supabase, Next.js, Expo, AI, UI, personal or child data, client work, parallel sessions, generated files |

## Skills bundled with it

| Skill | For |
|---|---|
| `/v-start` | Setting up the project: rules, ledgers, CI, stack preset |
| `/v-discover` | Week 0: read the real thing, record facts, brief and mocks for stakeholders |
| `/v-spec` | Spec and plan for one piece of work, then stop for approval |
| `/v-start:visual-pr` | Every PR's description, with diagrams of what changed |
| `ios-simulator` | Driving the iOS Simulator (Expo) |
| `pr-screenshots`, `screen-recording` | Before/after images and GIFs in PRs |
| `ui-screenshots`, `image-annotations` | Playwright captures of web apps; callouts and arrows on screenshots |

## Companions

`/v-start` installs gstack, impeccable and ponytail automatically when they're missing, once per machine. It never reinstalls them. agent-reach and treg are listed in the report only, never installed.

| Tool | For | Install |
|---|---|---|
| gstack | `browse` screenshots, QA, review, `diagram` | `git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack && ~/.claude/skills/gstack/setup` |
| impeccable | Design critique | `/plugin marketplace add pbakaus/impeccable` then `/plugin install impeccable@impeccable` |
| ponytail | Least-code mode | `/plugin marketplace add DietrichGebert/ponytail` then `/plugin install ponytail@ponytail` |
| agent-reach | Reading Reddit, X, YouTube and more | https://github.com/Panniantong/Agent-Reach |
| treg | Live data APIs | https://treg.to/tutorial |

## Working on v-start

The rules for agents (and people) working on this repo are in [`CLAUDE.md`](CLAUDE.md), and where things stand is in [`docs/PROGRESS.md`](docs/PROGRESS.md). v-start uses its own harness.

## Change it

The templates are in `skills/v-start/templates/`. When you add a lesson to `references/addons.md`, name the project it came from. Third-party credits are in `THIRD_PARTY.md`.
