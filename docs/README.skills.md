# 🛠️ Agent Skills

Reusable skill packages that extend GitHub Copilot agents with specialized capabilities, tools, and workflows.

### How to Use Agent Skills

**To Install:**
- Click the VS Code or VS Code Insiders install button for the skill you want to use
- Download the skill package and add it to your repository
- Configure your agents to use the skill via the `tools` or `skills` property

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
| [Copilot Asset Installer](../skills/copilot-asset-installer/SKILL.md)<br/>[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://aka.ms/awesome-copilot/install/agent?url=vscode%3Achat-skill%2Finstall%3Furl%3Dhttps%3A%2F%2Fraw.githubusercontent.com%2Fmiguel-conde%2Fmy_awesome_copilot%2Fmain%2Fskills%2Fcopilot-asset-installer%2FSKILL.md)<br/>[![Install in VS Code Insiders](https://img.shields.io/badge/VS_Code_Insiders-Install-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](https://aka.ms/awesome-copilot/install/agent?url=vscode-insiders%3Achat-skill%2Finstall%3Furl%3Dhttps%3A%2F%2Fraw.githubusercontent.com%2Fmiguel-conde%2Fmy_awesome_copilot%2Fmain%2Fskills%2Fcopilot-asset-installer%2FSKILL.md) | Complete VSCode Copilot asset management system with intelligent discovery, installation, and deployment capabilities for agents, prompts, instructions, collections, and skill packages. | `execute/runInTerminal`, `execute/getTerminalOutput`, `web/fetch`, `web/githubRepo`, `edit/createFile`, `edit/editFiles` |

## Skill Development

### Creating a New Skill

1. Create a new directory in `skills/` with your skill name
2. Create a `SKILL.md` file with metadata and documentation:

```markdown
---
name: your-skill-name
description: Brief description of what this skill does
license: MIT
compatibility: Requirements and dependencies
metadata:
  author: your-name
  version: "1.0.0"
  repository: https://github.com/your-repo
allowed-tools: tool1 tool2 tool3
---

# Your Skill Name

[Documentation content]
```

3. Organize your skill with the following structure:

```
skills/your-skill-name/
├── SKILL.md          # Main documentation and metadata
├── scripts/          # Executable scripts and tools
├── examples/         # Usage examples
├── references/       # Reference documentation
└── tests/           # Test files (if applicable)
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
├── agemts/         # Custom agent definitions
├── prompts/        # Reusable prompt files
├── instructions/   # Custom instructions files
├── collections/    # Agent collections
└── docs/          # Documentation
```

For more examples and community-contributed skills, see the [Awesome Copilot repository](https://github.com/github/awesome-copilot/tree/main).