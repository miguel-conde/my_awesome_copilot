# 🤖 Custom Agents

Custom agents for GitHub Copilot, making it easy for users and organizations to "specialize" their Copilot coding agent (CCA) through simple file-based configuration.

### How to Use Custom Agents

**To Install:**
- Click the VS Code or VS Code Insiders install button for the agent you want to use
- Download the `*.agent.md` file and add it to your repository

**MCP Server Setup:**
- Each agent may require one or more MCP servers to function
- Click the MCP server to view it on the GitHub MCP registry
- Follow the guide on how to add the MCP server to your repository

**To Activate/Use:**
- Access installed agents through the VS Code Chat interface, assign them in CCA, or through Copilot CLI (coming soon)
- Agents will have access to tools from configured MCP servers
- Follow agent-specific instructions for optimal usage

## Available Agents

| Title | Description | MCP Servers |
|-------|-------------|-------------|
| Agent Builder <br/> [Install in VS Code](vscode://github.copilot.chat/installAgent?url=https://raw.githubusercontent.com/miguel-conde/my_awesome_copilot/main/agents/agent-builder.agent.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.chat/installAgent?url=https://raw.githubusercontent.com/miguel-conde/my_awesome_copilot/main/agents/agent-builder.agent.md) | Assistant for understanding VSCode Copilot customization and creating agent definitions, prompts, and instructions | |
| Awesome Getter <br/> [Install in VS Code](vscode://github.copilot.chat/installAgent?url=https://raw.githubusercontent.com/miguel-conde/my_awesome_copilot/main/agents/awesome-getter.agent.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.chat/installAgent?url=https://raw.githubusercontent.com/miguel-conde/my_awesome_copilot/main/agents/awesome-getter.agent.md) | Discovers and installs relevant Copilot customizations from the awesome-copilot repository based on project analysis | |
| Deployment Agent <br/> [Install in VS Code](vscode://github.copilot.chat/installAgent?url=https://raw.githubusercontent.com/miguel-conde/my_awesome_copilot/main/agents/deployment-agent.agent.md) [Install in VS Code Insiders](vscode-insiders://github.copilot.chat/installAgent?url=https://raw.githubusercontent.com/miguel-conde/my_awesome_copilot/main/agents/deployment-agent.agent.md) | Deploys VSCode Copilot customizations from remote repositories to local projects using shell scripts and integration with awesome-copilot registry | |

## Contributing

To contribute a new agent:

1. Create your `*.agent.md` file in the `agents/` directory
2. Test your agent thoroughly
3. Update this README.md with your agent's details
4. Submit a pull request

## Repository Structure

```
/
├── agents/          # Custom agent definitions
├── prompts/         # Reusable prompt files  
├── instructions/    # Custom instructions
├── collections/     # Agent collections
└── docs/           # Documentation
```

For more examples and community-contributed agents, see the [Awesome Copilot repository](https://github.com/github/awesome-copilot/tree/main).