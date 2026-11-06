# Privacy

v-start doesn't collect, store or send any data about you or your projects.

- No telemetry, analytics or tracking.
- It has no servers. It runs on your own machine, inside Claude Code.
- When you say yes, it uses tools you already have, with your own accounts: git, the GitHub CLI (to create a repo, labels, a board and issues), Claude Code's plugin installer (for optional helper tools), and npx (to scaffold the stack you pick, which downloads packages from npm). Those actions go to GitHub, npm or the tool's own source, under their privacy policies.
- The CI files it adds to your repo download gitleaks, a secret scanner, when they run in your GitHub Actions.
- The files it writes stay in your project. `CLAUDE.local.md`, which holds your preferences, is gitignored, so it's never committed.
- Your conversations with Claude are covered by Anthropic's privacy policy, not this one.

Questions? Open an issue: https://github.com/sovithyea/v-start/issues

Last updated: 6 November 2026
