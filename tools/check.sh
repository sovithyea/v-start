#!/usr/bin/env bash
# The guarantees in CLAUDE.md that a script can check (2 and 3). Guarantee 1 is `claude plugin validate .`.
# Usage: bash tools/check.sh [repo-root]
set -euo pipefail
root="${1:-.}"
skill="$root/skills/v-start"
fail=0

# 2. Every {{PLACEHOLDER}} the templates or add-ons use is one /v-start knows to fill (its table in SKILL.md).
for name in $(grep -rhoE '\{\{[A-Z_]+\}\}' "$skill/templates" "$skill/references" | sort -u); do
  grep -qF "\`$name\`" "$skill/SKILL.md" || { echo "placeholder $name is used but missing from the table in skills/v-start/SKILL.md"; fail=1; }
done

# 3. Every bundled skill v-start didn't write is credited in THIRD_PARTY.md.
ours="v-start v-discover v-spec ios-simulator"
for dir in "$root"/skills/*/; do
  name=$(basename "$dir")
  [[ " $ours " == *" $name "* ]] && continue
  grep -qF "skills/$name" "$root/THIRD_PARTY.md" || { echo "skills/$name is not credited in THIRD_PARTY.md"; fail=1; }
done

[ $fail -eq 0 ] && echo "check.sh: all guarantees hold"
exit $fail
