# 📋 Custom Instructions

Team and project-specific instructions to enhance GitHub Copilot's behavior for specific technologies and coding practices.

### How to Use Custom Instructions

**To Install:**
- Click the VS Code or VS Code Insiders install button for the instruction you want to use
- Download the `*.instructions.md` file and manually add it to your project's instruction collection

**To Use/Apply:**
- Copy these instructions to your `.github/copilot-instructions.md` file in your workspace
- Create task-specific `.github/.instructions.md` files in your workspace's `.github/instructions` folder
- Instructions automatically apply to Copilot behavior once installed in your workspace

## Available Instructions

| Title | Description |
|-------|-------------|
| Agents Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/agents.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/agents.instructions.md) | Guidelines for working with custom agent files in VSCode Copilot |
| Deployment Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/deployment.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/deployment.instructions.md) | Guidelines for deploying and managing Copilot customizations |
| Instructions Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/instructions.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/instructions.instructions.md) | Guidelines for working with instructions files in this project |
| Memory Integration Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/memory-integration.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/memory-integration.instructions.md) | Guidelines for integrating memory and context management |
| Prompts Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/prompts.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/prompts.instructions.md) | Guidelines for working with prompt files in this project |
| Python Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/python.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/python.instructions.md) | Python coding standards and best practices for this workspace |
| Skills Instructions <br/> [Install in VS Code](vscode://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/skills.instructions.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.instructions/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/instructions/skills.instructions.md) | Guidelines for working with Agent Skills in VSCode Copilot |

## Contributing

To contribute a new instruction:

1. Create your `*.instructions.md` file in the `instructions/` directory
2. Follow the YAML frontmatter format with `description` and `applyTo` fields
3. Test your instruction thoroughly
4. Update this README.md with your instruction's details
5. Submit a pull request

## Repository Structure

```
/
├── instructions/    # Custom instructions files
├── agemts/         # Custom agent definitions
├── prompts/        # Reusable prompt files  
├── collections/    # Agent collections
└── docs/          # Documentation
```

For more examples and community-contributed instructions, see the [Awesome Copilot repository](https://github.com/github/awesome-copilot/tree/main).