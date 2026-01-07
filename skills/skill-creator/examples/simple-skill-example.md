# Simple Skill Example: Commit Message Standards

This example demonstrates a simple Agent Skill that provides instructions only, without bundled resources.

## Skill Structure

```
.github/skills/commit-standards/
└── SKILL.md    # Instructions only - no additional resources
```

## SKILL.md Content

```markdown
---
name: commit-standards
description: Generate conventional commit messages following semantic versioning standards. Use when writing commit messages, setting up commit workflows, or establishing team commit conventions.
---

# Conventional Commit Message Standards

Generate commit messages that follow conventional commit format for clear project history and automated versioning.

## When to Use This Skill

- Writing commit messages for any project
- Setting up commit message templates
- Establishing team commit conventions
- Integrating with automated versioning systems
- Creating commit message validation workflows

## Conventional Commit Format

### Basic Structure
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Commit Types
- **feat**: New feature for the user
- **fix**: Bug fix for the user
- **docs**: Documentation changes
- **style**: Code style changes (formatting, no logic changes)
- **refactor**: Code changes that neither fix bugs nor add features
- **test**: Adding or correcting tests
- **chore**: Changes to build process or auxiliary tools

### Examples

#### Feature Commit
```
feat(auth): add OAuth2 authentication flow

Implement Google OAuth2 integration for user authentication.
Includes login/logout functionality and token refresh handling.

Closes #123
```

#### Bug Fix Commit
```
fix(api): resolve null pointer exception in user service

Handle edge case where user profile data is incomplete.
Add validation and default values for required fields.

Fixes #456
```

#### Breaking Change
```
feat(api)!: change user authentication endpoint

BREAKING CHANGE: The /auth endpoint now requires OAuth2 tokens 
instead of basic authentication. Update client applications to 
use the new authentication flow.
```

## Scope Guidelines

Choose appropriate scopes based on your project structure:
- **Components**: `feat(navbar)`, `fix(sidebar)`
- **Services**: `feat(auth)`, `fix(payment)`
- **Modules**: `feat(admin)`, `fix(dashboard)`
- **Layers**: `feat(api)`, `fix(database)`

## Message Guidelines

### Description
- Use imperative mood ("add" not "added" or "adds")
- Keep under 50 characters
- Don't capitalize first letter
- Don't end with period

### Body (Optional)
- Explain what and why, not how
- Wrap at 72 characters
- Separate from description with blank line

### Footer (Optional)
- Reference issues: `Fixes #123`, `Closes #456`
- Document breaking changes: `BREAKING CHANGE: description`
- Co-author credits: `Co-authored-by: Name <email>`

## Integration with Tools

### Git Templates
Create `.gitmessage` template:
```
<type>[scope]: <description>

# Body - explain what and why (wrap at 72 chars)

# Footer - reference issues, breaking changes, co-authors
```

### Commit Hooks
Use tools like `commitizen` or `conventional-changelog` for validation.

### Automated Versioning
Conventional commits enable semantic versioning automation through tools like `semantic-release`.

## Framework Integration

This skill works across any project type and integrates with:
- Version control best practices
- Automated CI/CD workflows  
- Team collaboration standards
- Documentation generation tools

Remember: Good commit messages are investments in your project's future maintainability.
```

## Key Characteristics

### Simple Skill Benefits
- **Fast loading**: Only SKILL.md content, no additional resources
- **Self-contained**: All information in single file
- **Universal applicability**: Works across all project types
- **Low maintenance**: Minimal file structure to manage

### When to Use Simple Skills
- Standards and conventions (like commit messages)
- Quick reference information
- Best practices guidance
- Process documentation
- Team guidelines and policies

### Design Considerations
- Make instructions comprehensive since no external resources are available
- Include plenty of examples within the SKILL.md content
- Ensure the description is specific enough for accurate discovery
- Focus on actionable guidance that doesn't require additional tools

This example shows how effective simple skills can be for providing consistent guidance across projects without requiring complex resource bundles.