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

## Agent Skills Coordination

- **Prompts vs Skills**: Use prompts for manual/interactive workflows, skills for automatic context-based activation
- **Skill discovery prompts**: Create prompts that help users find and understand available skills
- **Skill activation prompts**: Design prompts that trigger workflows where skills are likely to activate automatically
- **Reference skills**: Prompts can reference and guide users to relevant skills for specific capabilities
- **Workflow handoffs**: Consider how prompts might transition users to skill-based automation

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
