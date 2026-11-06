# Privacy

v-start doesn't collect, store or send any data about you or your projects.

- No telemetry, analytics or tracking.
- It has no servers. It runs on your own machine, inside Claude Code.
- When you say yes, it uses tools you already have, with your own accounts: git and the GitHub CLI (to create a repo, labels, a board and issues), Claude Code's plugin installer and git (for optional helper tools, from GitHub), and package installers (npm, pip, uv, and Playwright's browser download) when you pick a stack or use the screenshot and recording skills. Those go to GitHub, npm, PyPI or Playwright's servers, under their privacy policies.
- The CI files it adds to your repo run in your GitHub Actions on every push. They download gitleaks, a secret scanner, and your stack's packages (plus Playwright's browser for Next.js).
- The files it writes stay in your project. `CLAUDE.local.md`, which holds your preferences, is gitignored, so it's never committed.
- Your conversations with Claude are covered by Anthropic's privacy policy, not this one.

Questions? Open an issue: https://github.com/sovithyea/v-start/issues

Last updated: 6 November 2026
