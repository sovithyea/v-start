# Workflow

How work gets picked up, specced, built, reviewed and landed.

> The key words **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT** and **MAY** are used as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119). A reviewer can reject a PR for breaking a **MUST**. Departing from a **SHOULD** needs a stated reason.

## The flow

1. **Issue**, using the task template: Why / Done when / Blocked by / Refs, plus a `type:` label. It goes on the board as In Progress.
2. **Spec and plan** in `specs/N-name/spec.md` and `plan.md`. {{APPROVER}} approves both before any code.
3. **Build** in your own worktree, off a fresh `origin/main`, on a branch named `feat/<name>`, `fix/<name>`, `docs/<name>` or `chore/<name>`. Stage files by name.
4. **Check locally:** `{{CHECK}}`. A PR opens only when it's green.
5. **PR** using the template. Its title is a Conventional Commit, because a squash-merge makes the title the commit on `main`.
6. **Review and merge:** {{APPROVER}} reviews and merges. Nobody merges their own PR.
7. **After merge:** add a PROGRESS entry and delete the branch.

## Commits

[Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/): `<type>(<scope>): <description>`. The type is `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `build`, `ci`, `style` or `revert`.

- A commit carrying a decision, a defect or a non-obvious trade-off MUST have a body explaining why, and MUST end with `Refs:` footers (`Refs: D004, C2`).
- A breaking change MUST be marked with `!` before the colon and a `BREAKING CHANGE:` footer.
- CI checks commit subjects and the PR title (`.github/workflows/commits.yml`).

## Visual PRs

In a project with screens, a PR that changes anything a person sees MUST include:

- **before and after screenshots**, at 390px (phone) and desktop;
- **a GIF**, when the change touches more than one screen;
- **the preview link**, when there is one.

Synthetic data only in every image.

## Numbers

| Prefix | Log | Where |
|---|---|---|
| D | Decisions | `docs/DECISIONS.md` |
| R | Risks | `docs/RISKS.md` |
| C | Corrections to docs that turned out wrong | `docs/VERIFIED.md` |

Before taking a number, check the log **and** open PRs.
