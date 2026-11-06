#!/usr/bin/env bash
# Proves every check in tools/check.sh still works (hard rule 6, #10). It copies the repo, breaks one
# thing at a time, and fails unless check.sh fails with that check's own message. Harmless changes must pass.
# Usage: bash tools/check-faults.sh
set -uo pipefail
repo=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d); trap 'rm -rf "$work"' EXIT
bad=0
# Guarantee 5 gets made-up names here, so this file never holds the real list.
export PRIVATE_NAMES='[Zz]ebracorn|Quokka ?Works|Desktop/hideout'

sums() { (cd "$work/r" && find . -type f -exec cksum {} + | sort | cksum); }

# fault NAME EXPECT CHANGE [ENV]: EXPECT is text check.sh must print, or "pass" when CHANGE is harmless.
# ENV (optional) is VAR=value pairs for check.sh.
fault() {
  rm -rf "$work/r" && mkdir "$work/r" &&
    cp -R "$repo/skills" "$repo/.claude-plugin" "$repo/README.md" "$repo/THIRD_PARTY.md" "$work/r/" ||
    { echo "FAIL  $1 (couldn't copy the repo)"; bad=1; return; }
  before=$(sums)
  (cd "$work/r" && eval "$3")
  if [ "$3" != true ] && [ "$(sums)" = "$before" ]; then echo "FAIL  $1 (the change matched nothing)"; bad=1; return; fi
  out=$(env ${4:-} bash "$repo/tools/check.sh" "$work/r" 2>&1); rc=$?
  if [ "$2" = pass ]; then [ $rc -eq 0 ]; else [ $rc -ne 0 ] && grep -qF -- "$2" <<<"$out"; fi && { echo "ok    $1"; return; }
  echo "FAIL  $1 (exit $rc, expected: $2)"; bad=1
}

fault "clean copy" pass "true"

# 2. placeholders
fault "fill table gone" "no fill table found" "perl -ni -e 'print unless /^\| \x60\{\{/' skills/v-start/SKILL.md"
fault "unlisted placeholder" "aren't in the fill table" "echo '{{PROJECT_2}}' >> skills/v-start/templates/docs/RISKS.md"
fault "lower-case placeholder" "aren't in the fill table" "echo 'x {{lower}} y' >> skills/v-start/templates/README.md"
fault "GitHub expression" pass "echo 'run: \${{ github.sha }}' >> skills/v-start/templates/README.md"
fault "Helm-style braces" pass "echo 'see {{ x' >> skills/v-start/templates/README.md"
fault "skill's check uses plain grep" "must check with \`command grep\`" "perl -pi -e 's/Check: \`command grep/Check: \`grep/' skills/v-start/SKILL.md"

# 3. licences
fault "uncredited skill" "skills/stray is not credited" "mkdir skills/stray && echo x > skills/stray/SKILL.md"
fault "skill named like a credited one" "skills/pr is not credited" "mkdir skills/pr && echo x > skills/pr/SKILL.md"

# 4. ask before installs, gstack pin
fault "ask-first step gone" "lost its 'ask first'" "perl -pi -e 's/\(ask first\)/(auto)/' skills/v-start/SKILL.md"
fault "install automatically again" "installs without asking again" "echo 'Install automatically.' >> skills/v-start/SKILL.md"
fault "README gstack tag differs" "gstack pin differs" "perl -pi -e 's/--branch \S+/--branch v0.0.0/' README.md"
fault "gstack commit check gone" "gstack pin differs" "perl -pi -e 's/ && git -C \S+ rev-parse HEAD \| grep -qx [0-9a-f]{40}//' skills/v-start/SKILL.md README.md"

# 5. private context
fault "private name in a skill" "private project names" "echo 'Used in Zebracorn.' >> skills/v-spec/SKILL.md"
fault "private name in a template" "private project names" "echo 'Quokka Works' >> skills/v-start/templates/AGENTS.md"
fault "owner's folder in README" "private project names" "echo '~/Desktop/hideout' >> README.md"
fault "list in .private-names (blank line, CRLF)" "private project names" "printf '\\n[Zz]ebracorn\\r\\n' > .private-names && echo 'Zebracorn' >> README.md" "PRIVATE_NAMES="
fault "no list on this repo's own CI" "the PRIVATE_NAMES secret is missing" "true" "PRIVATE_NAMES= REQUIRE_PRIVATE_NAMES=true"
fault "plain English" pass "echo 'A zebra in the corn.' >> README.md"
fault "scanned folder missing" "the private-context scan failed" "rm -rf .claude-plugin"

# A hit must name the file, never print the matching line, so CI logs stay clean.
rm -rf "$work/r" && mkdir "$work/r" && cp -R "$repo/skills" "$repo/.claude-plugin" "$repo/README.md" "$repo/THIRD_PARTY.md" "$work/r/"
echo 'Quokka Works' >> "$work/r/README.md"
out=$(bash "$repo/tools/check.sh" "$work/r" 2>&1)
if grep -q 'README.md' <<<"$out" && ! grep -q 'Quokka' <<<"$out"; then echo "ok    a hit prints the file, not the name"
else echo "FAIL  a hit prints the file, not the name"; bad=1; fi

# With no list at all, guarantee 5 must say it skipped, and the rest must still pass.
rm -rf "$work/r" && mkdir "$work/r" && cp -R "$repo/skills" "$repo/.claude-plugin" "$repo/README.md" "$repo/THIRD_PARTY.md" "$work/r/"
out=$(PRIVATE_NAMES= bash "$repo/tools/check.sh" "$work/r" 2>&1) && grep -qF "guarantee 5 skipped" <<<"$out" &&
  echo "ok    no list: guarantee 5 skips" || { echo "FAIL  no list: guarantee 5 skips"; bad=1; }

[ $bad -eq 0 ] && echo "check-faults.sh: every check in check.sh catches its fault"
exit $bad
