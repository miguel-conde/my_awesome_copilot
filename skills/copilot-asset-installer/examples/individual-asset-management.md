# Individual Asset Management

This example covers installing and managing specific types of copilot assets.

## Scenario 1: Install Specific Agent
You want to install a single agent for a specific purpose.

### User Input
```
"Install the code review agent from awesome-copilot to my workspace"
```

### Skill Response
```bash
./scripts/deploy-unified.sh install github/awesome-copilot agents/code-review.agent.md
```

### What Happens
1. **Asset Validation**: Checks if agent file exists and has valid frontmatter
2. **Conflict Detection**: Looks for existing agents with same name
3. **Backup Creation**: Creates backup of any existing conflicting files
4. **Installation**: Downloads and places agent in `.github/agents/`
5. **Verification**: Validates agent can be loaded by VS Code
6. **Usage Instructions**: Shows how to use the new agent

### Expected Outcome
- Code review agent available in VS Code chat dropdown
- Specialized tools and instructions for code reviews
- Ready to use for pull request reviews

## Scenario 2: Install Prompt File
You want to add a reusable prompt for common tasks.

### User Input
```
"Install the API testing prompt from my company repository"
```

### Skill Response
```bash
./scripts/deploy-asset.sh mycompany/copilot-tools prompts/api-testing.prompt.md
```

### What Happens
1. **Repository Access**: Handles authentication for private repositories
2. **Asset Download**: Fetches specific prompt file
3. **Frontmatter Validation**: Ensures prompt has required metadata
4. **Installation**: Places in `.github/prompts/`
5. **Integration**: Makes available via `/` commands in chat

### Expected Outcome
- API testing prompt available in VS Code
- Accessible via `/api-testing` command
- Standardized API testing workflows

## Scenario 3: Install Instructions File
You want to add coding guidelines that apply automatically.

### User Input
```
"Install TypeScript coding standards to apply to all .ts files"
```

### Skill Response
```bash
./scripts/deploy-unified.sh install github/awesome-copilot instructions/typescript-standards.instructions.md
```

### What Happens
1. **Target Validation**: Checks instruction file has proper `applyTo` patterns
2. **Scope Analysis**: Understands which files the instructions will affect
3. **Conflict Resolution**: Handles overlapping instruction scopes
4. **Installation**: Places in `.github/instructions/`
5. **Activation**: Instructions automatically apply to matching files

### Expected Outcome
- TypeScript files automatically follow coding standards
- Consistent code generation across the project
- Team-wide coding conventions enforced

## Scenario 4: Install Agent Skill
You want to add a specialized skill package.

### User Input
```
"Install the database testing skill for comprehensive DB workflows"
```

### Skill Response
```bash
./scripts/deploy-asset.sh github/awesome-copilot skills/database-testing/SKILL.md .github/skills/
```

### What Happens
1. **Skill Directory Creation**: Creates skill folder structure
2. **Dependency Resolution**: Installs skill scripts and examples
3. **Resource Copying**: Includes all skill assets (scripts, templates, docs)
4. **Skill Registration**: Makes skill discoverable by copilot
5. **Testing**: Verifies skill loads and functions correctly

### Expected Outcome
- Database testing workflows available
- Specialized database agents and prompts
- Scripts for automated DB testing
- Examples and templates for DB test scenarios

## Scenario 5: Custom Installation Directory
You want to install assets to a custom location.

### User Input
```
"Install security scanning tools to a dedicated security folder"
```

### Skill Response
```bash
./scripts/deploy-asset.sh mycompany/security-tools agents/security-scanner.agent.md .github/security/
```

### What Happens
1. **Custom Directory Creation**: Creates specified directory structure
2. **Asset Adaptation**: Adjusts asset configuration for custom location
3. **VS Code Integration**: Ensures VS Code can discover assets in custom location
4. **Documentation**: Updates workspace documentation with custom structure

### Expected Outcome
- Security tools organized in dedicated folder
- Clear separation of security-focused assets
- Maintained integration with VS Code
- Team understands custom organization
