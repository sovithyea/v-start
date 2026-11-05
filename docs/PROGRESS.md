# Progress — v-start

The only current record of where things stand. Update it at the end of every working session.

**Last updated:** 6 Nov 2026. 0.4.4 is released and installed: `/v-start` asks before installing companion tools (#5), ships no private context (#6), and its placeholder check works inside Claude Code (#11). PR #14 (#10) adds committed fault tests for `check.sh`. Open: #3, #7, #8.

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
- **#5:** D004 replaces D003's auto-install line. `/v-start` now asks (multiSelect) which missing tools to install. gstack is pinned to `v1.96.0.0` and its commit. `check.sh` now checks D004 (see CLAUDE.md guarantee 4). Version 0.4.2.
- `/code-review medium` on PR #9 found 8 issues. Fixed: the VERIFIED and PROGRESS wording, install nothing when it can't ask, a duplicate report line, the tag check, the text check, and the newest release pinned by commit. Skipped: where D003's Status line sits (rule 4 is met), and gstack's detached HEAD (no harm seen).
- A second review found: the `|` in the gstack command split its Markdown table cell, a failed check left the clone behind, `check.sh` could exit silently, and the pin check didn't require the commit check. All fixed: the command now sits in its own code block, runs only when gstack is absent, and removes the clone on any failure. Committed fault tests for `check.sh` are #10 (hard rule 6).
- Headless trial: no install call, and it asked instead (see VERIFIED). Not tested: the skip-if-present step (the trial's permissions blocked it) and a person picking "None" or some tools.
- PR #9 (#5) merged as `59321bd`, after two `/code-review` passes. The installed plugin was updated to 0.4.2.
- **#6:** removed the private project names and `~/Desktop/projects` from everything users see. Round 1b now searches only the folders next to the repo, or takes a typed path. New guarantee 5 in `check.sh` keeps the names out. Version 0.4.3.
- The #6 trial found that the skill's placeholder check matches nothing inside Claude Code (see VERIFIED). That is #11.
- PR #12 (#6) merged as `d1b63c4`, after a `/code-review` pass and its fixes. The installed plugin was updated to 0.4.3.
- **#11 (C4), PR #13:** the skill's placeholder check now calls `command grep`, which skips Claude Code's ugrep shell function, with the original pattern. `check.sh` fails if step 4 stops using it. Version 0.4.4. A first, shorter-pattern fix was dropped after `/code-review`: it flagged any `{{`, which hurts adopt mode in repos with Helm or Jinja files.
- PR #13 (#11) merged as `c79ad42`. The installed plugin was updated to 0.4.4.
- **#10:** `tools/check-faults.sh` copies the repo, breaks each guarantee in turn, and fails unless `check.sh` prints that check's own message. CI runs it. Deleting any check makes it fail.
- Writing the fault tests found one more silent exit in `check.sh`: with no fill table, `set -e` stopped it before its message. Fixed.
- **Next:** merge PR #14 (#10). Then #7 (behaviour tests, needs a yes on cost), #8 (icon, Vith picks) and #3 (a friend's first run).

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
