---
agent: agent-builder
description: "Install agents, prompts, instructions, or collections from GitHub repositories to workspace or VS Code profile (defaults to awesome-copilot)"
tools: ['web/fetch', 'web/githubRepo', 'edit', 'search', 'execute/getTerminalOutput', 'execute/runInTerminal', 'read/terminalLastCommand', 'read/terminalSelection', 'awesome-copilot/*']
---

# Install Copilot Assets

Install assets from GitHub repositories to enhance your VS Code Copilot experience.

## Repository Source

The source repository is determined by this priority order:
1. **User-specified repository** (if provided during this session)
2. **Environment variable** `COPILOT_ASSETS_REPO` (e.g., `owner/repo-name`)
3. **Default**: [GitHub awesome-copilot repository](https://github.com/github/awesome-copilot)

You can specify a different repository when prompted, or set the environment variable for persistent use.

## What to Install

First, let me know what type of asset you want to install:

**1. Collections** - Curated groups of related prompts, instructions, and agents for specific workflows
**2. Individual Agents** - Custom agents for specialized tasks (e.g., code review, architecture design)  
**3. Individual Prompts** - Ready-to-use prompt templates for development scenarios
**4. Individual Instructions** - Coding guidelines and best practices for specific technologies

## Installation Location

Where should these assets be installed?

**Workspace Installation (.github/ folder):**
- Assets apply only to this specific project
- Shared with team members via version control
- Project-specific customizations

**VS Code Profile Installation:**
- Assets available across all projects
- Personal customizations that follow you
- Not shared via version control

## Asset Placement Structure

Assets will be installed to the appropriate directories:

### Workspace Installation (.github/)
- **Agents**: `.github/agents/` - Custom agent definitions
- **Prompts**: `.github/prompts/` - Reusable prompt templates  
- **Instructions**: `.github/instructions/` - Coding guidelines and best practices
- **Context**: `.github/context/` - Project-specific documentation and methodologies

### Profile Installation

**Windows:**
- **Agents**: `%APPDATA%/Code/User/agents/`
- **Prompts**: `%APPDATA%/Code/User/prompts/` 
- **Instructions**: `%APPDATA%/Code/User/instructions/`

**WSL (Windows Subsystem for Linux):**
- **Agents**: `/mnt/c/Users/{username}/AppData/Roaming/Code/User/agents/`
- **Prompts**: `/mnt/c/Users/{username}/AppData/Roaming/Code/User/prompts/`
- **Instructions**: `/mnt/c/Users/{username}/AppData/Roaming/Code/User/instructions/`

**macOS:**
- **Agents**: `$HOME/Library/Application Support/Code/User/agents/`
- **Prompts**: `$HOME/Library/Application Support/Code/User/prompts/`
- **Instructions**: `$HOME/Library/Application Support/Code/User/instructions/`

**Linux:**
- **Agents**: `$HOME/.config/Code/User/agents/`
- **Prompts**: `$HOME/.config/Code/User/prompts/`
- **Instructions**: `$HOME/.config/Code/User/instructions/`

## Installation Process

I will:

1. **Determine Repository**: Check user input → environment variable → default (awesome-copilot)
2. **Search & Discover**: Help you find relevant assets from the target repository
3. **Create Directories**: Automatically create required folders if they don't exist
4. **Download Assets**: Use MCP server (if available) or curl to fetch files
5. **Preserve Content**: Install files exactly as-is without modifications
6. **Verify Installation**: Confirm assets are properly installed and accessible
7. **Provide Usage Guide**: Explain how to use the installed assets

## Getting Started

Tell me:
- **Repository**: Which GitHub repo should I use? (format: `owner/repo-name`, leave blank for default)
- **Asset type**: What do you want to install? (collection/agent/prompt/instruction)
- **Location**: Where should it be installed? (workspace or profile)
- **Focus**: Any specific technology or use case?

## Examples

**Use default repository:**
```
Asset type: collection
Location: workspace
Focus: python development
```

**Use custom repository:**
```
Repository: microsoft/copilot-extensions
Asset type: agent
Location: profile
```

**Use environment variable:**
```bash
export COPILOT_ASSETS_REPO="myorg/custom-copilot-assets"
# Then run the prompt without specifying repository
```

I'll help you discover and install the perfect assets to enhance your development workflow!