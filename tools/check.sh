#!/usr/bin/env bash
# The guarantees in CLAUDE.md that a script can check (2 to 5). Guarantee 1 is `claude plugin validate .`.
# Usage: bash tools/check.sh [repo-root]
set -euo pipefail
root="${1:-.}"
skill="$root/skills/v-start"
fail=0
leftover='(^|[^$])\{\{[^}]*\}\}'   # any {{…}}; GitHub's ${{ … }} is expected

# 2. Fill the templates and add-ons the way /v-start does, with every placeholder from SKILL.md's
#    fill table, and fail if any {{…}} is left.
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
cp -R "$skill/templates/." "$skill/references" "$tmp/"
names=$(grep -E '^\| `\{\{' "$skill/SKILL.md" | grep -oE '\{\{[A-Z_]+\}\}' | sort -u || true)
[ -n "$names" ] || { echo "no fill table found in skills/v-start/SKILL.md"; exit 1; }
for name in $names; do
  grep -rlF "$name" "$tmp" | while IFS= read -r f; do
    perl -pi -e "s/\Q$name\E/filled/g" "$f"
  done
done
if grep -rnE "$leftover" "$tmp"; then
  echo "placeholders above aren't in the fill table in skills/v-start/SKILL.md, so /v-start would leave them"; fail=1
fi
# The skill's own check must call `command grep`: inside Claude Code, plain grep runs ugrep, which misses every match (C4).
grep -qF "Check: \`command grep -rnE --exclude-dir=node_modules --exclude-dir=.git '$leftover'" "$skill/SKILL.md" ||
  { echo "SKILL.md step 4 must check with \`command grep\` and the same pattern as check.sh (C4)"; fail=1; }

# 3. Every bundled skill v-start didn't write is credited in THIRD_PARTY.md, by its exact path.
ours="v-start v-discover v-spec ios-simulator"   # first-party skills; add new ones here
for dir in "$root"/skills/*/; do
  name=$(basename "$dir")
  [[ " $ours " == *" $name "* ]] && continue
  grep -qF "\`skills/$name\`" "$root/THIRD_PARTY.md" || { echo "skills/$name is not credited in THIRD_PARTY.md"; fail=1; }
done

# 4. Companion tools are asked about first, and gstack is pinned to the same release and commit everywhere (D004).
#    shortcut: this checks the text only, until #7 tests what /v-start does.
grep -qF '## 5. Companion tools (ask first)' "$skill/SKILL.md" || { echo "skills/v-start/SKILL.md lost its 'ask first' companion step (D004)"; fail=1; }
if grep -niF 'install automatically' "$skill/SKILL.md"; then echo "skills/v-start/SKILL.md installs without asking again (D004)"; fail=1; fi
pin() { grep -m1 'garrytan/gstack' "$1" | grep -oE -- '--branch [^ ]+|rev-parse HEAD|[0-9a-f]{40}' | tr '\n' ' ' || true; }
skill_pin=$(pin "$skill/SKILL.md"); readme_pin=$(pin "$root/README.md")
if ! [[ "$skill_pin" =~ ^--branch\ [^\ ]+\ rev-parse\ HEAD\ [0-9a-f]{40}\ $ ]] || [ "$skill_pin" != "$readme_pin" ]; then
  echo "gstack pin differs, or lacks its commit check: SKILL.md '$skill_pin', README.md '$readme_pin'"; fail=1
fi

# 5. What users' agents read (skills/, .claude-plugin/, README.md) never names the owner's private projects or folder (#6, #18).
#    The names live outside the repo: PRIVATE_NAMES (CI secret), or a gitignored .private-names file, one pattern per line.
#    It prints file names only, never the matching lines, so a hit can't put a name in a public CI log.
pats="$tmp/private-names"
{ [ -n "${PRIVATE_NAMES:-}" ] && printf '%s
' "$PRIVATE_NAMES" || cat "$root/.private-names" 2>/dev/null || true; } |
  tr -d '
' | grep -v '^[[:space:]]*$' > "$pats" || true
if [ ! -s "$pats" ]; then
  if [ "${REQUIRE_PRIVATE_NAMES:-}" = true ]; then
    echo "guarantee 5 has no list: the PRIVATE_NAMES secret is missing on this repo"; fail=1
  else
    echo "guarantee 5 skipped: no PRIVATE_NAMES or .private-names (only the owner has the list)"
  fi
else
  rc=0; hits=$(grep -rlE -f "$pats" "$root/skills" "$root/.claude-plugin" "$root/README.md" 2>/dev/null) || rc=$?
  case $rc in
    0) printf '%s
' "$hits"; echo "private project names or paths are in the files above and would ship to users"; fail=1 ;;
    1) ;;
    *) echo "the private-context scan failed: a path is missing or a pattern in the list is bad"; fail=1 ;;
  esac
fi

[ $fail -eq 0 ] && echo "check.sh: all guarantees hold"
exit $fail
