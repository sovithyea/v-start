---
name: ios-simulator
description: Drive the iOS Simulator for an Expo / React Native app — screenshots, taps, typing and reloading Metro. Use when checking a mobile change on the Simulator.
---

<!-- Written for v-start, from notes kept while building an Expo app. -->

# Driving the iOS Simulator

- **Screenshots:** `xcrun simctl io booted screenshot <file>.png`.
- **Taps:** CGEvent, with the Simulator activated before **every** tap. Read the device origin from the Simulator window's `AXGroup` before each tap, because the window moves.
- **Typing:** type slowly (one keystroke at a time), or characters get dropped.
- **Reloading:** Metro started with `CI=1` doesn't hot-reload; restart it and re-open `exp://127.0.0.1:8081`.
- **Worktrees:** run `npm ci` in the worktree. Metro can't resolve a symlinked `node_modules` ("Unable to resolve expo").
- Check every layout at 390pt first.
