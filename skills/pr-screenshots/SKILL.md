---
name: pr-screenshots
description: 'Embed before/after screenshots and annotated images in pull request descriptions. Covers PR description patterns, image upload for GitHub, and sizing best practices.'
---

<!-- From github/awesome-copilot (MIT). Modified for v-start, see THIRD_PARTY.md and D011. -->

# PR Screenshots

Embed before/after screenshots in pull request descriptions so reviewers can see the visual change without checking out the branch.

## When to Use This Skill

Use this skill when a PR changes something visible:

- Layout, styling, CSS
- Charts, dashboards, data visualizations
- UI components, forms, modals
- Error messages, CLI output, log formatting

## PR Description Pattern

Place screenshots directly in the PR description body. Avoid wrapping them in `<details>` collapse — reviewers are more likely to look at images they can see without clicking.

```markdown
**Before** — brief description of the problem:

![before](url-to-before-image)

**After** — brief description of the fix:

![after](url-to-after-image)
```

Keep the text brief. A sentence or two per image describing what the reader should notice. Let the image carry most of the communication.

### Multiple changes

For PRs with several visual changes, use separate before/after pairs with headings:

```markdown
## Filter bar alignment

**Before** — 1px border clash between adjacent buttons:

![before-filters](url)

**After** — borders overlap cleanly, hover tint added:

![after-filters](url)

## Chart tooltip

**Before** — tooltip clipped at container edge:

![before-tooltip](url)

**After** — tooltip repositions to stay visible:

![after-tooltip](url)
```

## Image Sizing

- **Take screenshots at native 1x resolution** — don't resize with PIL (creates artifacts)
- **Control display size in HTML** when images are too large:
  ```html
  <img src="url" width="600" alt="description">
  ```
- **Before/after pairs must use the same viewport width and crop** — otherwise the comparison is meaningless

## Uploading Images

### GitHub

> **⚠️ Work in progress.** GitHub's drag-and-drop image upload uses internal endpoints that require browser cookies. There's no clean public API for uploading images to PR descriptions yet.

**Current workaround:** Commit images to a `pr-assets` orphan branch and reference via blob URLs (`github.com/{owner}/{repo}/blob/pr-assets/{file}?raw=true`). It works but is clunky — contributions for a better approach are welcome.

## Guidelines

1. **Capture before state BEFORE making changes** — it's easy to forget, and reconstructing the original state later is slow and error-prone
2. **Keep descriptions brief** — a sentence or two per image pointing out what changed is enough
3. **Prefer visible images over collapsed sections** — screenshots behind `<details>` tags are easy to skip
4. **Annotate when the change is subtle** — use the `image-annotations` skill to add callouts when the difference isn't immediately obvious
5. **Match viewport and crop** between before/after pairs so the comparison is meaningful

## Limitations

- GitHub image upload requires workarounds (no public API for PR description images)
- Very large images (>10MB) may not render inline on some platforms
