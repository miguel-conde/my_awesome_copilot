# Agent Skills Patterns Guide

Common patterns and approaches for designing different types of Agent Skills following the open standard and Agent Builder Framework principles.

## Skill Classification Patterns

### 1. **Simple Instruction Skills**
**When to use**: Single-purpose guidance that doesn't require additional resources
**Structure**: SKILL.md only
**Examples**: Code review checklists, commit message standards, API usage guidelines

```
.github/skills/commit-standards/
└── SKILL.md
```

**Pattern Characteristics**:
- Clear, focused instructions in SKILL.md
- No additional files needed
- Quick to implement and maintain
- Ideal for guidelines and standards

### 2. **Template-Based Skills**
**When to use**: Generating consistent code structures or configurations
**Structure**: SKILL.md + templates directory
**Examples**: Component generators, configuration templates, boilerplate creation

```
.github/skills/react-component-generator/
├── SKILL.md
└── templates/
    ├── component.tsx
    ├── component.test.tsx
    └── stories.tsx
```

**Pattern Characteristics**:
- Reusable code templates with placeholders
- Consistent project structure generation
- Reduces boilerplate code writing
- Easy customization for different projects

### 3. **Automated Workflow Skills**
**When to use**: Complex processes requiring script execution
**Structure**: SKILL.md + scripts + templates + examples
**Examples**: Testing frameworks setup, deployment automation, environment configuration

```
.github/skills/python-testing-workflow/
├── SKILL.md
├── scripts/
│   ├── setup-pytest.sh
│   └── run-coverage.py
├── templates/
│   ├── test_template.py
│   └── conftest.py
└── examples/
    └── sample-test-suite/
```

**Pattern Characteristics**:
- Multi-step automated processes
- Script-based execution
- Complete workflow implementation
- Higher complexity but more capability

### 4. **Reference Documentation Skills**
**When to use**: Comprehensive knowledge bases for specific domains
**Structure**: SKILL.md + docs + examples
**Examples**: API reference guides, troubleshooting knowledge bases, best practices collections

```
.github/skills/kubernetes-troubleshooting/
├── SKILL.md
├── docs/
│   ├── common-issues.md
│   ├── debugging-steps.md
│   └── resource-patterns.md
└── examples/
    ├── pod-debug-manifest.yaml
    └── service-troubleshoot.yaml
```

**Pattern Characteristics**:
- Extensive documentation and examples
- Domain-specific knowledge collection
- Reference materials for complex topics
- Progressive detail disclosure

## Progressive Loading Design Patterns

### Level 1: Discovery Optimization
**Goal**: Help Copilot decide when to load the skill

**Description Pattern**:
```yaml
description: "Specific capability + use cases + when to activate"
```

**Examples**:
- ✅ "Python testing setup with pytest, coverage, and fixtures. Use when initializing test infrastructure or improving existing test suites."
- ❌ "Helps with Python testing" (too generic)

**Best Practices**:
- Include both **what** and **when**
- Mention specific technologies or frameworks
- Use keywords that match common developer queries
- Keep within 1024 character limit

### Level 2: Instructions Structure
**Goal**: Provide clear, actionable guidance when skill is loaded

**Effective Structure Pattern**:
1. **Purpose Statement** - What this skill accomplishes
2. **Prerequisites** - What's needed before starting
3. **Step-by-Step Process** - Numbered, actionable steps
4. **Examples** - Concrete usage demonstrations
5. **Resource References** - Links to bundled files

**Example Structure**:
```markdown
# Python Testing Workflow Setup

## Purpose
Establish comprehensive testing infrastructure for Python projects...

## Prerequisites
- Python 3.8+ installed
- pip package manager available
- Project initialized with requirements.txt

## Setup Process
1. Install testing dependencies using [requirements template](./templates/requirements-test.txt)
2. Configure pytest using [configuration file](./templates/pytest.ini)
3. Create test structure using [test template](./templates/test_sample.py)

## Examples
### Basic Test Setup
```python
# Example test file structure...
```

### Advanced Configuration
```ini
# pytest.ini configuration...
```
```

### Level 3: Resource Organization
**Goal**: Provide on-demand access to specific resources

**Directory Organization Patterns**:

**By Resource Type**:
```
skill-name/
├── SKILL.md
├── scripts/      # Executable automation
├── templates/    # Reusable code/config templates  
├── examples/     # Usage demonstrations
└── docs/        # Additional documentation
```

**By Workflow Stage**:
```
skill-name/
├── SKILL.md
├── setup/       # Initial configuration resources
├── develop/     # Development-time resources
├── test/        # Testing resources
└── deploy/      # Deployment resources
```

**By Technology Stack**:
```
skill-name/
├── SKILL.md
├── frontend/    # Frontend-specific resources
├── backend/     # Backend-specific resources
├── database/    # Database resources
└── shared/      # Common resources
```

## Common Implementation Patterns

### 1. **Configuration Management Pattern**
For skills that manage project configurations:

```markdown
## Configuration Setup
1. Choose configuration type:
   - [Basic setup](./templates/basic-config.json)
   - [Advanced setup](./templates/advanced-config.json)
   - [Custom setup](./templates/custom-config.json)

2. Customize configuration:
   - Replace `{{PROJECT_NAME}}` with your project name
   - Update `{{API_ENDPOINT}}` with your API URL
   - Configure `{{ENVIRONMENT}}` settings

3. Validate configuration:
   - Run [validation script](./scripts/validate-config.py)
   - Check for required fields
   - Test connectivity
```

### 2. **Multi-Environment Pattern**
For skills supporting different development environments:

```markdown
## Environment Setup
Select your development environment:

### Local Development
- Use [local setup script](./scripts/setup-local.sh)
- Configure [local settings](./templates/local.env)

### Docker Environment  
- Use [Docker setup](./scripts/setup-docker.sh)
- Apply [container config](./templates/docker-compose.yml)

### Cloud Deployment
- Use [cloud setup script](./scripts/setup-cloud.sh)
- Configure [cloud settings](./templates/cloud.env)
```

### 3. **Testing Integration Pattern**
For skills that include testing capabilities:

```markdown
## Testing Workflow
1. **Setup Tests**: Use [test setup script](./scripts/setup-tests.sh)
2. **Create Test Files**: Copy [test templates](./templates/) to your project
3. **Run Tests**: Execute [test runner](./scripts/run-tests.sh)
4. **Generate Reports**: Use [reporting script](./scripts/generate-reports.sh)

### Test Types Available
- **Unit Tests**: [unit test template](./templates/unit-test.py)
- **Integration Tests**: [integration template](./templates/integration-test.py)
- **E2E Tests**: [e2e template](./templates/e2e-test.py)
```

## Project-Agnostic Design Patterns

### 1. **Template Variable Pattern**
Use placeholders for project-specific values:

```python
# templates/api-client.py
class {{API_CLASS_NAME}}Client:
    def __init__(self):
        self.base_url = "{{API_BASE_URL}}"
        self.api_key = os.getenv("{{API_KEY_ENV_VAR}}")
```

### 2. **Framework Detection Pattern**
Adapt to different technology stacks:

```markdown
## Framework Integration
This skill works with multiple frameworks:

### React Projects
- Use [React component template](./templates/react-component.tsx)
- Apply [React configuration](./templates/react.config.js)

### Vue Projects
- Use [Vue component template](./templates/vue-component.vue)  
- Apply [Vue configuration](./templates/vue.config.js)

### Angular Projects
- Use [Angular component template](./templates/angular-component.ts)
- Apply [Angular configuration](./templates/angular.json)
```

### 3. **Conditional Resource Pattern**
Provide different resources based on context:

```markdown
## Choose Your Setup Path

### New Project
- Run [initialization script](./scripts/init-new-project.sh)
- Use [starter templates](./templates/starter/)

### Existing Project
- Run [integration script](./scripts/integrate-existing.sh)
- Use [migration guides](./docs/migration.md)

### Legacy Project
- Run [legacy setup](./scripts/setup-legacy.sh)
- Use [compatibility templates](./templates/legacy/)
```

## Quality Patterns

### 1. **Validation Integration**
Build quality checks into skill workflows:

```markdown
## Quality Assurance
1. **Setup Validation**: Run [setup validator](./scripts/validate-setup.sh)
2. **Code Quality**: Use [quality checker](./scripts/check-quality.sh)
3. **Security Scan**: Execute [security scanner](./scripts/scan-security.sh)
4. **Performance Test**: Run [performance tests](./scripts/test-performance.sh)
```

### 2. **Documentation Pattern**
Maintain comprehensive documentation:

```markdown
## Documentation
- [Getting Started Guide](./docs/getting-started.md)
- [Advanced Usage](./docs/advanced-usage.md)  
- [Troubleshooting](./docs/troubleshooting.md)
- [FAQ](./docs/faq.md)
- [API Reference](./docs/api-reference.md)
```

### 3. **Example Progression Pattern**
Provide examples from simple to complex:

```markdown
## Examples
### Basic Example
[Simple usage](./examples/basic-example.md) - Get started quickly

### Intermediate Example  
[Common patterns](./examples/intermediate-example.md) - Real-world usage

### Advanced Example
[Complex scenarios](./examples/advanced-example.md) - Full-featured implementation
```

## Agent Builder Framework Integration Patterns

### 1. **Framework Asset References**
Connect skills to other framework components:

```markdown
## Framework Integration
This skill works with other Agent Builder Framework assets:
- Use with [@agent-builder](../../agents/agent-builder.agent.md) for guidance
- Reference [validation prompt](../../prompts/validate-definition.prompt.md) for quality checks
- Follow [skill instructions](../../instructions/skills.instructions.md) for best practices
```

### 2. **Skill Composition Pattern**
Design skills that work well together:

```markdown
## Related Skills
This skill pairs well with:
- **[memory](../memory/SKILL.md)**: For persistent information storage
- **[documentation-generator](../doc-generator/SKILL.md)**: For automated docs
- **[testing-framework](../testing/SKILL.md)**: For comprehensive testing
```

### 3. **Educational Pattern**
Teach concepts while providing tools:

```markdown
## Learning Outcomes
After using this skill, you will understand:
- How to structure scalable project configurations
- Best practices for environment management
- Common pitfalls and how to avoid them
- How to adapt patterns to your specific needs

## Next Steps
1. Practice with the provided examples
2. Customize templates for your project
3. Create your own skill variations
4. Share improvements with the community
```

## Anti-Patterns to Avoid

### 1. **Monolithic Skills**
❌ **Don't**: Create one skill that does everything
✅ **Do**: Create focused skills that do one thing well

### 2. **Platform-Specific Assumptions**
❌ **Don't**: Assume specific tools or file locations
✅ **Do**: Provide alternatives and detect environments

### 3. **Hardcoded Values**
❌ **Don't**: Include project-specific names or URLs
✅ **Do**: Use template variables and environment detection

### 4. **Poor Progressive Disclosure**
❌ **Don't**: Load all resources immediately  
✅ **Do**: Reference resources when needed via relative paths

### 5. **Insufficient Documentation**
❌ **Don't**: Assume users know how to use scripts and templates
✅ **Do**: Provide clear examples and step-by-step instructions

Remember: Great skills solve specific problems while remaining flexible enough to adapt across different projects and development environments. They follow the progressive loading principle and integrate well with the Agent Builder Framework's educational approach.