# Complex Skill Example: Python Testing Workflow

This example demonstrates a comprehensive Agent Skill with bundled resources including templates, scripts, and documentation.

## Skill Structure

```
.github/skills/python-testing/
├── SKILL.md                           # Main skill definition
├── templates/
│   ├── test_template.py               # Test file template
│   ├── conftest.py                    # Pytest configuration template
│   └── requirements-test.txt          # Testing dependencies template
├── scripts/
│   ├── setup-testing.sh               # Automated test setup script
│   └── run-coverage.sh                # Coverage reporting script
├── examples/
│   ├── unit_test_example.py          # Complete unit test example
│   └── integration_test_example.py   # Integration test example
└── docs/
    ├── pytest-configuration.md       # Detailed pytest setup guide
    └── coverage-best-practices.md    # Coverage reporting guidance
```

## SKILL.md Content

```markdown
---
name: python-testing
description: Complete Python testing setup including pytest configuration, test templates, coverage reporting, and best practices. Use when initializing testing infrastructure, writing test cases, or setting up CI/CD testing workflows for Python projects.
---

# Python Testing Workflow

Set up comprehensive testing infrastructure for Python projects using pytest, coverage reporting, and industry best practices.

## When to Use This Skill

- Initializing testing setup for new Python projects
- Standardizing test structure across existing projects
- Setting up automated testing in CI/CD pipelines
- Implementing coverage reporting and quality gates
- Training team members on Python testing best practices

## Complete Testing Setup Process

### Step 1: Install Testing Dependencies

Install required packages using the [testing requirements template](./templates/requirements-test.txt):

```bash
pip install -r requirements-test.txt
```

Key dependencies include:
- `pytest`: Core testing framework
- `pytest-cov`: Coverage reporting
- `pytest-mock`: Mocking utilities  
- `pytest-xdist`: Parallel test execution

### Step 2: Configure Pytest

Set up pytest configuration using [conftest.py template](./templates/conftest.py):

1. Copy the template to your project root
2. Customize fixtures for your specific needs
3. Configure test discovery patterns
4. Set up shared testing utilities

See [pytest configuration guide](./docs/pytest-configuration.md) for detailed setup instructions.

### Step 3: Create Test Structure

Organize tests using the [test template](./templates/test_template.py):

```
your-project/
├── src/
│   └── your_package/
├── tests/
│   ├── unit/
│   ├── integration/
│   └── conftest.py
└── requirements-test.txt
```

### Step 4: Write Quality Tests

Follow testing patterns from our examples:
- [Unit test example](./examples/unit_test_example.py): Complete unit testing patterns
- [Integration test example](./examples/integration_test_example.py): End-to-end testing approach

### Step 5: Set Up Coverage Reporting

Configure coverage using the [coverage script](./scripts/run-coverage.sh):

```bash
./scripts/run-coverage.sh
```

This generates HTML reports and enforces coverage thresholds. See [coverage best practices](./docs/coverage-best-practices.md) for optimization strategies.

### Step 6: Automate Setup (Optional)

Use the [setup automation script](./scripts/setup-testing.sh) for quick project initialization:

```bash
./scripts/setup-testing.sh your-project-name
```

This script:
- Creates test directory structure
- Installs dependencies
- Configures pytest
- Sets up basic test files

## Testing Best Practices

### Test Organization
- **Unit tests**: Test individual functions/classes in isolation
- **Integration tests**: Test component interactions
- **End-to-end tests**: Test complete user workflows

### Naming Conventions
- Test files: `test_*.py` or `*_test.py`
- Test functions: `test_*` prefix
- Test classes: `Test*` prefix

### Assert Patterns
- Use descriptive assertion messages
- Prefer specific asserts over generic ones
- Test both positive and negative scenarios

### Mocking Guidelines
- Mock external dependencies
- Use dependency injection for testability
- Mock at the integration boundary

## Resource Files Reference

### Templates
- **[test_template.py](./templates/test_template.py)**: Standard test file structure
- **[conftest.py](./templates/conftest.py)**: Pytest configuration with common fixtures
- **[requirements-test.txt](./templates/requirements-test.txt)**: Testing dependencies

### Scripts
- **[setup-testing.sh](./scripts/setup-testing.sh)**: Automated project setup
- **[run-coverage.sh](./scripts/run-coverage.sh)**: Coverage reporting automation

### Examples
- **[unit_test_example.py](./examples/unit_test_example.py)**: Comprehensive unit test patterns
- **[integration_test_example.py](./examples/integration_test_example.py)**: Integration testing examples

### Documentation
- **[pytest-configuration.md](./docs/pytest-configuration.md)**: Detailed setup guide
- **[coverage-best-practices.md](./docs/coverage-best-practices.md)**: Coverage optimization

## Framework Integration

This testing workflow integrates with:
- **Agent Builder Framework**: Project-agnostic testing patterns
- **CI/CD workflows**: Automated testing and quality gates  
- **Code quality tools**: Linting, formatting, and analysis
- **Development practices**: TDD, BDD, and testing strategies

Remember: Good tests are an investment in code reliability, maintainability, and team confidence.
```

## Bundled Resources Overview

### Templates (`./templates/`)
Ready-to-use configuration and code templates that users can copy and customize for their projects.

### Scripts (`./scripts/`)
Executable automation that performs setup tasks, runs processes, or generates reports.

### Examples (`./examples/`)
Complete, working examples that demonstrate proper usage patterns and best practices.

### Documentation (`./docs/`)
Detailed guides that supplement the main SKILL.md instructions with comprehensive information.

## Key Characteristics

### Complex Skill Benefits
- **Complete workflows**: Everything needed in one skill package
- **Automation**: Scripts reduce manual setup work
- **Customization**: Templates provide starting points for adaptation
- **Learning**: Examples show real-world implementation patterns
- **Reference**: Documentation provides deep-dive information

### When to Use Complex Skills
- Multi-step workflows requiring automation
- Standardization across teams and projects
- Educational purposes with comprehensive examples
- Tools that benefit from templates and scaffolding
- Processes requiring multiple types of resources

### Design Considerations
- Ensure SKILL.md remains comprehensive even without resources
- Use relative paths for all resource references
- Keep resources focused and avoid feature creep
- Make templates easily customizable
- Design scripts to be safe and well-documented

This example shows how complex skills can provide complete, professional-grade workflows while maintaining the project-agnostic principles of the Agent Builder Framework.