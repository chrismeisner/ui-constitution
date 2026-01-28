#!/bin/bash

# UI Constitution Installer
# Installs or updates the UI Constitution skill for Cursor

set -e

SKILL_NAME="ui-constitution"
SKILL_DIR="$HOME/.cursor/skills/$SKILL_NAME"
SKILL_URL="https://ui-constitution-a0462cfa89aa.herokuapp.com/SKILL.md"
VERSION_URL="https://ui-constitution-a0462cfa89aa.herokuapp.com/version.txt"

echo ""
echo "  ╭─────────────────────────────────────╮"
echo "  │         UI Constitution             │"
echo "  ╰─────────────────────────────────────╯"
echo ""

# Check if this is an update
IS_UPDATE=false
if [ -f "$SKILL_DIR/SKILL.md" ]; then
    IS_UPDATE=true
    OLD_VERSION=$(grep -m1 'version:' "$SKILL_DIR/SKILL.md" 2>/dev/null | sed 's/version: //' || echo "unknown")
fi

# Create skills directory if it doesn't exist
if [ ! -d "$HOME/.cursor/skills" ]; then
    mkdir -p "$HOME/.cursor/skills"
fi

# Create/recreate skill folder
mkdir -p "$SKILL_DIR"

# Download SKILL.md
if [ "$IS_UPDATE" = true ]; then
    echo "→ Updating from v$OLD_VERSION..."
else
    echo "→ Installing..."
fi

curl -fsSL "$SKILL_URL" -o "$SKILL_DIR/SKILL.md"

# Get new version
NEW_VERSION=$(grep -m1 'version:' "$SKILL_DIR/SKILL.md" 2>/dev/null | sed 's/version: //' || echo "unknown")

echo ""
if [ "$IS_UPDATE" = true ]; then
    echo "✓ Updated to v$NEW_VERSION"
else
    echo "✓ Installed v$NEW_VERSION"
fi
echo ""
echo "  Location: $SKILL_DIR"
echo ""
echo "  Usage: /ui"
echo ""
echo "  To update later, run this same command again."
echo ""
