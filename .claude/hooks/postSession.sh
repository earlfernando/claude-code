#!/usr/bin/env bash
set -euo pipefail

# Post-session hook: Rename Claude.md to Agents.md if no other sessions in this directory
# This runs after a Claude Code session ends

readonly PROJECT_ROOT="${1:-}"
readonly AGENTS_FILE="Agents.md"
readonly CLAUDE_FILE="Claude.md"

# Check if there are any OTHER Claude sessions in THIS directory
check_active_sessions_in_project() {
    local -r project_dir="$1"
    local session_count=0
    local pid pid_dir

    # Get all Claude process PIDs
    local claude_pids
    claude_pids=$(pgrep claude 2>/dev/null) || return 1

    # Check each Claude process to see if it's in this project directory
    while IFS= read -r pid; do
        pid_dir=$(pwdx "$pid" 2>/dev/null | awk '{print $2}') || continue

        if [[ "$pid_dir" == "$project_dir" ]]; then
            ((session_count++))
        fi
    done <<< "$claude_pids"

    # If 0 or 1 sessions in this directory, no OTHER sessions exist
    # (the current session ending might still be counted)
    if ((session_count <= 1)); then
        return 1  # No other sessions in this project
    else
        return 0  # Other sessions exist in this project
    fi
}

main() {
    # Validate project root directory
    if [[ -z "$PROJECT_ROOT" ]]; then
        echo "Post-session: Error - No project root directory provided" >&2
        return 1
    fi

    if [[ ! -d "$PROJECT_ROOT" ]]; then
        echo "Post-session: Error - Invalid project root directory: $PROJECT_ROOT" >&2
        return 1
    fi

    cd "$PROJECT_ROOT" || return 1

    # Check if Claude.md exists
    if [[ ! -f "$CLAUDE_FILE" ]]; then
        echo "Post-session: No action needed - $CLAUDE_FILE not found"
        return 0
    fi

    # Check if there are any other active sessions in THIS project
    if ! check_active_sessions_in_project "$PROJECT_ROOT"; then
        echo "Post-session: No other sessions in this project. Renaming $CLAUDE_FILE to $AGENTS_FILE"
        mv "$CLAUDE_FILE" "$AGENTS_FILE"
    else
        echo "Post-session: Other sessions active in this project. Keeping $CLAUDE_FILE"
    fi
}

main "$@"