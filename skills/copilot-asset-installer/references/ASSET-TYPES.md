# Asset Types Reference

This reference documents the supported VSCode Copilot asset types that can be installed using the copilot-asset-installer skill.

## Agent Files (.agent.md)

Custom agents that specialize Copilot for specific tasks or domains.

### Location
- **Workspace**: `.github/agents/`
- **Profile**: `%APPDATA%/Code/User/agents/` (Windows) or `~/.vscode/agents/` (macOS/Linux)

### Format
```yaml
---
name: agent-name
description: Brief description of agent purpose
tools: [list, of, required, tools]
model: optional-specific-model
---

Agent instructions and persona definition...
```

### Examples
- Code review specialists
- Architecture advisors  
- Technology-specific helpers (Python, React, etc.)
- Deployment and DevOps agents

## Prompt Files (.prompt.md)

Reusable prompt templates for specific development scenarios.

### Location
- **Workspace**: `.github/prompts/`
- **Profile**: `%APPDATA%/Code/User/prompts/` (Windows) or `~/.vscode/prompts/` (macOS/Linux)

### Format
```yaml
---
description: What this prompt accomplishes
agent: optional-agent-to-invoke
tools: [optional, tool, overrides]
---

Detailed prompt instructions with examples...
```

### Usage
- Invoked with `/prompt-name` in chat
- Can include variables and file references
- Support multi-turn workflows

### Examples
- Component generators
- Code refactoring templates
- Testing workflows
- Documentation generators

## Instruction Files (.instructions.md)

Coding guidelines and standards that apply to specific file types or contexts.

### Location
- **Workspace**: `.github/instructions/`  
- **Profile**: `%APPDATA%/Code/User/instructions/` (Windows) or `~/.vscode/instructions/` (macOS/Linux)

### Format
```yaml
---
description: What guidelines this provides
applyTo: "**/*.py"  # Glob pattern for target files
---

Detailed coding standards and best practices...
```

### Application
- Automatically applied based on `applyTo` patterns
- Influence code generation and suggestions
- Define project-specific standards

### Examples
- Language-specific coding standards (Python PEP 8, etc.)
- Framework conventions (React, Angular, etc.)
- Security guidelines
- Code review checklists

## Collection Files (.collection.yml)

Curated groups of related assets organized around specific themes or workflows.

### Location
- Usually in `collections/` directory of repositories
- Not directly installed - used to group other assets

### Format
See [COLLECTION-FORMAT.md](COLLECTION-FORMAT.md) for complete specification.

### Purpose
- Group related tools for specific workflows
- Enable bulk installation of complementary assets
- Provide curated experiences for different use cases

## Asset Discovery

The installer automatically detects asset types by:
1. **File extension**: .agent.md, .prompt.md, .instructions.md, .collection.yml
2. **Directory structure**: Standard locations in repositories
3. **YAML frontmatter**: Required metadata for each asset type
4. **Content validation**: Proper format and required fields

## Installation Behavior

### Conflict Resolution
- Existing files are backed up before overwriting
- User is prompted for confirmation on conflicts
- Backup location: `{target}/.copilot-backups/{timestamp}/`

### Validation
- YAML frontmatter syntax validation
- Required field verification
- Tool and agent reference validation
- File path and permission checks

### Dependencies
- Tools listed in frontmatter are noted but not auto-installed
- Agent references are validated against available agents
- Missing dependencies are reported to user

## Best Practices

### Naming Conventions
- Use kebab-case for file names: `my-agent.agent.md`
- Match agent names to file names when possible
- Use descriptive names that indicate purpose

### Documentation
- Include clear descriptions in frontmatter
- Provide usage examples in file body
- Document required tools and dependencies
- Specify compatibility requirements

### Organization
- Group related assets in collections
- Use consistent tagging for discoverability
- Maintain backward compatibility when updating