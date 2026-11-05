---
name: visual-pr
description: Write or update a pull request's description, with diagrams of what changed. Use whenever opening a PR or writing or refreshing a PR description in a repo, or when the user invokes visual-pr by name.
---

<!-- Adapted from humanlayer/skills (visual-pr, MIT), via the an earlier project and an earlier project copies:
     the template keeps what a v-start repo's docs/WORKFLOW.md requires, and nothing is saved inside the repo. -->

# Describe a Pull Request

Create or update the pull request for the current task with a concise description that helps a reviewer understand why the change exists and the shape of the implementation.

## Workflow

1. Read the description template:

   `Read({SKILLBASE}/references/pr_description_template.md)`

2. Identify or create the pull request:
   - Check the current branch for a PR with `gh pr view --json url,number,title,state,baseRefName,headRefName 2>/dev/null`.
   - If no PR exists, inspect `git status --short --branch` and the commits on the current branch.
   - Commit task-related changes when needed, push the branch with an upstream, and create a PR for it. Follow `CLAUDE.md`'s "Before you start a task" and `docs/WORKFLOW.md`: work in your own worktree, never commit from the shared checkout, never merge.
   - Ask the user to select a PR only when the current branch has no relevant work and there is no safe current-branch PR to create.

3. Gather only the context needed to explain the change:
   - Read the issue the PR closes and the spec it implements, if any.
   - Read the complete PR diff and enough surrounding code to understand behavior and ownership.
   - Use `gh pr view` to collect PR metadata, changed files and the current body. Keep its evidence: don't drop a check someone already recorded.
   - Check that the body's warnings are still true (a blocking issue may have closed, or `main` may have moved on).
   - Read `{SKILLBASE}/references/show-me.md` for the visual-outline conventions used in the PR body.

4. Write the PR description using the template:
   - Keep **Why the change** to exactly one sentence.
   - Keep **Special things to note** to 1-3 bullets. Prioritize reviewer warnings, migrations, compatibility constraints, deviations from the plan, or surprising decisions. Write `- None.` when there are no special considerations.
   - Make **Change outline** a compact, `/show-me`-inspired structural view rather than prose or a file-by-file changelog.
   - Include only the views that help explain this PR:
     - SQL table and endpoint contract changes, plus pseudocode for business logic.
     - key data structure / type changes
     - A shallow file tree showing changed responsibilities.
     - React component tree changes, including important hooks, state, and package boundaries.
     - Call-tree, call-stack, control-flow, or data-flow changes.
   - Prefer `diff` blocks when showing changes to an existing shape. Show the complete target shape when most of it is new or diff notation would obscure ownership or order.
   - Keep each view focused on what a reviewer needs. Omit categories that did not change.

5. Save and publish the description:
   - Save it to `{scratchpad}/pr-{number}/description.md`, never inside the repo.
   - Update the PR with `gh pr edit {number} --body-file {output-path}`.
   - Confirm the update succeeded.

6. Report completion:
   - Read `{SKILLBASE}/references/describe_pr_final_answer.md`.
   - Respond using that final answer template with the PR URL, saved description path, and concise list of changed files.

Always read and follow `{SKILLBASE}/references/pr_description_template.md`. Do not expand the PR body beyond that template.

Write as one human talking to another: avoid jargon and slang, and use simple, coherent, concise language.
