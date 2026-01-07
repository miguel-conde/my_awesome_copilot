#!/bin/bash

# Agent Skills Directory Creation Script
# Creates standard directory structure for new Agent Skills

set -e

# Function to display usage
usage() {
    echo "Usage: $0 <skill-name>"
    echo ""
    echo "Creates a new Agent Skill directory structure following the open standard."
    echo ""
    echo "Arguments:"
    echo "  skill-name    Lowercase name with hyphens (e.g., 'python-testing')"
    echo ""
    echo "Examples:"
    echo "  $0 python-testing"
    echo "  $0 web-deployment"
    echo "  $0 code-review-workflow"
    echo ""
    echo "Creates structure:"
    echo "  .github/skills/\${skill-name}/"
    echo "  ├── SKILL.md              # Main skill definition"
    echo "  ├── templates/            # Code templates"
    echo "  ├── scripts/              # Automation scripts"
    echo "  ├── examples/             # Usage examples"
    echo "  └── docs/                 # Additional documentation"
    exit 1
}

# Validate arguments
if [ $# -ne 1 ]; then
    echo "Error: Skill name is required"
    echo ""
    usage
fi

SKILL_NAME="$1"

# Validate skill name format
if [[ ! "$SKILL_NAME" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    echo "Error: Skill name must be lowercase with hyphens only"
    echo "Valid examples: python-testing, web-deployment, code-review"
    echo "Invalid: Python_Testing, webDeployment, code.review"
    exit 1
fi

# Check maximum length (64 characters as per Agent Skills standard)
if [ ${#SKILL_NAME} -gt 64 ]; then
    echo "Error: Skill name too long (${#SKILL_NAME} chars). Maximum 64 characters allowed."
    exit 1
fi

# Determine workspace root (find .git directory)
WORKSPACE_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
SKILLS_DIR="$WORKSPACE_ROOT/.github/skills"
SKILL_DIR="$SKILLS_DIR/$SKILL_NAME"

echo "Creating Agent Skill: $SKILL_NAME"
echo "Workspace root: $WORKSPACE_ROOT"
echo "Skills directory: $SKILLS_DIR"
echo ""

# Create main skills directory if it doesn't exist
if [ ! -d "$SKILLS_DIR" ]; then
    echo "Creating skills directory: $SKILLS_DIR"
    mkdir -p "$SKILLS_DIR"
fi

# Check if skill already exists
if [ -d "$SKILL_DIR" ]; then
    echo "Error: Skill '$SKILL_NAME' already exists at $SKILL_DIR"
    exit 1
fi

# Create skill directory structure
echo "Creating skill directory structure:"
mkdir -p "$SKILL_DIR"
echo "  ✓ $SKILL_DIR/"

mkdir -p "$SKILL_DIR/templates"
echo "  ✓ $SKILL_DIR/templates/"

mkdir -p "$SKILL_DIR/scripts"
echo "  ✓ $SKILL_DIR/scripts/"

mkdir -p "$SKILL_DIR/examples"
echo "  ✓ $SKILL_DIR/examples/"

mkdir -p "$SKILL_DIR/docs"
echo "  ✓ $SKILL_DIR/docs/"

# Create basic SKILL.md from template
SKILL_MD="$SKILL_DIR/SKILL.md"
cat > "$SKILL_MD" << EOF
---
name: $SKILL_NAME
description: Description of what this skill does and when to use it. Be specific about both capabilities and use cases to help Copilot decide when to load this skill.
---

# ${SKILL_NAME^} Skill

Brief overview of what this skill accomplishes.

## When to Use This Skill

- Specific scenario 1
- Specific scenario 2
- Specific scenario 3

## Main Workflow

### Step 1: Initial Setup

Describe the first step in detail.

### Step 2: Core Process

Describe the main process steps.

### Step 3: Completion

Describe how to complete the workflow.

## Examples

### Example 1: Basic Usage
\`\`\`
Example code or commands
\`\`\`

### Example 2: Advanced Usage
\`\`\`
More complex example
\`\`\`

## Resource References

- [Template file](./templates/template-name.ext)
- [Script file](./scripts/script-name.sh)
- [Example file](./examples/example-name.ext)

## Integration Notes

Guidance on how this skill integrates with the Agent Builder Framework and project-specific considerations.
EOF

echo "  ✓ Created $SKILL_MD"

# Create .gitkeep files for empty directories
touch "$SKILL_DIR/templates/.gitkeep"
touch "$SKILL_DIR/scripts/.gitkeep"
touch "$SKILL_DIR/examples/.gitkeep"
touch "$SKILL_DIR/docs/.gitkeep"

echo ""
echo "🎉 Agent Skill '$SKILL_NAME' created successfully!"
echo ""
echo "Next steps:"
echo "1. Edit $SKILL_MD to define your skill:"
echo "   - Update the description with specific capabilities and use cases"
echo "   - Replace placeholder content with actual instructions"
echo "   - Add step-by-step procedures"
echo ""
echo "2. Add bundled resources as needed:"
echo "   - Templates: $SKILL_DIR/templates/"
echo "   - Scripts: $SKILL_DIR/scripts/"
echo "   - Examples: $SKILL_DIR/examples/"
echo "   - Documentation: $SKILL_DIR/docs/"
echo ""
echo "3. Test the skill by triggering relevant prompts in Copilot Chat"
echo ""
echo "4. Use relative paths to reference bundled files: [filename](./templates/filename.ext)"
echo ""
echo "📚 Resources:"
echo "- Agent Skills documentation: https://code.visualstudio.com/docs/copilot/customization/agent-skills"
echo "- Agent Skills standard: https://agentskills.io/"
echo "- Agent Builder Framework: https://github.com/miguel-conde/agent-builder"