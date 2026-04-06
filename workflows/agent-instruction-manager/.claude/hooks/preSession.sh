#!/usr/bin/env bash
set -euo pipefail

# Pre-session hook: Create Claude.md from Agents.md if it doesn't exist
# This runs before a Claude Code session starts

readonly PROJECT_ROOT="${1:-}"
readonly AGENTS_FILE="Agents.md"
readonly CLAUDE_FILE="Claude.md"

main() {
    # Validate project root directory
    if [[ -z "$PROJECT_ROOT" ]]; then
        echo "Pre-session: Error - No project root directory provided" >&2
        return 1
    fi

    if [[ ! -d "$PROJECT_ROOT" ]]; then
        echo "Pre-session: Error - Invalid project root directory: $PROJECT_ROOT" >&2
        return 1
    fi

    cd "$PROJECT_ROOT" || return 1

    # Create Claude.md from Agents.md if needed
    if [[ -f "$AGENTS_FILE" && ! -f "$CLAUDE_FILE" ]]; then
        echo "Pre-session: Creating $CLAUDE_FILE from $AGENTS_FILE"
        cp "$AGENTS_FILE" "$CLAUDE_FILE"
    elif [[ ! -f "$AGENTS_FILE" ]]; then
        echo "Pre-session: No action needed - $AGENTS_FILE not found"
    else
        echo "Pre-session: No action needed - $CLAUDE_FILE already exists"
    fi
}

main "$@"