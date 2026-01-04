# Unified CLI Interface Guide

The `deploy-unified.sh` script provides a single command-line interface for all Copilot asset management operations. This guide covers all available commands and their usage patterns.

## Command Overview

```bash
./deploy-unified.sh <command> [options...]
```

### Available Commands
- `detect` - Asset discovery and analysis
- `install` - Individual asset installation
- `collections` - Collection deployment
- `discover` - Smart project analysis and recommendations
- `suggest` - Personalized asset suggestions
- `list` - Show installed assets
- `backup` - Create configuration backups

## Command Reference

### 1. Asset Detection (`detect`)

Discover and analyze assets in any repository with intelligent filtering and scoring.

#### Syntax
```bash
./deploy-unified.sh detect <repository> [path] [technology_filter]
```

#### Parameters
- `repository`: Git repository URL or owner/repo format
- `path`: Optional subdirectory to scan (defaults to entire repo)
- `technology_filter`: Filter by specific technologies

#### Examples
```bash
# Scan entire awesome-copilot repository
./deploy-unified.sh detect github/awesome-copilot

# Scan only agents directory
./deploy-unified.sh detect github/awesome-copilot agents

# Filter by Python-related assets
./deploy-unified.sh detect github/awesome-copilot . python

# Scan custom repository
./deploy-unified.sh detect myorg/custom-copilot-tools
```

#### Output Format
- **Default**: Human-readable table format
- **JSON**: Set `OUTPUT_FORMAT=json` for machine-readable output

### 2. Individual Installation (`install`)

Install any type of individual asset with automatic type detection and placement.

#### Syntax
```bash
./deploy-unified.sh install <repository> <asset_path> [target_directory]
```

#### Parameters
- `repository`: Source repository
- `asset_path`: Path to asset file in repository
- `target_directory`: Optional custom installation directory

#### Examples
```bash
# Install agent to default location
./deploy-unified.sh install github/awesome-copilot agents/code-reviewer.agent.md

# Install prompt to custom directory
./deploy-unified.sh install github/awesome-copilot prompts/testing.prompt.md ./custom-prompts

# Install from private repository
./deploy-unified.sh install myorg/private-tools agents/security-scanner.agent.md
```

#### Asset Type Detection
- `*.agent.md` → `.github/agents/`
- `*.prompt.md` → `.github/prompts/`
- `*.instructions.md` → `.github/instructions/`
- `*.collection.yml` → `collections/`
- `*/SKILL.md` → `.github/skills/{skill-name}/`

### 3. Collection Deployment (`collections`)

Install complete collections with all their dependencies and components.

#### Syntax
```bash
./deploy-unified.sh collections <repository> <collection_path>
```

#### Parameters
- `repository`: Repository containing the collection
- `collection_path`: Path to .collection.yml file

#### Examples
```bash
# Install frontend development collection
./deploy-unified.sh collections github/awesome-copilot collections/frontend.collection.yml

# Install backend tools collection
./deploy-unified.sh collections github/awesome-copilot collections/backend-development.collection.yml

# Install from custom repository
./deploy-unified.sh collections myteam/copilot-configs collections/team-standards.collection.yml
```

#### Collection Processing
1. Parse collection YAML manifest
2. Resolve all dependencies
3. Download and validate each asset
4. Install in dependency order
5. Verify successful installation

### 4. Smart Discovery (`discover`)

Intelligent asset discovery based on project analysis and technology detection.

#### Syntax
```bash
./deploy-unified.sh discover [technologies...]
```

#### Parameters
- `technologies`: Optional technology filters (if not specified, auto-detected)

#### Examples
```bash
# Auto-detect project technologies
./deploy-unified.sh discover

# Specify technologies manually
./deploy-unified.sh discover python fastapi

# Multiple technology stack
./deploy-unified.sh discover javascript react nodejs

# Generic development setup
./deploy-unified.sh discover general
```

#### Auto-Detection Features
- **Languages**: JavaScript, Python, Rust, Go, Java, C++, Ruby, PHP
- **Frameworks**: React, Vue, Angular, Next.js, Django, Flask, FastAPI, Express
- **Patterns**: Testing, Docker, CI/CD, Documentation
- **Project Types**: Web app, API, CLI, Library

### 5. Personalized Suggestions (`suggest`)

Generate tailored recommendations based on current project setup and missing capabilities.

#### Syntax
```bash
./deploy-unified.sh suggest [minimum_score]
```

#### Parameters
- `minimum_score`: Minimum compatibility score (default: 10)

#### Examples
```bash
# Get default suggestions
./deploy-unified.sh suggest

# Get only high-relevance suggestions
./deploy-unified.sh suggest 15

# Get all possible suggestions
./deploy-unified.sh suggest 5
```

#### Suggestion Algorithm
1. **Current Setup Analysis**: Scan existing agents, prompts, instructions
2. **Gap Identification**: Identify missing capabilities
3. **Project Context**: Consider technology stack and patterns
4. **Compatibility Scoring**: Score assets based on relevance
5. **Personalization**: Weight suggestions based on current setup

### 6. Asset Listing (`list`)

Display all currently installed Copilot assets with metadata.

#### Syntax
```bash
./deploy-unified.sh list
```

#### Output Sections
- **Agents**: Custom agent definitions with names and descriptions
- **Prompts**: Prompt templates with descriptions
- **Instructions**: Coding standards with application patterns
- **Collections**: Installed collections with descriptions
- **Skills**: Agent Skills packages with capabilities

#### Example Output
```
Installed VSCode Copilot Assets:

Agents (.github/agents/):
  code-reviewer.agent.md - Code Review Specialist
  python-expert.agent.md - Python Development Expert

Prompts (.github/prompts/):
  testing.prompt.md - Generate comprehensive tests
  refactor.prompt.md - Refactor code for better structure

Instructions (.github/instructions/):
  python-standards.instructions.md - applies to: **/*.py
  team-conventions.instructions.md - applies to: **

Collections (collections/):
  frontend.collection.yml - Frontend development toolkit

Skills (.github/skills/):
  database-helper - Database Helper: SQL query assistance and optimization
```

### 7. Configuration Backup (`backup`)

Create comprehensive backups of all Copilot configurations.

#### Syntax
```bash
./deploy-unified.sh backup
```

#### Backup Process
1. **Timestamp Creation**: Generate unique backup directory
2. **Asset Copying**: Copy all asset directories
3. **Manifest Generation**: Create backup manifest with metadata
4. **Verification**: Verify backup integrity

#### Backup Location
`$HOME/.copilot-backups/manual-YYYYMMDD_HHMMSS/`

#### Backup Contents
- All agents, prompts, instructions, collections, and skills
- Backup manifest with timestamps and git information
- Directory structure preservation

## Environment Configuration

### Environment Variables

#### COPILOT_ASSETS_REPO
Set default repository for operations.
```bash
export COPILOT_ASSETS_REPO="myorg/custom-copilot-tools"
./deploy-unified.sh discover
```

#### OUTPUT_FORMAT
Control output format for machine processing.
```bash
export OUTPUT_FORMAT="json"
./deploy-unified.sh detect github/awesome-copilot | jq '.[] | select(.score > 15)'
```

## Advanced Usage Patterns

### Workflow Automation
```bash
# Complete Python development setup
./deploy-unified.sh discover python > recommendations.txt
./deploy-unified.sh install github/awesome-copilot agents/python-expert.agent.md
./deploy-unified.sh install github/awesome-copilot prompts/python-testing.prompt.md
./deploy-unified.sh collections github/awesome-copilot collections/python-dev.collection.yml
```

### Team Setup Standardization
```bash
# Create team backup
./deploy-unified.sh backup

# Install team standards
./deploy-unified.sh collections myorg/team-configs collections/coding-standards.collection.yml

# Verify installation
./deploy-unified.sh list
```

### Multi-Repository Management
```bash
# Install core tools from awesome-copilot
./deploy-unified.sh collections github/awesome-copilot collections/essential-tools.collection.yml

# Add organization-specific tools
export COPILOT_ASSETS_REPO="myorg/copilot-tools"
./deploy-unified.sh discover
./deploy-unified.sh install myorg/copilot-tools agents/company-standards.agent.md
```

### JSON Processing
```bash
# Find high-scoring Python assets
OUTPUT_FORMAT=json ./deploy-unified.sh detect github/awesome-copilot . python | \
  jq '.[] | select(.score > 12) | .path'

# Get asset metadata
OUTPUT_FORMAT=json ./deploy-unified.sh detect github/awesome-copilot | \
  jq '.[] | {name: .name, type: .type, score: .score, description: .description}'
```

## Error Handling

### Common Issues and Solutions

#### Repository Access Errors
```bash
# Error: Failed to clone repository
# Solution: Check repository URL and access permissions
./deploy-unified.sh detect https://github.com/owner/repo
```

#### Asset Not Found
```bash
# Error: Asset not found in repository
# Solution: Verify asset path exists
./deploy-unified.sh detect github/awesome-copilot | grep "desired-asset"
```

#### Installation Conflicts
```bash
# Automatic backup and conflict resolution
# Check backup location for original files
ls -la ~/.copilot-backups/
```

### Debug Mode
Enable verbose logging by setting debug environment:
```bash
export DEBUG=1
./deploy-unified.sh detect github/awesome-copilot
```

## Integration with Other Tools

### Git Hooks
```bash
# Pre-commit hook to validate assets
echo "./deploy-unified.sh list > .copilot-assets.txt" >> .git/hooks/pre-commit
```

### CI/CD Pipelines
```yaml
# GitHub Actions example
- name: Install Copilot Assets
  run: |
    ./deploy-unified.sh collections github/awesome-copilot collections/ci-tools.collection.yml
    ./deploy-unified.sh list
```

### Docker Integration
```dockerfile
# Dockerfile example
COPY deploy-unified.sh /usr/local/bin/
RUN deploy-unified.sh collections github/awesome-copilot collections/docker-dev.collection.yml
```