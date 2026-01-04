---
agent: agent-builder
name: new-instructions-file
description: Interactive wizard for creating custom instructions files
---

Guide the user through creating a new instructions file (`.instructions.md`) with proper structure and best practices.

## Interactive Instructions File Creation Process

Follow these steps in order:

### Step 1: Understand the Purpose
Ask the user:
- What specific guidelines or rules do they want to define?
- What files or directories should these instructions apply to?
- Is this for a specific programming language, framework, or task?
- Should it be workspace-specific or user-wide?

### Step 2: Fetch Official Documentation
Use #tool:fetch to access the [Custom Instructions documentation](https://code.visualstudio.com/docs/copilot/customization/custom-instructions) to ensure accuracy and show current best practices.

### Step 3: Design Instructions Structure

Determine together:
- **File name**: Descriptive name ending in `.instructions.md`
- **Description**: Brief summary of what the instructions cover
- **ApplyTo pattern**: Glob pattern to target specific files:
  - `**/*.py` - All Python files
  - `src/**` - All files in src directory
  - `**/*.{js,ts}` - All JavaScript/TypeScript files
  - `tests/**/*.test.*` - All test files
  - `docs/**` - All documentation files
  - `**` - All files (use sparingly)
- **Location**: `.github/instructions/` for workspace or user profile for cross-workspace

### Step 4: Content Guidelines

Help craft instructions that are:
- **Specific**: Focus on this project's conventions, not generic advice
- **Actionable**: Clear rules AI agents can follow
- **Concise**: Short, focused statements
- **Self-contained**: Each instruction should be complete

**Good instruction patterns**:
- Coding style: "Use 4 spaces for indentation in Python files"
- Naming conventions: "Use camelCase for JavaScript function names"
- Documentation: "Include JSDoc comments for all exported functions"
- Testing: "Write tests in the `__tests__` directory with `.test.js` extension"
- Security: "Never hardcode API keys or secrets in source files"

### Step 5: Create the File

Use #tool:createFile to create the instructions file with:
- Complete YAML frontmatter (`description`, `applyTo`)
- Clear, focused instructions in the body
- References to project-specific conventions
- Markdown formatting for readability

### Step 6: Validation and Testing

Before finishing:
1. Read `.github/instructions/instructions.instructions.md` to ensure compliance
2. Verify the `applyTo` glob pattern matches intended files
3. Check YAML frontmatter syntax
4. Explain how the instructions will be applied:
   - Automatically when editing matching files
   - Manually via "Add Context > Instructions" in chat
5. Suggest testing with a sample chat request

## Example File Structures

### Language-Specific Instructions
```markdown
---
description: Python coding standards for this project
applyTo: '**/*.py'
---

# Python Guidelines

- Follow PEP 8 style guide
- Use type hints for all function parameters and returns
- Write docstrings in Google style for all classes and functions
- Use f-strings for string formatting
- Organize imports: standard library, third-party, local modules
```

### Task-Specific Instructions
```markdown
---
description: Testing guidelines for all test files
applyTo: '**/test*/**'
---

# Testing Standards

- Use descriptive test names that explain the scenario
- Follow AAA pattern: Arrange, Act, Assert
- Mock external dependencies
- Include both positive and negative test cases
- Add integration tests for critical workflows
```

### Framework-Specific Instructions
```markdown
---
description: React component development guidelines
applyTo: 'src/components/**/*.{jsx,tsx}'
---

# React Component Guidelines

- Use functional components with hooks
- Extract custom hooks for reusable logic
- Use TypeScript interfaces for prop definitions
- Follow single responsibility principle
- Include accessibility attributes (aria-labels, roles)
```

## Common ApplyTo Patterns

- `**/*.md` - All Markdown files
- `src/**` - All files in src directory and subdirectories
- `**/*.{js,jsx,ts,tsx}` - All JavaScript/TypeScript files
- `*.config.{js,json}` - Configuration files in root
- `docs/**/*.md` - Documentation files only
- `.github/**` - All GitHub-specific files
- `tests/**/*.test.*` - Test files with specific naming

## Remember

- Fetch official documentation for latest syntax
- Keep instructions project-specific, not generic
- Test the `applyTo` pattern matches intended files
- Instructions apply automatically when editing matching files
- Can be manually attached to any chat request
- Store in workspace (`.github/instructions/`) to share with team