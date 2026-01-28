#!/bin/bash

# UI Constitution Installer
# Installs or updates the UI Constitution skill for Cursor
# Run: curl -fsSL https://ui-constitution-a0462cfa89aa.herokuapp.com/install.sh | sh

set -e

SKILL_NAME="ui-constitution"
CURSOR_DIR="$HOME/.cursor"
SKILLS_DIR="$CURSOR_DIR/skills"
SKILL_DIR="$SKILLS_DIR/$SKILL_NAME"
SKILL_URL="https://ui-constitution-a0462cfa89aa.herokuapp.com/SKILL.md"

echo ""
echo "  ╭─────────────────────────────────────╮"
echo "  │         UI Constitution             │"
echo "  ╰─────────────────────────────────────╯"
echo ""

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo "✗ Error: curl is required but not installed."
    exit 1
fi

# Check if this is an update
IS_UPDATE=false
OLD_VERSION="none"
if [ -f "$SKILL_DIR/SKILL.md" ]; then
    IS_UPDATE=true
    OLD_VERSION=$(grep -m1 'version:' "$SKILL_DIR/SKILL.md" 2>/dev/null | sed 's/version: //' || echo "unknown")
fi

# Step 1: Ensure .cursor directory exists
if [ ! -d "$CURSOR_DIR" ]; then
    echo "→ Creating .cursor directory..."
    mkdir -p "$CURSOR_DIR"
fi

# Step 2: Ensure skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo "→ Creating skills directory..."
    mkdir -p "$SKILLS_DIR"
fi

# Step 3: Clean up existing installation (if any) to ensure fresh install
if [ -d "$SKILL_DIR" ]; then
    if [ "$IS_UPDATE" = true ]; then
        echo "→ Updating from v$OLD_VERSION..."
    else
        echo "→ Cleaning up incomplete installation..."
    fi
    rm -rf "$SKILL_DIR"
else
    echo "→ Installing..."
fi

# Step 4: Create skill directory
mkdir -p "$SKILL_DIR"

# Step 5: Download SKILL.md
echo "→ Downloading UI Constitution..."
if ! curl -fsSL "$SKILL_URL" -o "$SKILL_DIR/SKILL.md"; then
    echo ""
    echo "✗ Error: Failed to download SKILL.md"
    echo "  Check your internet connection and try again."
    rm -rf "$SKILL_DIR"
    exit 1
fi

# Step 6: Verify download
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo ""
    echo "✗ Error: SKILL.md was not created"
    exit 1
fi

# Check file is not empty
if [ ! -s "$SKILL_DIR/SKILL.md" ]; then
    echo ""
    echo "✗ Error: SKILL.md is empty"
    rm -rf "$SKILL_DIR"
    exit 1
fi

# Step 7: Verify it's a valid skill file (has frontmatter)
if ! grep -q "^name: ui-constitution" "$SKILL_DIR/SKILL.md"; then
    echo ""
    echo "✗ Error: Downloaded file is not a valid UI Constitution skill"
    rm -rf "$SKILL_DIR"
    exit 1
fi

# Get new version
NEW_VERSION=$(grep -m1 'version:' "$SKILL_DIR/SKILL.md" 2>/dev/null | sed 's/version: //' || echo "unknown")

# Success!
echo ""
if [ "$IS_UPDATE" = true ]; then
    if [ "$OLD_VERSION" = "$NEW_VERSION" ]; then
        echo "✓ Already up to date (v$NEW_VERSION)"
    else
        echo "✓ Updated to v$NEW_VERSION (was v$OLD_VERSION)"
    fi
else
    echo "✓ Installed v$NEW_VERSION"
fi

echo ""
echo "  Location: $SKILL_DIR"
echo ""
echo "  Usage: /ui"
echo ""
echo "  Restart Cursor to activate, then invoke /ui"
echo "  when building or reviewing UI code."
echo ""
echo "  To update later, run this same command again."
echo ""
