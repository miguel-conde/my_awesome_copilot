---
description: Guidelines for working with instructions files in this project
applyTo: '.github/instructions/**'
---

# Instructions File Guidelines

Before creating or modifying any files in the `.github/instructions/` directory, you **must**:

1. **Fetch and read** the official VSCode documentation: [Custom Instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
2. **Understand** the proper structure, syntax, and best practices for instructions files
3. **Follow** the patterns and conventions described in the documentation

## Key Principles

- Instructions files use YAML frontmatter with `description` and `applyTo` properties
- The `applyTo` property uses glob patterns to target specific files or directories
- Content should be concise, actionable guidelines that AI agents can follow
- Focus on project-specific conventions, not generic programming advice

## Agent Skills Coordination

- **Scope awareness**: Instructions apply to file patterns, while skills provide context-based capabilities
- **Complementary functions**: Instructions define coding standards/guidelines, skills provide specialized workflows
- **Reference skills**: Instructions can reference relevant skills for specific file types or contexts
- **Avoid overlap**: Don't duplicate skill capabilities in instructions - reference skills for complex workflows
- **Skills integration**: Consider how instructions might guide toward skill activation for specialized tasks

## Example Structure

```markdown
---
description: Brief description of what these instructions cover
applyTo: 'path/pattern/**'
---

# Title

Clear, specific instructions for AI agents working with the targeted files.
```

**Always verify your understanding against the official documentation before making changes.**
