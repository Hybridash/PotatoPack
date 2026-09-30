#!/usr/bin/env bash
# Adds every mod listed in mods.txt to the pack (skips ones already added).
# Needs: packwiz on PATH and internet access to Modrinth.
# To REMOVE a mod: delete its line in mods.txt AND run `packwiz remove <name>`
# (or delete its file in mods/ and its line in scripts/added.txt).
set -uo pipefail
cd "$(dirname "$0")/.."

ADDED=scripts/added.txt
touch "$ADDED"
failed=()

wanted=$(sed -e 's/#.*//' -e 's/[[:space:]]//g' mods.txt | grep -v '^$')

for slug in $wanted; do
  if grep -qx "$slug" "$ADDED"; then
    echo "✓ $slug already in pack"
    continue
  fi
  echo "+ adding $slug"
  if packwiz modrinth add "$slug" -y; then
    echo "$slug" >> "$ADDED"
  else
    echo "✗ $slug has no build for this Minecraft version, skipping"
    failed+=("$slug")
  fi
done

# Iris (shaders) is optional and unticked by default
for f in mods/*.pw.toml; do
  [ -e "$f" ] || continue
  if grep -q '^name = "Iris' "$f" && ! grep -q '^\[option\]' "$f"; then
    printf '\n[option]\noptional = true\ndefault = false\ndescription = "Shaders. Only turn on if your PC can handle it."\n' >> "$f"
  fi
done

packwiz refresh

if [ ${#failed[@]} -gt 0 ]; then
  echo "::warning::No compatible version for: ${failed[*]}"
fi
exit 0
