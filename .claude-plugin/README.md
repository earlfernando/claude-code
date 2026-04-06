# Agent Instruction Manager

Automatically manages agent instruction files based on Claude Code session state.

## Features

- Creates `Claude.md` from `Agents.md` when session starts
- Renames `Claude.md` back to `Agents.md` when session ends
- Only operates when no other Claude sessions are active in the directory

## Usage

1. Create `Agents.md` in your project root with agent instructions
2. Start Claude Code session - `Claude.md` is automatically created
3. End session - `Claude.md` is renamed back to `Agents.md`

## Author

Earl