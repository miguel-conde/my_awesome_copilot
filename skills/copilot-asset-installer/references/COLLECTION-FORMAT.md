# Collection Format Guide

This guide explains the YAML collection format used by the copilot-asset-installer skill.

## Collection File Structure

Collections are defined in `.collection.yml` files with this structure:

```yaml
id: collection-unique-id
name: Human Readable Collection Name  
description: Brief description of what this collection provides
tags: [tag1, tag2, tag3]  # Optional discovery tags
items:
  - path: prompts/example.prompt.md
    kind: prompt
  - path: instructions/example.instructions.md  
    kind: instruction
  - path: agents/example.agent.md
    kind: agent
    usage: |  # Optional usage instructions
      This agent requires specific setup...
display:
  ordering: alpha  # or "manual" 
  show_badge: false  # Optional collection badge
```

## Required Fields

### `id`
- Unique identifier using lowercase letters, numbers, and hyphens
- Must match the file name (without .collection.yml)
- Example: `python-development`, `frontend-tools`

### `name` 
- Human-readable display name
- Used in documentation and UI
- Example: "Python Development Tools"

### `description`
- Brief explanation of collection purpose (1-500 characters)
- Should describe target audience and use cases
- Example: "Essential tools for Python web development including FastAPI agents and testing prompts"

### `items`
- Array of assets included in the collection
- Each item has `path` and `kind` fields
- Supported kinds: `prompt`, `instruction`, `agent`

## Optional Fields

### `tags`
- Array of discovery keywords (max 10 tags)
- Helps users find relevant collections
- Use technology names, workflow types, etc.
- Example: `[python, web, api, testing]`

### `usage` (per item)
- Installation or configuration notes for specific items
- Include dependency requirements
- Provide setup instructions

### `display`
- `ordering`: Sort items alphabetically (`alpha`) or preserve manual order (`manual`)
- `show_badge`: Display collection badge on items (true/false)

## Validation Rules

- Collection IDs must be unique within a repository
- All referenced file paths must exist
- File kinds must match actual file extensions (.prompt.md, .agent.md, .instructions.md)
- Descriptions must be 1-500 characters
- Individual tags must be 1-30 characters

## Examples

### Minimal Collection
```yaml
id: basic-tools
name: Basic Development Tools
description: Essential prompts and agents for general development
items:
  - path: prompts/code-review.prompt.md
    kind: prompt
  - path: agents/debugger.agent.md
    kind: agent
```

### Full Collection
```yaml
id: react-development
name: React Development Suite
description: Complete toolkit for React development including testing, debugging, and deployment
tags: [react, javascript, frontend, testing, deployment]
items:
  - path: prompts/create-component.prompt.md
    kind: prompt
  - path: prompts/write-tests.prompt.md
    kind: prompt
  - path: instructions/react-best-practices.instructions.md
    kind: instruction
  - path: agents/react-debugger.agent.md
    kind: agent
    usage: |
      Requires React DevTools browser extension.
      Install with: npm install -g @react-devtools/core
display:
  ordering: manual
  show_badge: true
```