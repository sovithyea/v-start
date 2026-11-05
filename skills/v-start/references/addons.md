# Add-on rule blocks

Paste only the blocks that apply into the new `CLAUDE.md`. Each one came from a real incident in a previous project, and the source is noted so the reason can be traced. Renumber the hard rules after pasting.

---

## Supabase  *(an earlier project, an earlier project)*

Paste into **Hard rules**:

```markdown
**N. Row-level security is the access-control story.**
- RLS is on and deny-by-default on every new table. Revoke the table grants from `authenticated` first, then add policies.
- Admit staff with a **positive** check (`coalesce(purpose,'') = ''`, or an explicit role), never a negative one (`<> 'some_role'`). A negative check lets in every new kind of user nobody thought of.
- The service-role key and `DATABASE_URL` never reach client code, and are never used to serve an anonymous request. Grant that access database-side instead: an RLS policy, or a `security definer` function.
- `security definer` functions pin `search_path` (`set search_path = ''`, or `public, pg_temp`), and schema-qualify what they name.
- A new column under a column-level grant is unreadable until it's added to the grant list. Check before assuming a client can see it.
- Permission changes need RLS tests that prove one user can't see another's rows.

**N. Every script refuses any project but dev** (hard rule 9). A migration reaches production only after dev, and only when {{OWNER}} says so.

**N. Apply a migration to the shared dev database as late as you can, and merge its file promptly.** A migration applied from an unmerged branch records a version that every other branch's deploy then fails on. The fix is to merge the file, never `supabase migration repair`.
```

Paste into **Working here**:

```markdown
- The free-plan dev project auto-pauses after 7 idle days. Every data call then fails with a DNS or 503 error; restore it from the Supabase dashboard.
```

---

## Next.js / Vercel  *(an earlier project, an earlier project)*

Paste into **Hard rules**:

```markdown
**N. This is not the Next.js you know.** Read the guide in `node_modules/next/dist/docs/` before writing Next.js code, and heed deprecation notices.
- Server-only code starts with `import 'server-only';`.
- If `pnpm typecheck` fails on a file under `.next/` after a route rename, `rm -rf .next`. Never bypass the hook.
```

---

## Expo / React Native  *(an earlier project)*

Paste into **Hard rules**:

```markdown
**N. The phone has no server.** The app uses `supabase-js` with the anon key only. Anything secret (service-role key, API keys) ships in the binary if it's in the app, so it lives in an Edge Function or a database function instead.
- Check every layout at 390pt first.
- Pick libraries that support iOS and Android in Expo, even while only one platform is being tested.
```

Paste into **Working here**:

```markdown
- To run Metro from a worktree, run `npm ci` there: Metro can't resolve a symlinked `node_modules` ("Unable to resolve expo").
```

---

## AI / LLM features  *(an earlier project, an earlier project)*

Paste into **What this repo is**, as **The guarantees**, and fill in the guarantees themselves:

```markdown
**The guarantees are code, not prompts.** Prompts get talked around; checks don't. Each guarantee below has a check in `src/checks/` (or wherever), and a test that fails if the check is removed.

1. **Grounding.** Never show a name, fact or API that isn't in the verified source. …
2. …
```

Paste into **Hard rules**:

```markdown
**N. Every model call costs money or quota.** Scripts that call a model say so in their help text, and need `--yes` to run in bulk.
```

---

## UI work and visual PRs  *(an earlier project, an earlier project)*

Paste into **Hard rules**:

```markdown
**N. Visual PRs.** A PR that changes a screen MUST include:
- before and after screenshots, at 390px and desktop;
- a GIF when it changes a flow;
- the preview link;
- an `impeccable` critique with no unresolved high-severity findings.

Take the screenshots in a real browser (gstack `browse`, or `ui-screenshots` for Playwright captures), so problems are seen, not guessed. Mark what changed with `image-annotations`. Put them in the PR with `pr-screenshots`, and make GIFs with `screen-recording`.

**N. Design from the system that's already there.** Colour, type and spacing come from the theme's tokens. Never put a colour literal in a component. If a design needs something the system doesn't have, that's a scope decision for {{OWNER}}, not a licence to invent.
```

---

## Personal or children's data  *(an earlier project, an earlier project, an earlier project)*

Paste into **Hard rules**:

```markdown
**N. Real personal data stays out.** Synthetic data only in prompts, fixtures, tests, logs, screenshots, issues and PRs. A test enforces it where it can. Any exception is a recorded decision that names exactly what it covers.
- Store an ID, never a name, where a name isn't needed.
- Commit a fixture only after a privacy pass. File names and project titles often carry a person's name.
```

If the users are children, add to **What this repo is**:

```markdown
**Voice:** one idea per sentence. Never "simply", "just" or "easy", because they tell a stuck child that the thing they can't do is obvious. No inflated praise.
```

---

## Client engagement: two repos  *(an earlier project)*

Use this when the code lives in someone else's repo and this repo holds the process. Paste into **What this repo is**:

```markdown
## Two repos

| Repo | Holds | Who merges |
|---|---|---|
| this one | Harness, specs, ledgers, mocks, the issue board | {{APPROVER}} |
| `<client>/<repo>` | All application code | The client, after {{APPROVER}} reviews |

**In the client's repo, their rules govern the code.** This harness governs process only. If the two conflict, theirs wins there; raise the conflict with {{APPROVER}}, and never work around it.
```

Paste into **Hard rules**:

```markdown
**N. Production is look-only for us too** (hard rule 9): run queries inside `begin transaction read only`. Some pages write just by loading them; list those here, and never open them on production.

**N. Nothing billable without the client's approval.** State the cost first.

**N. Everything is handed over.** Write so the client's own sessions can carry on without us.
```

---

## Parallel sessions  *(an earlier project, an earlier project)*

Use this when several agent sessions share the checkout. Paste into **Working here**:

```markdown
- **Never `git add -A` in a worktree you haven't just updated.** A branch ref can move while a worktree's files stay behind, and a blanket add then stages a revert nobody wrote. First run `git status`, `git fetch`, and `git log --oneline -1 origin/<branch>`.
- **A branch lives in one worktree at a time.** Don't switch another session's tree; take a new branch, or ask.
- **Before merging a stacked branch,** check what comes with it: `git log --oneline origin/main..origin/<branch>`.
```

---

## Generated files, snapshots and branches  *(an earlier project)*

Use this when the repo has generators, golden snapshots or one branch per component. Paste into **Hard rules**:

```markdown
**N. Generated content is generated.** A file marked GENERATED at the top is never edited by hand. Change the generator and re-run it.

**N. Read a snapshot diff before committing it.** `UPDATE_SNAPSHOTS=1` rewrites without comparing. A snapshot rewritten without reading is how a regression becomes the expected output.

**N. Create a branch when the work starts, not before, and delete it once it merges.** A branch made in advance points at a stale `main` the moment `main` moves.
```
