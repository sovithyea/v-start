---
name: v-discover
description: Week 0 discovery for a v-start project. Read the real thing (existing code, a live app, data, call notes, comparable products), record what was observed in docs/VERIFIED.md with sources, log risks and open questions, and optionally make a stakeholder brief and clickable mocks, all before spec 1. Use when the user says "/v-discover", "week 0", "discovery", "research before we spec", or "what's actually there".
---

# v-discover

Learn what's really there before writing spec 1. Every claim gets a source; nothing here is written from memory (hard rule 3). It's all read-only.

**Ask every choice as AskUserQuestion multiple choice**, in as many rounds as needed, with the recommended option first. Keep the prose short. **Never write a question in a reply**: if it needs an answer, it's an MCQ. **Get everything before you choose**: ask until you have every answer a choice needs. If AskUserQuestion isn't available or returns an error, put the questions under **Open** in `docs/PRD.md` instead of listing them.

## 1. Read the ledgers

`CLAUDE.md`, `docs/PROFILE.md` and `CLAUDE.local.md` (adapt to them: the experience level sets how much you explain, the priority sets the trade-offs, and the platforms set where things get checked), `docs/PROGRESS.md`, `docs/PRD.md`, `docs/VERIFIED.md`. If they don't exist, offer `/v-start` first.

## 2. Ask what to discover (multiSelect, as many rounds as needed)

- **Existing code:** a repo to read. Get the path or URL, plus the branch and commit.
- **A live app:** staging or production, to walk through read-only.
- **Data:** a database to query read-only, aggregates only.
- **Call or meeting notes:** files or pasted text.
- **Comparable products:** what others built (these are leads, never evidence).
- **Users:** who they are and what they do today.

For each target, ask about access: do I have it / you'll grant it / skip it.

## 3. Discover, safely

- **Production is look-only** (hard rule 9). Run queries inside `begin transaction read only`, aggregates only. Never open a page that writes when it loads. When you're unsure, ask first.
- **Code:** read the source, and cite `path:line` at a named commit.
- **Live app:** walk it in a real browser (gstack `browse`, or Claude in Chrome) with screenshots. Synthetic data only in anything saved.
- **Notes:** save redacted summaries to `docs/source/<kind>-<date>.md`, with no personal data.
- **Agents:** run independent targets in parallel with subagents (Sonnet for research). Give each one the read-only rules above.

## 4. Record

- **`docs/VERIFIED.md`:** each fact, how it was observed (file, command or URL), and when. Anything heard but not seen goes under **Unverified**.
- **`docs/RISKS.md`:** what the code won't tell you, each with an owner and a next step.
- **`docs/PRD.md`:** move what the owner confirmed into **Confirmed**, and add new questions to **Open**.
- **`docs/DECISIONS.md`:** only decisions the owner actually made in this session.
- **Corrections:** when something contradicts an earlier doc, fix it and log a C-number.

## 5. Show stakeholders (ask first)

Offer as an MCQ: a brief / clickable mocks / both / neither.

- **Brief:** a Claude Doc with what we found, the risks, the open questions and the proposed first piece of work. The repo copy goes in `docs/discovery.md`, and it stays the source of truth.
- **Mocks:** a clickable HTML artifact of the main flow, with synthetic data, checked at 390px first. Run an `impeccable` critique if it's installed, and fix the high-severity findings. Save the file in `docs/`.

## 6. Close

- A PROGRESS session entry: what was read, what was found, and what's still unverified.
- End with an MCQ: **`/v-spec`** for the first piece of work (Recommended) / more discovery / stop.
