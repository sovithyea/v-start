# Stack presets

Offer these only after the harness is in place and the stack is recorded as **D002**. Each preset adds one dependency set, so it's a decision. Run the scaffold into the repo root, keep the harness files, and set `{{CHECK}}` in `CLAUDE.md` and `docs/WORKFLOW.md` to the preset's check line.

Copy the preset's CI file to `.github/workflows/checks.yml`. Scaffolders that write their own `README.md`, `CLAUDE.md`, `AGENTS.md` or `.gitignore` must not replace ours: merge their content into ours (keep `CLAUDE.local.md` ignored), then delete theirs.

## Next.js + Supabase + Vercel  *(an earlier project, an earlier project web)*

```bash
pnpm create next-app@latest web-tmp --ts --eslint --app --src-dir --use-pnpm --yes   # into a temp dir, then move in, so it can't clobber the harness
pnpm add @supabase/supabase-js @supabase/ssr
pnpm add -D vitest @playwright/test
pnpm dlx supabase init
```

- Add scripts: `"typecheck": "tsc --noEmit"`, `"test": "vitest run"`.
- **Check:** `pnpm typecheck && pnpm lint && pnpm test && pnpm build`
- **CI:** `presets/nextjs-supabase.yml` (verify + Playwright e2e).
- **Add-ons:** Supabase, Next.js / Vercel, UI work.

## Expo + Supabase  *(an earlier project)*

```bash
npx create-expo-app@latest app-tmp --yes     # then move in
npx expo install @supabase/supabase-js @react-native-async-storage/async-storage
```

- **Check:** `npx tsc --noEmit && npx expo lint`
- **CI:** `presets/expo-supabase.yml`.
- **Add-ons:** Supabase, Expo, UI work. Use the bundled `ios-simulator` skill for Simulator checks.

## Python + uv  *(an earlier project tools)*

```bash
uv init --app .
uv add --dev pytest ruff
```

- **Check:** `uv run ruff check && uv run ruff format --check && uv run pytest`
- **CI:** `presets/python-uv.yml`.

## Node + TypeScript, no build step  *(an earlier project)*

```bash
npm init -y && npm pkg set type=module
npm pkg set scripts.typecheck="tsc --noEmit" scripts.test="node --test tests/"
npm i -D typescript @types/node
```

- `tsconfig.json`: `"noEmit": true`, `"allowImportingTsExtensions": true`, `"erasableSyntaxOnly": true`. Import paths carry `.ts`.
- **Constructor parameter properties don't work** under type stripping. Declare the field and assign it in the body.
- **Check:** `npm run typecheck && npm test`
- **CI:** `presets/node-ts.yml`.
