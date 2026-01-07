---
description: Guidelines for working with custom agent files in VSCode Copilot
applyTo: '.github/agents/**'
---

# Custom Agent File Guidelines

Before creating or modifying any files in the `.github/agents/` directory, you **must**:

1. **Fetch and read** the official VSCode documentation: [Custom Agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
2. **Understand** the proper structure, syntax, and best practices for custom agent definitions
3. **Follow** the patterns and conventions described in the documentation

## Key Principles

- Agent files use `.agent.md` extension and YAML frontmatter with agent metadata
- Frontmatter includes properties like `description`, `tools`, `handoffs`, and optional `model`
- Content defines the agent's persona, instructions, and workflow
- Agents should have clear, focused responsibilities aligned with their intended use case
- Consider agent collaboration patterns and handoffs when designing multi-agent workflows
- Follow any existing agent conventions established in the workspace
- **Consider project-specific context discovery (optional)**: Agents may check `.github/context/{agent-name}/` for project methodologies and standards when relevant

## Agent Skills Coordination

- **Choose agents for conversational assistance** that requires reasoning, context management, or interactive workflows
- **Consider Agent Skills instead** for automatic capabilities that load based on context, especially when bundling resources (templates, scripts, examples)
- **Reference skills in agents**: Agents can mention when to use specific skills or direct users to skill-based workflows
- **Avoid duplication**: Don't create both an agent and skill for the same capability - choose the appropriate type based on interaction model
- **Skills integration**: Agents can reference skill documentation and guide users to skill-based automation when appropriate

## Example Structure

```markdown
---
description: Brief description of the agent's role
tools: ['tool1', 'tool2']
handoffs:
  - label: Handoff Label
    agent: target-agent
    prompt: Handoff instructions
---

# Agent Name

Agent persona and instructions for behavior.

## Workflow

Step-by-step workflow the agent should follow.
```

## Project-Specific Context

Agents may optionally be designed to discover and use project-specific guidance:

- **Agent Context Discovery (optional)**: Include instructions to check `.github/context/{agent-name}/` for role-specific methodologies
- **Shared Context (optional)**: Reference `.github/context/shared/` for general project context and business domain knowledge
- **Methodology Integration**: Agents should adapt their generic workflows to project-specific approaches when available
- **Documentation Pattern**: Use `#tool:readFile` to access methodology documents before applying standard procedures

### Example Agent Context Structure (Optional)
```markdown
## Project Context Discovery

If project-specific guidance is needed, check for:
- Read `.github/context/{agent-name}/` for role-specific methodologies (if exists)
- Review `.github/context/shared/` for general project context (if available)
- Use #tool:readFile to access relevant methodology documents when present
```

**Always verify your understanding against the official documentation before making changes.**
