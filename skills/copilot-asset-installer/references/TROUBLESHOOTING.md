# Installation Troubleshooting Guide

Common issues and solutions when using the copilot-asset-installer skill.

## Repository Access Issues

### Problem: "Repository not found" or "Access denied"
**Symptoms:**
- Cannot clone or access the specified repository
- Authentication errors

**Solutions:**
1. **Verify repository URL format**
   - Use `owner/repo` format for GitHub: `microsoft/copilot-extensions`
   - Use full URL for other Git hosts: `https://gitlab.com/user/repo.git`

2. **Check repository visibility**
   - Ensure repository is public or you have access
   - For private repos, ensure Git credentials are configured

3. **Test repository access manually**
   ```bash
   git ls-remote https://github.com/owner/repo.git
   ```

### Problem: "Branch not found"
**Solutions:**
- Verify branch name (default is usually `main` or `master`)
- Check available branches: `git ls-remote --heads repo-url`

## File and Directory Issues

### Problem: "Permission denied" when creating directories
**Symptoms:**
- Cannot create `.github/` directories
- Write permission errors

**Solutions:**
1. **Check directory permissions**
   ```bash
   ls -la .github/
   ```

2. **Ensure workspace is writable**
   - Run from writable directory
   - Check disk space availability

3. **For profile installation, check user directory permissions**
   ```bash
   # Windows
   dir "%APPDATA%\Code\User\"
   
   # macOS/Linux  
   ls -la ~/.vscode/
   ```

### Problem: "Target directory already exists"
**Solutions:**
- Use backup and overwrite option when prompted
- Manually move existing files to backup location
- Check for file locks or processes using the files

## Asset Format Issues

### Problem: "Invalid YAML frontmatter"
**Symptoms:**
- Parsing errors when reading asset files
- Malformed metadata

**Solutions:**
1. **Validate YAML syntax**
   - Check for proper indentation
   - Ensure all strings are properly quoted
   - Verify required fields are present

2. **Required fields by asset type:**
   - **Agents**: `name`, `description` 
   - **Prompts**: `description`
   - **Instructions**: `description`, `applyTo`
   - **Collections**: `id`, `name`, `description`, `items`

3. **Example validation:**
   ```yaml
   ---
   name: valid-agent-name  # Required
   description: "Clear description"  # Required  
   tools: [tool1, tool2]  # Optional
   ---
   ```

### Problem: "Asset not found in repository"
**Solutions:**
- Verify file paths are correct and case-sensitive
- Check if file has been moved or renamed
- Use repository web interface to confirm file existence

## Collection Issues

### Problem: "Collection validation failed"
**Symptoms:**
- Collection YAML doesn't match expected format
- Referenced items don't exist

**Solutions:**
1. **Validate collection structure** (see [COLLECTION-FORMAT.md](COLLECTION-FORMAT.md))
2. **Check item paths**
   - Verify all `path` fields point to existing files
   - Ensure `kind` matches file extension
3. **Test collection manually:**
   ```bash
   # Download collection file
   curl -o test.yml https://raw.githubusercontent.com/owner/repo/main/collections/name.collection.yml
   
   # Validate YAML syntax
   python -c "import yaml; yaml.safe_load(open('test.yml'))"
   ```

## Network and Download Issues

### Problem: "Download timeout" or "Connection refused"
**Solutions:**
1. **Check internet connectivity**
2. **Verify Git configuration**
   ```bash
   git config --list | grep -E "(http|https)"
   ```
3. **Use alternative download method**
   - Switch from Git to direct HTTP download
   - Use SSH instead of HTTPS for Git

### Problem: "Rate limiting" from GitHub API
**Solutions:**
1. **Add GitHub token for higher limits**
   ```bash
   export GITHUB_TOKEN=your_token_here
   ```
2. **Retry after waiting period**
3. **Use Git clone instead of API for large repositories**

## Installation Verification Issues

### Problem: "Assets installed but not visible in VS Code"
**Solutions:**
1. **Restart VS Code** to refresh asset discovery
2. **Check installation location:**
   - Workspace: `.github/agents/`, `.github/prompts/`, `.github/instructions/`
   - Profile: User settings directory
3. **Verify file permissions** are readable
4. **Check VS Code settings** for custom asset locations

### Problem: "Tools or dependencies not working"
**Solutions:**
1. **Install required tools** mentioned in asset frontmatter
2. **Configure tool permissions** in VS Code settings
3. **Check agent and tool compatibility**

## Debugging Steps

### Enable Verbose Logging
```bash
# Set debug environment variable
export COPILOT_INSTALLER_DEBUG=1

# Run installation with full output
./scripts/deploy-collection.sh repo branch collection target_dir 2>&1 | tee install.log
```

### Validate Installation
```bash
# Check file structure
find .github/ -name "*.md" -type f

# Validate YAML files
for file in .github/agents/*.agent.md; do
  echo "Checking $file"
  head -20 "$file" | grep -A 20 "^---"
done
```

### Test Basic Functionality
1. **Open VS Code in workspace**
2. **Open Copilot chat**
3. **Try agent commands:** `@agent-name help`
4. **Try prompt commands:** `/prompt-name`
5. **Check instruction application** on relevant file types

## Getting Help

### Log Collection
When reporting issues, include:
- Operating system and VS Code version
- Repository and collection being installed
- Full error messages and stack traces
- Installation log output (with debug enabled)

### Common Log Locations
- **Installation logs**: Current directory (install.log)
- **VS Code logs**: Help → Toggle Developer Tools → Console
- **System logs**: 
  - Windows: Event Viewer
  - macOS: Console.app
  - Linux: /var/log/ or journalctl

### Community Support
- Check [GitHub Issues](https://github.com/miguel-conde/agentic_deployment_collection/issues)
- Search [VS Code Copilot documentation](https://code.visualstudio.com/docs/copilot/)
- Visit [awesome-copilot repository](https://github.com/github/awesome-copilot) for examples