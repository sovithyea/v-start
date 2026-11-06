# Verified

What has been observed, how, and when. Anything not observed goes under Unverified. When a doc turns out wrong, fix it and log a C-number here.

## Verified

| Fact | How it was observed (file, command or URL) | When |
|---|---|---|
| The plugin passes validation, with one warning: no icon | `claude plugin validate .` | 5 Nov |
| Installing from GitHub gives 7 skills (now 9) and about 770 tokens of always-on cost | `claude plugin details v-start@v-start` | 5 Nov |
| A fresh `/v-start` run fills every placeholder and gitignores `CLAUDE.local.md` | Headless trials with `--plugin-dir` in the scratchpad | 5 Nov |
| A refresh run changes only what changed, and logs the check-in | Headless trial on the same folder | 5 Nov |
| The commit-message regex accepts `feat:`, `fix(x):` and `feat(x)!:`, and rejects `Add stuff`, `feat:x`, `feature:` and `chore():` | Local test of the regex in `commits.yml` | 5 Nov |
| The bundled awesome-copilot skills are byte-identical to upstream | `diff` against `github/awesome-copilot/skills/<name>/SKILL.md` | 5 Nov |
| A global gitignore can ignore `CLAUDE.local.md`, so the template ships as `CLAUDE.local.template.md` | `git add` refused the file in this repo | 5 Nov |
| On macOS, `cp -Rn` exits 1 when it skips an existing file | Adopt-mode run on this repo: the chain stopped after the copy | 5 Nov |
| `CLAUDE.md` at the plugin root gives a validate warning ("not loaded as project context"). That's expected: it's for working on this repo, and users never load it | `claude plugin validate .` after the harness was added | 5 Nov |
| `tools/check.sh` fills the templates and add-ons, then fails on any leftover `{{…}}` (including `{{PROJECT_2}}` and `{{lower}}`) and on an uncredited skill, even one named like a credited one | Self-test on a scratch copy with the faults injected | 5 Nov |
| The commit check skips `Merge…` and `Revert "…"` subjects, and still checks `revert:` and `Revert stuff` | Local test of the `case` pattern | 5 Nov |
| gstack's releases: `v1.91.242.0` (26 Oct), `v1.91.318.0` (29 Oct), `v1.92.55.0` (2 Nov), `v1.96.0.0` (5 Nov). `v1.96.0.0` is commit `6666b7296766f8e0c9f3cc44b70fd1eff6ad2e92`, and its clone has a `setup` file | `gh api repos/garrytan/gstack/releases`; `git clone --branch v1.96.0.0 --depth 1` then `git rev-parse HEAD` | 6 Nov |
| With no answer from the user, `/v-start` made no install call and ended with a question listing all three tools, plus "None". It offered gstack too, because the trial's permissions blocked its check for what was already installed, so the skip-if-present step wasn't tested | Headless trial with a fresh `CLAUDE_CONFIG_DIR`, installs blocked by `--disallowedTools`, tool calls read from the stream-json log | 6 Nov |
| `check.sh` guarantee 4 fails when the "ask first" heading is gone, when "install automatically" comes back, when the README's gstack tag differs, when the commit check is gone, and when the README loses its gstack line, each with a message. It passes on the clean branch | Self-test on a scratch copy with each fault injected | 6 Nov |
| The gstack install command, in bash and zsh: with the right commit it runs `setup` and keeps the clone; with a wrong commit it removes the clone and skips `setup`; when the folder already exists it changes nothing | Ran the command with the path pointed at a scratch folder and `./setup` replaced by an `echo` | 6 Nov |
| `check.sh` guarantee 5 fails when a private project name or the owner's folder shows up in a skill, a template, `plugin.json` or the README, and when a scanned path is missing. It passes on the clean branch and on plain English like "an earlier project" | Self-test on a scratch copy with each fault injected | 6 Nov |
| Inside a Claude Code session, `grep` is a shell function that runs ugrep, and the skill's placeholder pattern matches nothing there, even `a {{X}} b`. `/usr/bin/grep` matches it. `check.sh` calls plain `grep` in a new bash process, which doesn't inherit shell functions, so on this machine it gets `/usr/bin/grep` and isn't affected | `type -a grep`, `bash -c 'type grep'`, then the pattern on sample lines with each grep; the #6 trial missed 4 placeholders in `specs/` | 6 Nov |
| The placeholder check `(^\|[^$])\{\{[^}]*\}\}` matches nothing with Claude Code's `grep`, even `a {{X}} b`. With `command grep` (BSD grep 2.6.0-FreeBSD, macOS) it matches `{{X}}` at a line's start, mid-line and next to `${{ … }}`, and doesn't match `${{ secrets.A }}` | `echo '<line>' \| grep -cE '<pattern>'`, then the same with `command grep`, in a Claude Code Bash call. `type -a grep` shows the shell function | 6 Nov |
| The skill's exact step-4 command, run in a Claude Code Bash call, finds 49 placeholders in the unfilled templates. `check.sh` fails if step 4 goes back to plain `grep` or uses a different pattern, and still passes on a Helm-style `{{ x` | The command copied from SKILL.md, run on a fresh copy of the templates; self-test of `check.sh` on a scratch copy | 6 Nov |
| Inside Claude Code, a check that prints leftovers catches an unlisted `{{SURPRISE}}` planted in a template, and prints nothing once they're filled. This trial ran an earlier, shorter pattern with plain `grep`; the merged `command grep` version was checked by the row above, not by a trial | Headless trial with the planted placeholder; the check's output read from the stream-json log | 6 Nov |
| `tools/check-faults.sh` passes all 18 cases (a clean copy, 14 faults, 3 harmless changes). It reports a fault whose change matched nothing. Deleting any one of the 8 checks in `check.sh` makes it fail | `bash tools/check-faults.sh`; a scratch copy with one fault's change broken; each check removed in turn from a scratch copy of `check.sh` | 6 Nov |
| In a headless run with most answers missing, `/v-start` wrote no questions in its final reply. It put 12 open items under Open in `docs/PRD.md` as TBD, marked "to be asked as MCQs in the next live session", and still filled every placeholder | Headless trial in a scratch folder; final reply and `docs/PRD.md` read after the run | 6 Nov |
| With no question tool, headless `/v-spec` wrote no questions in its reply and put 9 in the spec's Open questions table. Headless `/v-discover` did the same with 8, under Open in `docs/PRD.md`. Neither picked an answer | Headless trials on the trial project; final replies, the spec and `docs/PRD.md` read after each run | 6 Nov |
| A headless `/v-start` run on Opus 5.5 costs $0.55–0.60: about 38.7K cache-write tokens, 581K cache-read, 13.3K output, about 50 turns, 2 minutes. List prices ($4 input, $20 output, $5 cache write, $0.20 cache read per 1M tokens) reproduce the reported cost | `total_cost_usd` and `usage` in the stream-json logs of 4 trials; prices from the claude-api skill's model table (cached 6 Oct 2026) and its `prompt-caching.md` | 6 Nov |
| `claude plugin eval` runs each case 3 times plus a no-plugin baseline by default. `--runs`, `--ablation none` and `--max-cost-usd` change that | `claude plugin eval --help` (CLI 2.1.318) | 6 Nov |
| A fresh install from GitHub (`claude plugin marketplace add sovithyea/v-start`, then `install`) gives 0.5.0 on a clean config | `CLAUDE_CONFIG_DIR` set to an empty scratch folder | 6 Nov |
| Guarantee 5 scans the whole repo and prints file names only, never the name. It reads `PRIVATE_NAMES`, falling back to `.private-names` when the variable is empty or only whitespace. It skips with a notice when there's no list, but fails when `REQUIRE_PRIVATE_NAMES=true`. A bad pattern fails with grep's own error. `check-faults.sh` covers each case with made-up names. On PR #19's CI it ran with the secret | `bash tools/check-faults.sh`; the PR #19 guarantees log shows no "skipped" line | 6 Nov |
| After the history rewrite, a fresh clone of GitHub has 39 commits and none names the private projects, in files or messages. `main` is the only branch. Issues #1, #6 and #12 no longer name them. The installed plugin's marketplace copy is on the new history | `git clone`, then a case-insensitive search of `git log --all -p`; `git ls-remote --heads`; `gh api` on each issue; `git -C ~/.claude/plugins/marketplaces/v-start log` | 6 Nov |
| On a GitHub runner: `claude plugin validate` works without signing in, gitleaks scanned 6 commits and found no leaks, and the commit check passed | PR #4 CI logs (runs 41946092639, 41946092598, 41946092593) | 5 Nov |

## Unverified

- The four stack preset CI files haven't run on a real PR yet.
- A friend's first run.
- That refresh mode asks the Open `TBD` items in a live session (added after the headless trial, which can't ask).
- Round 1b's search of the folders next to the repo (`find ..`): in the #6 headless trial, Claude Code blocked `find` outside the working folder, so it fell back to asking "None / I'll type a path". An interactive run should ask permission instead. Not seen yet.
- Sonnet 5.5 at about $0.35 and Haiku 5.5 at about $0.02 per `/v-start` run: estimates that assume Opus's token counts and turns.
- Whether CI can use a Claude subscription instead of a paid API key.
- That old commits are gone from GitHub's cached views and PR pages, and from the edit history of issues #1, #6 and #12. That needs GitHub Support (request drafted, sent by Vith).

## Corrections

- **C1:** The skill told agents to run `cp -Rn`, believing it was safe in adopt mode. On macOS it exits 1 when it skips a file, so chained steps stop. The copy is now `rsync -a --ignore-existing`.
- **C3:** `CLAUDE.md` said guarantee 2 fills the templates, but `check.sh` only checked that placeholders were listed. Found by the code review of PR #4. `check.sh` now fills them.
- **C2:** The solo-merge step pointed at "hard rule 4", but that rule had moved to 12. Fixed in 0.2.0 by naming the rule instead of its number.
- **C4:** The skill's placeholder check, `grep -rnE '(^|[^$])\{\{[^}]*\}\}'`, was believed to find any leftover `{{…}}`. Inside Claude Code, `grep` runs ugrep, and that pattern matched nothing there, so the check always looked clean. Found in the #6 trial. The skill now calls `command grep`, which skips the shell function, with the same pattern. `check.sh` fails if it stops doing that (#11).
