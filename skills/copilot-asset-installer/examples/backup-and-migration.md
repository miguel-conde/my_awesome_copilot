# Backup and Migration

This example demonstrates creating backups and migrating copilot setups between projects.

## Scenario 1: Create Backup Before Changes
You want to backup your current copilot setup before installing new assets.

### User Input
```
"Create a backup of my current copilot configuration"
```

### Skill Response
```bash
./scripts/deploy-unified.sh backup
```

### What Happens
1. Creates timestamped backup in `~/.copilot-backups/YYYYMMDD_HHMMSS/`
2. Backs up all agents, prompts, instructions, and collections
3. Generates manifest file with metadata
4. Provides restore instructions

### Expected Outcome
- Complete backup of current setup
- Ability to restore if needed
- Peace of mind before making changes

## Scenario 2: List Installed Assets
You want to see what's currently installed in your workspace.

### User Input
```
"Show me all installed copilot assets"
```

### Skill Response
```bash
./scripts/deploy-unified.sh list
```

### What Happens
1. Scans `.github/agents/`, `.github/prompts/`, `.github/instructions/`
2. Parses frontmatter to extract metadata
3. Shows installation source and date
4. Highlights conflicts or issues

### Expected Outcome
- Inventory of all installed assets
- Source repository information
- Installation status and health check
