---
agent: agent-builder
name: new-skill-file
description: Interactive wizard for creating a new Agent Skill with proper structure and progressive loading
---

Guide the user through creating a new Agent Skill following the open standard with proper structure and best practices.

## Interactive Agent Skill Creation Process

Follow these steps in order:

### Step 1: Understand the Capability
Ask the user:
- What specific capability or workflow should this skill provide?
- When should Copilot automatically load this skill?
- Who will benefit from this skill? (beginners, experts, specific roles)
- Is this a simple instruction skill or does it need bundled resources?

### Step 2: Research Similar Skills
Use #tool:githubRepo to search Awesome Copilot and anthropics/skills repositories for similar skill examples and show them for inspiration.

### Step 3: Design Skill Structure

Determine together:
- **Skill name**: Unique identifier (lowercase, hyphens, max 64 chars)
  - Format: `category-purpose` (e.g., `python-testing`, `web-deployment`)
- **Description**: Specific description including capabilities AND use cases (max 1024 chars)
  - Must explain both what it does and when to use it
  - Help Copilot decide when to load the skill
- **Complexity level**:
  - **Simple**: Instructions only (SKILL.md)
  - **Template-based**: SKILL.md + templates directory
  - **Automated**: SKILL.md + scripts + templates + examples
  - **Reference**: SKILL.md + docs + examples

### Step 4: Plan Progressive Loading Strategy
Explain how the three-level loading system works:
- **Level 1 (Discovery)**: name and description help Copilot find the skill
- **Level 2 (Instructions)**: SKILL.md loads when relevant
- **Level 3 (Resources)**: Additional files load on-demand via relative paths

### Step 5: Choose Resource Bundle
Based on complexity, determine what resources to include:

**For Simple Skills**:
- Just SKILL.md with comprehensive instructions
- Include examples within the main file

**For Complex Skills**, ask which resources are needed:
- **Templates**: Reusable code/config templates with placeholders
- **Scripts**: Automation scripts (setup, validation, etc.)
- **Examples**: Usage demonstrations and sample implementations
- **Documentation**: Additional reference materials

### Step 6: Fetch Official Documentation
Use #tool:fetch to access the [Agent Skills documentation](https://code.visualstudio.com/docs/copilot/customization/agent-skills) to ensure accuracy with current best practices.

### Step 7: Reference Framework Guidelines
Check #tool:readFile to read the [skills instructions](/.github/instructions/skills.instructions.md) for project-specific guidelines and requirements.

### Step 8: Create Skill Structure

Based on the user's choices:

1. **Create directory structure** using the pattern:
   ```
   .github/skills/{skill-name}/
   ├── SKILL.md              # Main skill definition (required)
   ├── templates/            # Code templates (if needed)
   ├── scripts/              # Executable scripts (if needed)
   ├── examples/             # Usage demonstrations (if needed)
   └── docs/                 # Additional documentation (if needed)
   ```

2. **Generate SKILL.md** with:
   - YAML frontmatter with name and description
   - Purpose statement and when to use
   - Step-by-step procedures
   - Examples and resource references

3. **Create bundled resources** as determined:
   - Template files with placeholder variables
   - Scripts with proper error handling and cross-platform support
   - Example files demonstrating usage
   - Documentation for complex scenarios

### Step 9: Apply Quality Standards
Remind the user to:
- Follow project-agnostic design principles
- Use relative paths for all resource references
- Test skill discovery and progressive loading
- Validate YAML frontmatter syntax
- Check against the [validation checklist](/.github/skills/skill-creator/docs/validation-checklist.md)

### Step 10: Integration Testing
Suggest testing approach:
- Trigger relevant prompts to test skill discovery
- Verify progressive loading behavior
- Test resource access via relative paths
- Ensure portability across different project types

## Example Skill Types

Show these common patterns as inspiration:

### Simple Instruction Skill
```markdown
---
name: commit-standards
description: Generate conventional commit messages following semantic versioning standards. Use when writing commit messages or setting up commit workflows.
---

# Conventional Commit Standards
Follow these patterns for commit messages...
```

### Template-Based Skill
```markdown
---
name: react-component
description: Generate React components with TypeScript, tests, and stories. Use when creating new components or setting up component structure.
---

# React Component Generator
Create React components using these templates:
- [Component template](./templates/component.tsx)
- [Test template](./templates/component.test.tsx)
- [Story template](./templates/component.stories.tsx)
```

### Automated Workflow Skill
```markdown
---
name: python-testing
description: Complete Python testing setup with pytest, coverage, and fixtures. Use when initializing test infrastructure or improving existing test suites.
---

# Python Testing Workflow
Set up comprehensive Python testing:
1. Run [setup script](./scripts/setup-testing.sh)
2. Use [test templates](./templates/)
3. Configure [coverage reporting](./scripts/coverage-report.py)
```

## Framework Integration

Explain how the skill integrates with Agent Builder Framework:
- Follows project-agnostic design principles
- Aligns with educational approach (teaches concepts)
- Maintains reusability across technology stacks
- Integrates with existing framework assets when appropriate

## Best Practices Reminders

- **Keep focused**: One skill, one primary capability
- **Be specific**: Description should clearly indicate when to use
- **Stay portable**: Work across different projects and environments
- **Document thoroughly**: Include clear examples and instructions
- **Test progressively**: Verify all three loading levels work correctly
- **Follow standards**: Use the open Agent Skills standard and framework guidelines

Remember: Great skills solve specific problems while remaining flexible enough to adapt across different projects and development environments.