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

## Structure

```
workflows/agent-instruction-manager/
├── .claude/
│   ├── hooks/
│   │   ├── preSession.sh
│   │   └── postSession.sh
│   └── settings.json
└── .claude-plugin/
    └── marketplace.json
```