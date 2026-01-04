---
name: copilot-asset-installer
description: Complete VSCode Copilot asset management system with intelligent discovery, installation, and deployment capabilities for agents, prompts, instructions, collections, and skill packages.
license: MIT
compatibility: Requires git, bash, curl, jq, and internet access
metadata:
  author: miguel-conde
  version: "2.0.0"
  repository: https://github.com/miguel-conde/agentic_deployment_collection
allowed-tools: execute/runInTerminal execute/getTerminalOutput web/fetch web/githubRepo edit/createFile edit/editFiles
---

# Copilot Asset Installer Skill

This skill provides a comprehensive VSCode Copilot asset management system with intelligent discovery, installation, and deployment capabilities. It supports all types of copilot customizations including agents, prompts, instructions, collections, and skill packages with smart project analysis and recommendations.

## What This Skill Does

- **Asset Discovery**: Intelligent detection and analysis of copilot assets across repositories
- **Smart Recommendations**: Project-specific asset suggestions based on technology stack analysis
- **Universal Installation**: Support for agents, prompts, instructions, collections, and skill packages
- **Unified Interface**: Single command-line interface for all asset management operations
- **Project Analysis**: Automatic detection of programming languages, frameworks, and development patterns
- **Repository Flexibility**: Works with awesome-copilot, custom repositories, and private repos
- **Safe Deployment**: Comprehensive backup, validation, and conflict resolution
- **Batch Operations**: Install multiple assets or complete development environments

## When to Use This Skill

Use this skill when:
- Setting up copilot environments for new projects or teams
- Discovering relevant copilot assets for specific technology stacks
- Installing individual agents, prompts, or instructions
- Deploying complete collections or development environments
- Getting personalized recommendations based on project analysis
- Managing and organizing existing copilot assets
- Creating backups of copilot configurations
- Migrating copilot setups between projects or machines

## Repository Source Priority

The skill determines source repository in this order:
1. **User-specified repository** (highest priority)
2. **Environment variable** `COPILOT_ASSETS_REPO` 
3. **Default**: github/awesome-copilot repository

## Core Functions

### discover_assets(repository, path, technology_filter)
Advanced asset detection engine that analyzes repositories and provides compatibility scores.

**Parameters:**
- `repository`: Git repository URL or "owner/repo" format
- `path`: Optional subdirectory to scan (defaults to entire repo)
- `technology_filter`: Filter by technologies (python, react, etc.)

**Example:**
```
Discover python-related assets from awesome-copilot with compatibility scores
```

### install_asset(repository, asset_path, target_directory)
Universal installer for any type of copilot asset with automatic type detection.

**Parameters:**
- `repository`: Source repository
- `asset_path`: Path to any asset (.agent.md, .prompt.md, .instructions.md, .collection.yml, SKILL.md)
- `target_directory`: Optional custom installation directory

**Example:**
```
Install the code-review agent from myorg/custom-agents to workspace
```

### install_collection(repository, collection_path, target_location)
Installs complete collections with all dependencies and validation.

**Parameters:**
- `repository`: Source repository
- `collection_path`: Path to .collection.yml file
- `target_location`: "workspace" (.github/) or "profile" (user settings)

**Example:**
```
Install the "python-development" collection from awesome-copilot to workspace
```

### discover_recommendations(project_directory)
Intelligent project analysis with personalized asset recommendations.

**Parameters:**
- `project_directory`: Directory to analyze (defaults to current directory)

**Example:**
```
Analyze current project and suggest relevant copilot assets
```

### unified_management(command, options)
Single interface for all asset management operations.

**Commands:** detect, install, collections, discover, suggest, list, backup

**Example:**
```
Get personalized suggestions for this project based on smart analysis
```

## Installation Locations

### Workspace Installation (.github/)
- **Agents**: `.github/agents/` - Custom agent definitions
- **Prompts**: `.github/prompts/` - Reusable prompt templates
- **Instructions**: `.github/instructions/` - Coding guidelines and practices
- **Context**: `.github/context/` - Project-specific documentation

### Profile Installation 
- **Windows**: `%APPDATA%/Code/User/{agents,prompts,instructions}/`
- **macOS/Linux**: `~/.vscode/{agents,prompts,instructions}/`

## Quick Start Examples

### 1. Complete Python Development Setup
```bash
# Auto-detect and get recommendations
./scripts/deploy-unified.sh discover
./scripts/deploy-unified.sh suggest

# Install Python-specific assets
./scripts/deploy-unified.sh install github/awesome-copilot agents/python-expert.agent.md
./scripts/deploy-unified.sh install github/awesome-copilot prompts/python-testing.prompt.md
```

### 2. Install Frontend Development Collection
```bash
# Install complete frontend toolkit
./scripts/deploy-unified.sh collections github/awesome-copilot collections/frontend.collection.yml

# Verify installation
./scripts/deploy-unified.sh list
```

### 3. Smart Asset Discovery
```bash
# Analyze current project and get recommendations
./scripts/discover-assets.sh smart

# Interactive recommendation wizard
./scripts/discover-assets.sh interactive
```

### 4. Custom Repository Management
```bash
# Set custom default repository
export COPILOT_ASSETS_REPO="myorg/custom-copilot-tools"

# Discover assets from multiple sources
./scripts/deploy-unified.sh detect github/awesome-copilot
./scripts/deploy-unified.sh detect myorg/team-standards
```

## Phase 2 Enhancements

### New Capabilities
- **Enhanced Asset Detection**: Intelligent discovery with compatibility scoring
- **Individual Asset Installation**: Support for agents, prompts, instructions, and skills
- **Smart Recommendations**: Project-aware asset suggestions
- **Unified Management Interface**: Single CLI for all operations
- **Discovery Engine**: Automated project analysis and technology detection

### Advanced Scripts
- `detect-assets.sh` - Asset discovery with filtering and scoring
- `deploy-asset.sh` - Individual asset installer with validation
- `deploy-unified.sh` - Unified command-line interface
- `discover-assets.sh` - Smart project analysis and recommendations

### Intelligence Features
- **Project Fingerprinting**: Automatic technology stack detection
- **Compatibility Scoring**: Relevance-based asset ranking
- **Context Awareness**: Installation recommendations based on existing setup
- **Conflict Resolution**: Automatic backup and naming conflict handling

1. **Determine Repository Source**
   - Check user input for repository specification
   - Fall back to COPILOT_ASSETS_REPO environment variable
   - Default to github/awesome-copilot

2. **Asset Discovery**
   - Scan repository structure for copilot assets
   - Parse collection files if specified
   - Filter by technology or use case if provided

3. **Prepare Installation**
   - Create target directories if they don't exist
   - Create backup of existing files
   - Validate asset formats and dependencies

4. **Download and Install**
   - Fetch assets using git or web API
   - Place files in appropriate directories
   - Preserve original formatting and frontmatter

5. **Verification**
   - Confirm files are properly installed
   - Test basic functionality where possible
   - Provide usage instructions

## Using the Deployment Script

The skill includes a robust shell script for collection deployment:

```bash
scripts/deploy-collection.sh <repo_url> <branch> <collection_path> [target_dir]
```

See [scripts/deploy-collection.sh](scripts/deploy-collection.sh) for full documentation.

## Error Handling

- **Repository Access**: Clear messages for private/missing repositories
- **File Conflicts**: Backup existing files before overwriting
- **Invalid Assets**: Validate YAML frontmatter and file structure
- **Permission Issues**: Guide user through directory creation

## Usage Examples

Detailed usage scenarios with step-by-step workflows:

### Core Installation Workflows
- [Install Awesome-Copilot Collection](examples/install-awesome-collection.md) - Set up complete development environments
- [Install Custom Agent](examples/install-custom-agent.md) - Deploy specific agents from custom repositories  
- [Individual Asset Management](examples/individual-asset-management.md) - Install and manage specific agents, prompts, instructions, and skills

### Discovery and Analysis
- [Discover Assets for Current Project](examples/discover-assets.md) - Find relevant assets through project analysis
- [Smart Project Recommendations](examples/smart-recommendations.md) - Get personalized suggestions based on technology stack
- [Asset Detection and Analysis](examples/detect-and-analyze.md) - Advanced repository scanning and technology filtering

### Advanced Workflows
- [Interactive Workflows](examples/interactive-workflows.md) - Guided discovery sessions and smart project analysis
- [Backup and Migration](examples/backup-and-migration.md) - Backup current setups and migrate between projects

Each example includes the user input, skill response, detailed workflow steps, and expected outcomes.

## References

- [Collection Format Guide](references/COLLECTION-FORMAT.md) - YAML collection specification
- [Asset Types Reference](references/ASSET-TYPES.md) - Supported file formats
- [Installation Troubleshooting](references/TROUBLESHOOTING.md) - Common issues and solutions

## Related Files

- [deploy-collection.sh](scripts/deploy-collection.sh) - Main deployment script