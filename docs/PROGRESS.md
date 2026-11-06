# Progress — v-start

The only current record of where things stand. Update it at the end of every working session.

**Last updated:** 6 Nov 2026 (evening). **v-start is announced on LinkedIn, and submitted to the Claude plugin directory** (in review). 0.5.2 is released and installed: ready for the plugin directory (#23, D010), with an icon (#8, D009). 0.5.3 (PR #25, D011) removed the bundled Azure DevOps upload that the portal held. 0.5.4 (PR #26, D012) adds the listing fields and `PRIVACY.md`. PR #27 lists every service v-start reaches, in the README and in `PRIVACY.md`. Since 0.5.0 it asks before installing companion tools (#5), ships no private context (#6, #18), its placeholder check works inside Claude Code (#11), and every question is an MCQ (#15). `check.sh` has committed fault tests (#10). Open: #3 (now fed by the post) and #7 (waiting on a budget, D006). Watch: the directory review.

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
- **#6:** removed the private project names and the owner's folder path from everything users see. Round 1b now searches only the folders next to the repo, or takes a typed path. New guarantee 5 in `check.sh` keeps the names out. Version 0.4.3.
- The #6 trial found that the skill's placeholder check matches nothing inside Claude Code (see VERIFIED). That is #11.
- PR #12 (#6) merged as `d1b63c4`, after a `/code-review` pass and its fixes. The installed plugin was updated to 0.4.3.
- **#11 (C4), PR #13:** the skill's placeholder check now calls `command grep`, which skips Claude Code's ugrep shell function, with the original pattern. `check.sh` fails if step 4 stops using it. Version 0.4.4. A first, shorter-pattern fix was dropped after `/code-review`: it flagged any `{{`, which hurts adopt mode in repos with Helm or Jinja files.
- PR #13 (#11) merged as `c79ad42`. The installed plugin was updated to 0.4.4.
- **#10:** `tools/check-faults.sh` copies the repo, breaks each guarantee in turn, and fails unless `check.sh` prints that check's own message. CI runs it. Deleting any check makes it fail.
- Writing the fault tests found one more silent exit in `check.sh`: with no fill table, `set -e` stopped it before its message. Fixed.
- PR #14 (#10) merged as `d94e74e`.
- **#15 (D005), version 0.5.0:** Vith asked that every question be an MCQ, never text in a reply, and that no choice be made before every answer it needs is in. Both rules are now in `/v-start`, `/v-spec`, `/v-discover` and the project template. A run that can't ask puts its questions under Open in `docs/PRD.md`, and refresh mode asks those first. Headless trials of all three commands showed no questions in the reply. The open questions went to PRD Open, or for `/v-spec` to the spec's Open questions table.
- PR #16 (#15) merged as `6db7259`. The installed plugin was updated to 0.5.0.
- **#7 cost worked out** (D006; the measured figures are in VERIFIED): Sonnet 5.5, PRs that touch `skills/`, 3 cases × 1 run, about $1.04 per trigger. Vith said no spend yet, so #7 waits on a monthly cap.
- PR #17 merged as `a0a4c90`.
- **LinkedIn prep:** a fresh install from GitHub works (VERIFIED). Vith will post with a screen recording, calling v-start early so strangers become the #3 testers.
- **#18 (D007):** the private project names come out of every file and, next, the whole git history. Guarantee 5's list moved to a gitignored `.private-names` and the `PRIVATE_NAMES` secret. The README says what you need. The reference projects moved to Vith's `CLAUDE.local.md`.
- PR #19 merged. **History rewritten** with `git filter-repo` and force-pushed by Vith (`main` is now `cf8fca1`). The 7 old branches are deleted, and a fresh clone has no names. A backup bundle of the old history is outside the repo, at `~/v-start-history-backup-2026-11-06.bundle`. Issues #1, #6 and #12 are edited. The repo topics are claude-code, claude-code-plugin and ai-agents.
- **No GitHub Support request** (D008, Vith's call). Old PR pages can still show the old diffs. Vith can delete the old revisions of #1, #6 and #12 from each issue's "edited" menu.
- **Posted on LinkedIn** by Vith, with a screenshot of the repo and a caption, instead of a video. Five video drafts were made and then deleted.
- **Next:** treat feedback from people who try it after the post as #3 (the first outside run). Log what they hit in VERIFIED and new issues. Then #7 once there's a budget.
- **#23 (D010):** ready for the directory. The plain-language description is in both manifests, and the directory check passes. Version 0.5.2, merged as PR #24. The portal's checks raised 2 policy holds for human review. The Azure DevOps upload in `pr-screenshots`, which read the user's Azure token, is removed (0.5.3). The other findings stay, with a note for the reviewer. Listing fields added (0.5.4, D012): `displayName` `v-start`, keywords, six links, and `PRIVACY.md`. The README lists the services v-start reaches, for the portal's data-handling question. **Submitted** on 6 Nov: v0.5.4 (`e75779b`) is in the security scan, then review. The directory picks up new commits about every 6 hours, and each one needs review before it goes live. Watch for review questions in Vith's email.
- **#8 (D009):** the plugin icon is a terminal showing `/v` on a blue-to-violet gradient, picked by Vith from three drafts. The ICON_MISSING warning is gone. Version 0.5.1.

### 5 Nov 2026 — v-start built, released and used on itself (Vith)

- Read the hard rules and harness docs in Vith's earlier projects, then built the plugin. Every choice was asked as an MCQ (D003).
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
