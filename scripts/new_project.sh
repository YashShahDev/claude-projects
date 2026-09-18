#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NAME="${1:?Usage: new_project.sh <name> [lang]}"
LANG="${2:-generic}"
DEST="$ROOT_DIR/projects/$NAME"
TEMPLATE="$ROOT_DIR/templates/$LANG"

if [ -d "$DEST" ]; then
	echo "Error: projects/$NAME already exists" >&2
	exit 1
fi

if [ ! -d "$TEMPLATE" ]; then
	echo "Error: unknown language '$LANG' (no templates/$LANG)" >&2
	echo "Available: $(ls "$ROOT_DIR/templates")" >&2
	exit 1
fi

mkdir -p "$DEST"
cp -r "$TEMPLATE"/. "$DEST"/

for f in "$DEST"/Makefile "$DEST"/README.md; do
	[ -f "$f" ] && sed -i.bak "s/{{PROJECT_NAME}}/$NAME/g" "$f" && rm -f "$f.bak"
done

echo "Created projects/$NAME from template '$LANG'."
echo "Next: edit projects/$NAME/Makefile and README.md, then run 'make build PROJECT=$NAME' from the repo root."
