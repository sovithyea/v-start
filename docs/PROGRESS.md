# Progress — v-start

The only current record of where things stand. Update it at the end of every working session.

**Last updated:** 5 Nov 2026. v0.4.0 is released and installed. 0.4.1 (PR #4) adds the harness on v-start itself, CI for the guarantees, and the code review's fixes.

## Phases

| Phase | Goal | Owner | Status |
|---|---|---|---|
| 1 | A friend starts a project with v-start, without help | Vith | In progress |

## Waiting on

- **Vith:** the open questions in `docs/PRD.md`.

## Session log

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
