# Script Guidelines for Agent Skills

Best practices for creating and bundling executable scripts with Agent Skills following the open standard.

## Security and Safety Principles

### 1. **Script Security**
- **Always review scripts** before including them in skills
- **Use descriptive filenames** that clearly indicate the script's purpose
- **Include comments** explaining what each section does
- **Avoid hardcoded credentials** or sensitive information
- **Use environment variables** for configuration values

### 2. **VSCode Integration**
- VSCode's terminal tool provides **auto-approve options** with configurable allow-lists
- Consider which scripts are safe for **automatic approval**
- Provide clear **usage instructions** in the skill documentation
- Use **relative paths** for script references in SKILL.md

## Script Organization

### Directory Structure
```
.github/skills/{skill-name}/
├── SKILL.md
├── scripts/
│   ├── setup.sh           # Installation and setup scripts
│   ├── validate.sh        # Validation and testing scripts
│   ├── cleanup.sh         # Cleanup and maintenance scripts
│   └── utils/             # Utility scripts (optional subdirectory)
```

### Naming Conventions
- Use **lowercase with hyphens**: `setup-environment.sh`, `run-tests.py`
- Include **file extensions** to indicate script type: `.sh`, `.py`, `.js`, `.ps1`
- Use **descriptive names** that explain the script's purpose
- Group related scripts in subdirectories when appropriate

## Script Types and Use Cases

### 1. **Setup Scripts**
For environment configuration and dependency installation:
- Project initialization
- Tool installation and configuration
- Environment variable setup
- Database initialization

**Example**: `setup-python-env.sh` for setting up Python virtual environments

### 2. **Validation Scripts**
For testing and quality assurance:
- Code validation and linting
- Test execution
- Configuration verification
- Dependency checking

**Example**: `validate-config.py` for configuration file validation

### 3. **Automation Scripts**
For repetitive development tasks:
- Build and deployment automation
- File generation and templating
- Data processing and transformation
- Reporting and analysis

**Example**: `generate-docs.js` for automatic documentation generation

### 4. **Utility Scripts**
For common helper functions:
- File manipulation utilities
- String processing helpers
- API interaction scripts
- Logging and monitoring tools

**Example**: `format-logs.sh` for log file formatting

## Progressive Loading Considerations

### Level 3 Resource Access
Scripts are only loaded when Copilot references them, following the progressive loading principle:

1. **Keep scripts focused** - One script, one purpose
2. **Use clear descriptions** in SKILL.md when referencing scripts
3. **Provide usage examples** for each script
4. **Include error handling** and helpful output messages

### Reference Format in SKILL.md
```markdown
Use the [setup script](./scripts/setup-environment.sh) to configure your development environment:

```bash
# Run the setup script
chmod +x ./scripts/setup-environment.sh
./scripts/setup-environment.sh
```

## Cross-Platform Compatibility

### Platform Considerations
- **Bash scripts**: Work on macOS, Linux, and WSL on Windows
- **PowerShell scripts**: Native on Windows, available on other platforms
- **Python scripts**: Cross-platform with proper shebang lines
- **Node.js scripts**: Cross-platform with npm/npx execution

### Best Practices
- **Test on multiple platforms** when possible
- **Use portable commands** and avoid platform-specific tools
- **Provide alternatives** for platform-specific functionality
- **Document platform requirements** clearly

## Error Handling and Output

### Script Output Guidelines
- **Use clear, actionable error messages**
- **Provide progress indicators** for long-running scripts
- **Log important actions** and their results
- **Return appropriate exit codes** (0 for success, non-zero for errors)

### Example Error Handling
```bash
#!/bin/bash
set -e  # Exit on any error

# Check prerequisites
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is not installed"
    exit 1
fi

# Provide progress feedback
echo "Setting up Python virtual environment..."
python3 -m venv venv || {
    echo "Error: Failed to create virtual environment"
    exit 1
}

echo "✅ Setup completed successfully"
```

## Documentation Requirements

### Script Documentation
Each script should include:
- **Purpose statement** at the top
- **Usage instructions** with examples
- **Parameter descriptions** for command-line arguments
- **Prerequisites** and dependencies
- **Expected output** descriptions

### SKILL.md Integration
When referencing scripts in SKILL.md:
- **Explain when to use** each script
- **Provide step-by-step instructions**
- **Include example usage** with expected output
- **Link to script files** using relative paths

## Agent Builder Framework Integration

### Project-Agnostic Design
- Scripts should work across **any technology stack**
- Use **template variables** or parameters for project-specific values
- **Avoid assumptions** about project structure or tools
- **Document customization points** clearly

### Quality Standards
- Follow the [validation checklist](../validation-checklist.md) for all scripts
- Ensure scripts meet [quality standards](../quality-standards.md)
- Test scripts in isolation and as part of the complete skill
- Maintain consistency with other Agent Builder Framework assets

## Examples

### Simple Validation Script
```bash
#!/bin/bash
# validate-yaml.sh - Validates YAML frontmatter in skill files

echo "Validating YAML frontmatter..."
python3 -c "
import yaml
import sys

try:
    with open('SKILL.md', 'r') as f:
        content = f.read()
    
    # Extract frontmatter
    if content.startswith('---'):
        end = content.find('---', 3)
        frontmatter = content[3:end]
        yaml.safe_load(frontmatter)
        print('✅ YAML frontmatter is valid')
    else:
        print('❌ No YAML frontmatter found')
        sys.exit(1)
        
except Exception as e:
    print(f'❌ YAML validation failed: {e}')
    sys.exit(1)
"
```

### Cross-Platform Setup Script
```bash
#!/bin/bash
# setup-tools.sh - Cross-platform development tool setup

detect_os() {
    case "$(uname -s)" in
        Darwin*) echo "macos";;
        Linux*) echo "linux";;
        CYGWIN*|MINGW*|MSYS*) echo "windows";;
        *) echo "unknown";;
    esac
}

install_tools() {
    local os=$(detect_os)
    echo "Detected OS: $os"
    
    case $os in
        macos)
            brew install jq curl
            ;;
        linux)
            sudo apt-get update && sudo apt-get install -y jq curl
            ;;
        windows)
            echo "Please install tools manually on Windows"
            echo "Required: jq, curl"
            ;;
        *)
            echo "Unsupported OS. Please install jq and curl manually."
            exit 1
            ;;
    esac
}

echo "Setting up development tools..."
install_tools
echo "✅ Tool setup completed"
```

Remember: Great scripts are **secure**, **portable**, **well-documented**, and **focused on a single purpose**. They enhance the Agent Skills workflow without creating unnecessary complexity or security risks.