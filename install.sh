#!/bin/bash

# UI Constitution Installer
# Installs the UI Constitution skill for Cursor

set -e

SKILL_NAME="ui-constitution"
SKILL_DIR="$HOME/.cursor/skills/$SKILL_NAME"
SKILL_URL="https://ui-constitution-a0462cfa89aa.herokuapp.com/SKILL.md"

echo ""
echo "  ╭─────────────────────────────────────╮"
echo "  │       UI Constitution Installer     │"
echo "  ╰─────────────────────────────────────╯"
echo ""

# Create skills directory if it doesn't exist
if [ ! -d "$HOME/.cursor/skills" ]; then
    echo "→ Creating skills directory..."
    mkdir -p "$HOME/.cursor/skills"
fi

# Create skill folder
if [ -d "$SKILL_DIR" ]; then
    echo "→ Updating existing installation..."
    rm -rf "$SKILL_DIR"
fi

mkdir -p "$SKILL_DIR"

# Download SKILL.md
echo "→ Downloading UI Constitution..."
curl -fsSL "$SKILL_URL" -o "$SKILL_DIR/SKILL.md"

echo ""
echo "✓ Installed to $SKILL_DIR"
echo ""
echo "  Usage: /ui"
echo ""
echo "  The agent applies all rules automatically"
echo "  when building or reviewing UI."
echo ""
echo "  Restart Cursor to activate."
echo ""
