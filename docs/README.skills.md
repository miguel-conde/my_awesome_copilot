# 🛠️ Agent Skills

Reusable skill packages that extend GitHub Copilot agents with specialized capabilities, tools, and workflows.

### How to Use Agent Skills

**To Install:**
- Copy the skill folder to your local `.github/skills/` directory
- Preserve the complete folder structure including all files and subdirectories
- Agent Skills are discovered and loaded by Copilot when relevant (depending on your VS Code/Copilot feature support)

**To Configure:**
- Agent Skills are referenced in agent definitions via file paths or skill names
- Skills provide specialized tools, scripts, and workflows for specific tasks
- Skills can be shared across multiple agents and projects

**To Activate/Use:**
- Skills are automatically available to agents that reference them
- Follow skill-specific documentation for usage patterns
- Skills may require additional dependencies or configuration

## Available Skills

| Title | Description | Tools Required |
|-------|-------------|----------------|
| [Copilot Asset Installer](../skills/copilot-asset-installer/SKILL.md) | Complete VSCode Copilot asset management system with intelligent discovery, installation, and deployment capabilities for agents, prompts, instructions, collections, and skill packages. | `execute/runInTerminal`, `execute/getTerminalOutput`, `web/fetch`, `web/githubRepo`, `edit/createFile`, `edit/editFiles` |
| [Skill Creator](../skills/skill-creator/SKILL.md) | Complete workflow for creating Agent Skills following the open standard, including structure, progressive loading, and quality checklists. | — |

## Skill Development

### Creating a New Skill

1. Create a new directory in `.github/skills/` with your skill name
2. Create a `SKILL.md` file with metadata and documentation:

```markdown
---
name: your-skill-name
description: Brief description of what this skill does and when to use it
---

# Your Skill Name

[Documentation content]
```

3. Organize your skill with the following structure:

```
.github/skills/your-skill-name/
├── SKILL.md          # Main documentation and metadata
├── templates/        # Optional: Code templates
├── scripts/          # Executable scripts and tools
├── examples/         # Usage examples
├── docs/             # Optional: Additional documentation
└── data/             # Optional: Reference data
```

### Best Practices

- **Self-contained**: Skills should be complete packages that can be used independently
- **Well-documented**: Include clear usage instructions and examples
- **Tool requirements**: Specify exactly which VS Code Copilot tools are needed
- **Error handling**: Implement robust error handling in scripts
- **Compatibility**: Document system requirements and dependencies

## Contributing

To contribute a new skill:

1. Create your skill package in the `skills/` directory
2. Follow the skill development guidelines above
3. Test your skill thoroughly with different agents
4. Update this README.md with your skill's details
5. Submit a pull request

## Repository Structure

```
/
├── skills/         # Agent Skills packages
├── agents/         # Custom agent definitions
├── prompts/        # Reusable prompt files
├── instructions/   # Custom instructions files
├── collections/    # Agent collections
└── docs/          # Documentation
```

For more examples and community-contributed skills, see the [Awesome Copilot repository](https://github.com/github/awesome-copilot/tree/main).