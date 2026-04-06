# Claude Code Workflows

Personal collection of Claude Code workflows and automation tools.

## Workflows

### Agent Instruction Manager
Automatically manages `Claude.md` and `Agents.md` files based on session state.

## Installation

Add to your Claude Code settings:

```json
{
  "extraKnownMarketplaces": {
    "earl-workflows": {
      "source": {
        "source": "github",
        "repo": "earlfernando/claude-code"
      }
    }
  }
}
```

Then enable the plugin in Claude Code.

## Structure

```
workflows/agent-instruction-manager/
├── hooks/
│   └── hooks.json              # Hook configuration
└── .claude/
    └── hooks/
        ├── preSession.sh       # Creates Claude.md from Agents.md
        └── postSession.sh      # Renames Claude.md back to Agents.md
```