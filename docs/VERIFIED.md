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
| `tools/check.sh` fails on a stray placeholder and on an uncredited skill | Self-test on a scratch copy with both faults injected | 5 Nov |

## Unverified

- The secret scan and the stack CI files haven't run on a real PR yet.
- `claude plugin validate` hasn't run on a GitHub runner (step 2 adds it).
- A friend's first run.

## Corrections

- **C1:** The skill told agents to run `cp -Rn`, believing it was safe in adopt mode. On macOS it exits 1 when it skips a file, so chained steps stop. The copy is now `rsync -a --ignore-existing`.
- **C2:** The solo-merge step pointed at "hard rule 4", but that rule had moved to 12. Fixed in 0.2.0 by naming the rule instead of its number.
