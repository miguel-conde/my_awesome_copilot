---
description: Guidelines for creating Agent Skills files that follow the open standard and integrate with the Agent Builder Framework
applyTo: '**/skills/**/SKILL.md'
---

# Agent Skills Creation Guidelines

Follow these guidelines when creating Agent Skills files for the Agent Builder Framework.

## YAML Frontmatter Requirements

### Required Fields
- **name**: Unique identifier, lowercase with hyphens (max 64 characters)
  - Example: `python-testing`, `web-deployment`, `code-review-workflow`
- **description**: Specific description of capabilities and use cases (max 1024 characters)
  - Be specific about both what the skill does AND when to use it
  - Help Copilot decide when to load this skill

### Example Header
```yaml
---
name: python-testing-workflow  
description: Comprehensive Python testing workflow including unit tests, integration tests, and coverage reporting. Use when setting up test infrastructure or writing test cases for Python projects.
---
```

## Progressive Loading Design

Design skills with the three-level loading system in mind:

### Level 1: Discovery (Always Loaded)
- Craft `name` and `description` for efficient skill discovery
- Make description specific enough for Copilot to choose correctly
- Avoid generic descriptions like "helps with Python"

### Level 2: Instructions (Loaded When Relevant)
- Write clear, step-by-step procedures in SKILL.md body
- Include specific examples of input and output
- Reference bundled resources using relative paths

### Level 3: Resources (Loaded On-Demand)
- Store scripts, templates, examples in skill directory
- Use descriptive file names: `test-template.py`, `setup-script.sh`
- Reference with relative paths: `[test template](./test-template.py)`

## File Structure Standards

Organize skills consistently:
```
.github/skills/{skill-name}/
├── SKILL.md              # Required: Main skill definition
├── scripts/              # Optional: Executable scripts
├── templates/            # Optional: Code templates
├── examples/             # Optional: Usage examples
├── docs/                 # Optional: Additional documentation
└── data/                 # Optional: Reference data
```

## Skill Content Best Practices

### Instructions Body Structure
1. **Purpose statement**: What the skill accomplishes
2. **When to use**: Specific scenarios and triggers
3. **Step-by-step procedures**: Clear, actionable workflow
4. **Input/output examples**: Concrete demonstrations
5. **Resource references**: Links to bundled files

### Writing Guidelines
- Use clear, imperative language ("Create a test file", not "You should create")
- Include specific examples for each major step
- Reference project conventions from Agent Builder Framework
- Keep procedures focused and single-purpose

### Resource Integration
- Bundle related files in skill directory
- Use relative paths for all references
- Ensure resources follow project-agnostic design principles
- Include usage examples for complex resources

## Agent Builder Framework Integration

### Project-Agnostic Design
- Skills must work across different projects and technology stacks
- Avoid hardcoded paths, tool names, or project-specific assumptions
- Use templated approaches with placeholders for customization
- Focus on universal workflows rather than specific implementations

### Methodology Alignment  
- Reference Agent Builder Framework principles in skill instructions
- Include guidance on customizing skills for specific project contexts
- Emphasize reusability and portability across development environments
- Connect to existing Agent Builder prompts and instructions when relevant

### Framework Consistency
- Follow naming conventions: `skill-category-purpose` format
- Use consistent language and terminology
- Reference official VSCode documentation where appropriate
- Align with Agent Builder Framework's educational approach

## Quality Standards

### Validation Checklist
- [ ] YAML frontmatter includes required `name` and `description` fields
- [ ] Name follows lowercase-with-hyphens convention (max 64 chars)
- [ ] Description is specific about capabilities AND use cases (max 1024 chars)
- [ ] Instructions include clear step-by-step procedures
- [ ] All resource references use relative paths
- [ ] Content follows project-agnostic design principles
- [ ] Skill integrates well with Agent Builder Framework methodology

### Testing Approach
- Test skill discovery by checking if Copilot loads it for relevant requests
- Verify progressive loading by checking resource access patterns
- Validate portability by testing across different project types
- Ensure bundled resources work correctly with relative path references

## Example Skills Structure

### Simple Skill (Instructions Only)
```markdown
---
name: commit-message-standards
description: Generate conventional commit messages following semantic versioning standards. Use when writing commit messages or setting up commit workflows.
---

# Conventional Commit Message Standards

Generate commit messages that follow conventional commit format...
[detailed instructions]
```

### Complex Skill (With Resources)
```markdown
---
name: python-test-setup
description: Complete Python testing setup including pytest configuration, test templates, and coverage reporting. Use when initializing testing infrastructure for Python projects.
---

# Python Testing Setup Workflow

## Setup Process
1. Install testing dependencies using [requirements template](./requirements-test.txt)
2. Configure pytest using [pytest configuration](./pytest.ini)
3. Create test structure using [test template](./test_template.py)

[detailed step-by-step instructions]
```

Remember: Skills should be reusable capabilities that enhance the Agent Builder Framework's project-agnostic approach to VSCode Copilot customization.