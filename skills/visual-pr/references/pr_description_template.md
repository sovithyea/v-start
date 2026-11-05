Closes #{issue} | Spec: [`specs/{name}/`]({spec link}) | {other relevant links, if any}

{The first line is required: `Closes #N` closes the issue on merge (docs/WORKFLOW.md). Use `Refs #N` instead when the PR does only part of the issue, and say what's left. Drop the spec link only when no spec applies. If the branch must merge after another PR, say so here and name the order.}

## Why the change

{Exactly one sentence explaining the problem this PR solves and what becomes possible after it ships.}

## Special things to note

- {List 1-3 reviewer-relevant warnings, migrations, constraints, deliberate omissions, or surprising decisions. Use "None." when there are no special considerations.}

## Change outline

{Use the smallest combination of the following `/show-me`-style views that explains the implementation. Prefer `diff` blocks for changes to existing shapes and complete blocks for mostly new shapes. Do not include headings for views that are not relevant.}

{...short-description...}

```diff|sql|json|etc
{Show changed SQL tables, important columns and relationships, and endpoint request/response contracts.}
```

{...short-description...}

```typescript|python|etc
{show new data structures that are key to the implementation}
```

{...short-description...}

```diff
{Show concise pseudocode for the changed behavior.}
```


{...short-description...}

```diff
{Show a shallow file tree with changed responsibilities.}
```


{...short-description...}

```diff
{Show changed React component trees, important hooks or state, and package boundaries.}
```

{...short-description...}

```diff
{Show changed call trees, call stacks, control flow, or data flow.}
```

{Tell the story in the order that makes it easiest to understand. It may make sense to show files first, or it may make sense to establish a data structure, SQL table, or API contract first. All views and subheadings are optional. Use only the views that help explain the pr, and name or order them based on the change rather than a fixed template. It should be written as one human would write to another. Use `diff` for a focused change to an existing shape. Show the complete target shape in a language-specific or `text` block when it is new, high-level, or clearer without diff notation.}

## Visuals

{Only when a screen changes: before and after at 390px and desktop, a GIF for flows, the preview link. Synthetic data only. Delete this section otherwise.}

## Evidence

- {Each acceptance criterion from the spec, or each "Done when" item from the issue, with what showed it: the command and its result, the test and what it asserts, or what was seen in the browser or on the Simulator. Split: verified by a test that would fail if it broke / checked only by reading.}
- **Not checked:** {What wasn't verified and why, e.g. Android blocked by #N. Write "Nothing." if everything was.}
