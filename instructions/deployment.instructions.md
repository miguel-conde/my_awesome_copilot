---
description: Guidelines for deployment operations and shell script execution
applyTo: "**/*.sh"
---

# Deployment Operations Guidelines

## Shell Script Safety

- Always validate input parameters before execution
- Create backups before overwriting existing files  
- Use absolute paths to avoid directory confusion
- Include error handling and exit codes
- Log all operations for debugging

## Git Repository Access

- Support multiple git providers (GitHub, GitLab, BitBucket)
- Handle both public and private repositories
- Use shallow clones for efficiency: `git clone --depth 1`
- Clean up temporary directories after deployment

## File Operations

- Preserve file permissions when copying
- Validate file formats before deployment
- Check for required YAML frontmatter in .md files
- Create target directories if they don't exist

## YAML Collection Format

```yaml
name: "Collection Name"
description: "Description of the collection"
version: "semantic version"
repository: "source repository URL"
items:
  - type: "agent|prompt|instruction"
    name: "item name"
    source: "relative/path/in/repo"
    target: "relative/path/in/workspace"
    description: "item description"
```

## Standard Deployment Locations

- Agents: `.github/agents/`
- Prompts: `.github/prompts/` 
- Instructions: `.github/instructions/`
- Context: `.github/context/`

## Error Handling

- Validate repository access before cloning
- Check collection.yml format before processing
- Verify target directory write permissions
- Provide clear error messages for failures