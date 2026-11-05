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
names=$(grep -E '^\| `\{\{' "$skill/SKILL.md" | grep -oE '\{\{[A-Z_]+\}\}' | sort -u)
[ -n "$names" ] || { echo "no fill table found in skills/v-start/SKILL.md"; exit 1; }
for name in $names; do
  grep -rlF "$name" "$tmp" | while IFS= read -r f; do
    perl -pi -e "s/\Q$name\E/filled/g" "$f"
  done
done
if grep -rnE "$leftover" "$tmp"; then
  echo "placeholders above aren't in the fill table in skills/v-start/SKILL.md, so /v-start would leave them"; fail=1
fi

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

# 5. Nothing users see names the owner's private projects or folders (#6).
if grep -rniE 'an earlier project|an earlier project|earlier|an earlier project|my workplace|projects folder' "$skill/.." "$root/.claude-plugin" "$root/README.md"; then
  echo "private project names or paths above would ship to users"; fail=1
fi

[ $fail -eq 0 ] && echo "check.sh: all guarantees hold"
exit $fail
