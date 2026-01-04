---
description: Deploy VSCode Copilot customizations from a remote repository collection
agent: deployment-agent
---

# Deploy Copilot Collection

Deploy VSCode Copilot customizations (agents, prompts, instructions) from a remote repository using a collection configuration file.

## Required Information

1. **Repository URL**: The git repository containing the Copilot customizations
2. **Branch** (optional): The branch to deploy from (defaults to main/master)
3. **Collection Path**: Path to the collections.yml file in the repository
4. **Target Directory**: Local project directory for deployment

## Deployment Process

1. **Clone Repository**: Fetch the remote repository to a temporary location
2. **Parse Collection**: Read and validate the collections.yml configuration
3. **Prepare Deployment**: Create backup of existing files and prepare target directories
4. **Execute Deployment**: Copy files according to collection configuration
5. **Validate Results**: Verify all files are correctly placed with proper frontmatter

## Example Usage

```
Deploy the main collection from https://github.com/awesome/copilot-configs
- Branch: main
- Collection: collections/main.yml
- Target: current workspace
```

## Safety Options

- **--dry-run**: Show what would be deployed without making changes
- **--backup**: Create timestamped backups of existing files
- **--validate**: Only validate collection file without deploying

Ready to deploy? Provide your repository details!