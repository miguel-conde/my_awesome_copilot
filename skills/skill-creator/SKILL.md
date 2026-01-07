---
name: skill-creator
description: Complete workflow for creating Agent Skills following the open standard. Use when building new capabilities, setting up skill directories, or designing progressive loading workflows for VSCode Copilot customization.
---

# Agent Skills Creation Workflow

Create comprehensive Agent Skills that follow the open standard and integrate with the Agent Builder Framework.

## When to Use This Skill

- Setting up new Agent Skills from scratch
- Creating skill directory structures with bundled resources
- Designing skills with progressive loading principles
- Ensuring quality and consistency across skill implementations
- Building educational or workflow-specific capabilities for Copilot

## Complete Skill Creation Process

### Step 1: Planning and Design

1. **Define the skill purpose**:
   - What specific capability or workflow will this skill provide?
   - When should Copilot load this skill automatically?
   - What level of complexity is needed (simple instructions vs. complex with resources)?

2. **Choose skill name**:
   - Use lowercase with hyphens format: `category-purpose`
   - Examples: `python-testing`, `web-deployment`, `code-review-workflow`
   - Maximum 64 characters, must be unique

3. **Design progressive loading strategy**:
   - Level 1 (Discovery): Craft specific description for skill discovery
   - Level 2 (Instructions): Plan step-by-step workflow content
   - Level 3 (Resources): Identify scripts, templates, or data needed

### Step 2: Directory Structure Creation

Use the [directory creation script](./create-skill-structure.sh) to set up the standard layout:

```bash
.github/skills/{skill-name}/
├── SKILL.md              # Main skill definition (required)
├── templates/            # Code templates and examples
├── scripts/              # Executable automation scripts
├── examples/             # Usage demonstrations
└── docs/                 # Additional documentation
```

### Step 3: SKILL.md File Creation

Create the main skill file using the [SKILL.md template](./templates/skill-template.md):

1. **YAML Frontmatter**:
   - `name`: Your chosen skill identifier
   - `description`: Specific description including capabilities AND use cases

2. **Instructions Body**:
   - Purpose statement and when to use
   - Step-by-step procedures
   - Input/output examples
   - Resource references with relative paths

3. **Quality Validation**:
   - Use the [validation checklist](./docs/validation-checklist.md)
   - Ensure project-agnostic design
   - Test progressive loading behavior

### Step 4: Resource Bundle Creation

Depending on skill complexity, add appropriate bundled resources:

**For Simple Skills** (Instructions Only):
- Focus on clear, comprehensive SKILL.md content
- Include examples within the main file
- Reference external documentation when needed

**For Complex Skills** (With Resources):
- Create templates using [template examples](./examples/)
- Add automation scripts following [script guidelines](./docs/script-guidelines.md)
- Include usage examples and documentation
- Ensure all resources use relative path references

### Step 5: Integration and Testing

1. **Framework Integration**:
   - Ensure alignment with Agent Builder Framework principles
   - Follow project-agnostic design patterns
   - Reference existing framework assets when appropriate

2. **Testing Workflow**:
   - Test skill discovery by triggering relevant prompts
   - Verify progressive loading behavior
   - Validate resource access and relative path references
   - Ensure portability across different project types

3. **Quality Assurance**:
   - Review against [quality standards](./docs/quality-standards.md)
   - Check compliance with skills.instructions.md guidelines
   - Validate YAML frontmatter syntax and field requirements

## Examples and Templates

### Simple Skill Example
See [commit-standards example](./examples/simple-skill-example.md) for a basic instructions-only skill.

### Complex Skill Example  
See [python-testing example](./examples/complex-skill-example/) for a skill with bundled templates and scripts.

### Common Skill Patterns
Reference [skill patterns guide](./docs/skill-patterns.md) for proven approaches to different types of capabilities.

## Resource Files Reference

- **[create-skill-structure.sh](./create-skill-structure.sh)**: Automated directory creation
- **[skill-template.md](./templates/skill-template.md)**: SKILL.md file template
- **[validation-checklist.md](./validation-checklist.md)**: Quality assurance checklist
- **[quality-standards.md](./docs/quality-standards.md)**: Detailed quality requirements
- **[script-guidelines.md](./docs/script-guidelines.md)**: Best practices for bundled scripts

## Agent Builder Framework Integration

This skill creation workflow follows the Agent Builder Framework's core principles:

- **Project-agnostic design**: Skills work across any technology stack
- **Educational approach**: Teaches concepts while providing tools
- **Reusability focus**: Created skills can be shared and adapted
- **Quality standards**: Maintains consistency across all framework assets
- **Progressive disclosure**: Supports efficient loading and discovery

Remember: Great skills solve specific problems while remaining flexible enough to adapt across different projects and development environments.