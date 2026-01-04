---
description: Guidelines for working with prompt files in this project
applyTo: '.github/prompts/**'
---

# Prompt File Guidelines

Before creating or modifying any files in the `.github/prompts/` directory, you **must**:

1. **Fetch and read** the official VSCode documentation: [Prompt Files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
2. **Understand** the proper structure, syntax, and best practices for prompt files
3. **Follow** the patterns and conventions described in the documentation

## Key Principles

- Prompt files use `.prompt.md` extension and YAML frontmatter
- Frontmatter includes `description` and optionally `agent` to invoke a specific agent
- Prompts define reusable workflows that can be invoked with `/prompt-name` in chat
- Content should provide clear, actionable instructions for a specific task or workflow
- Use prompts to create variants of agent workflows or common task patterns

## Example Structure

```markdown
---
agent: agent-name
description: Brief description of what this prompt does
---

Clear instructions for the workflow or task this prompt executes.
Can include multi-turn processes, clarifying questions, or specific steps.
```

**Always verify your understanding against the official documentation before making changes.**
