# 🎯 Reusable Prompts

Ready-to-use prompt templates for specific development scenarios and tasks, defining prompt text with a specific mode, model, and available set of tools.

### How to Use Reusable Prompts

**To Install:**
- Click the VS Code or VS Code Insiders install button for the prompt you want to use
- Download the `*.prompt.md` file and manually add it to your prompt collection

**To Run/Execute:**
- Use `/prompt-name` in VS Code chat after installation
- Run the `Chat: Run Prompt` command from the Command Palette
- Hit the run button while you have a prompt file open in VS Code

## Available Prompts

| Title | Description |
|-------|-------------|
| Deploy Collection <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/deploy-collection.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/deploy-collection.prompt.md) | Deploy VSCode Copilot customizations from a remote repository collection |
| Explain Feature <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/explain-feature.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/explain-feature.prompt.md) | Explain how a specific feature or functionality works in the codebase |
| Find Pattern <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/find-pattern.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/find-pattern.prompt.md) | Find patterns, anti-patterns, or specific code structures in the codebase |
| Install Copilot Assets <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/install-copilot-assets.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/install-copilot-assets.prompt.md) | Install Copilot customizations from remote repositories |
| New Agent <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/new-agent.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/new-agent.prompt.md) | Create a new custom agent definition with proper structure and documentation |
| New Instructions <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/new-instructions.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/new-instructions.prompt.md) | Create a new instructions file with proper YAML frontmatter and content |
| New Prompt <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/new-prompt.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/new-prompt.prompt.md) | Create a new prompt file with proper structure and configuration |
| Validate Definition <br/> [Install in VS Code](vscode://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/validate-definition.prompt.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.prompts/install?url=https://raw.githubusercontent.com/miguel/my_awesome_copilot/main/prompts/validate-definition.prompt.md) | Validate an agent definition or prompt file against official VSCode documentation |

## Contributing

To contribute a new prompt:

1. Create your `*.prompt.md` file in the `prompts/` directory
2. Follow the YAML frontmatter format with `description` and optional `agent` fields
3. Test your prompt thoroughly
4. Update this README.md with your prompt's details
5. Submit a pull request

## Repository Structure

```
/
├── prompts/        # Reusable prompt files
├── agemts/         # Custom agent definitions
├── instructions/   # Custom instructions files
├── collections/    # Agent collections
└── docs/          # Documentation
```

For more examples and community-contributed prompts, see the [Awesome Copilot repository](https://github.com/github/awesome-copilot/tree/main).