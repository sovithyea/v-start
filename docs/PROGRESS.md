# Progress — v-start

The only current record of where things stand. Update it at the end of every working session.

**Last updated:** 6 Nov 2026. 0.4.1 is released and installed. 0.4.2 (#5) makes `/v-start` ask before installing companion tools. Issues #6, #7 and #8 are on the board.

## Phases

| Phase | Goal | Owner | Status |
|---|---|---|---|
| 1 | A friend starts a project with v-start, without help | Vith | In progress |

## Waiting on

- **Vith:** the open questions in `docs/PRD.md`.

## Session log

### 6 Nov 2026 — ask before installing companion tools (Vith)

- An Agensi.io email offered to list v-start's skills. Advice given: wait until #3 passes. Nothing decided or recorded.
- Reviewed how to improve the skill. Four issues are on the board: #5 ask before installs, #6 remove private context, #7 behaviour tests in CI (needs Vith's yes on cost), #8 plugin icon (Vith picks).
- **#5:** D004 replaces D003's auto-install line. `/v-start` now asks (multiSelect) which missing tools to install. gstack is pinned to `v1.91.242.0`. Version 0.4.2.
- Headless trial passed (see VERIFIED). The trial's own permission limits stopped it checking which tools were already installed, so it offered all three. That's the trial setup, not the skill.
- **Next:** Vith reviews and merges the #5 PR. Then #6.

### 5 Nov 2026 — v-start built, released and used on itself (Vith)

- Read the hard rules and harness docs in Rocket Athena, Athena, yummers, beathome-platform and the beathome-field-app harness, then built the plugin. Every choice was asked as an MCQ (D003).
- Releases: 0.1.0 (harness), 0.2.0 (companions install automatically), 0.3.0 (visual-pr on every PR, PR #1), 0.4.0 (personalisation, PR #2). Installed from GitHub on Vith's machine.
- Headless trials: a fresh setup, a refresh, and a setup with personalisation. Each one found something, and each fix is in VERIFIED.
- Ran `/v-start` on this repo in adopt mode. This was the first run with real MCQs answered by a person.
- GitHub: `type:` labels, [board 4](https://github.com/users/sovithyea/projects/4), and [#3](https://github.com/sovithyea/v-start/issues/3), the phase 1 goal, set to In Progress.
- **0.4.1 (PR #4):** the copy uses `rsync`, falling back to `cp -Rn` (C1). CI enforces the 3 guarantees and passed on its first run on GitHub.
- **Code review of PR #4** (`/code-review medium`) found 10 issues. 8 are fixed:
  - `check.sh` now really fills the templates and catches any `{{…}}`;
  - the `rsync` fallback;
  - a checksum-verified gitleaks;
  - a pinned Claude CLI (2.1.318);
  - no cancelled runs on `main`;
  - `Revert "…"` commits pass;
  - exact-path credit matching;
  - this entry.
  2 were by design: the `specs/0-example` template, and the Visuals section, which the template already says to delete when there's no screen.
- **Next:** a friend's first run (#3).
