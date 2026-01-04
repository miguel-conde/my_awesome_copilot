# Install Custom Agent

This example shows how to install a specific agent from a custom repository.

## Scenario
You want to install a security scanning agent from your company's private repository.

## User Input
```
"Install the security-scanner agent from mycompany/copilot-tools to my user profile"
```

## Skill Response
```
Repository: mycompany/copilot-tools
Asset Type: agent
Asset Path: agents/security-scanner.agent.md
Location: profile (~/.vscode/agents/)
```

## What Happens
1. Skill identifies custom repository specification
2. Validates repository access and agent path
3. Downloads security-scanner.agent.md
4. Installs to user profile for cross-workspace availability
5. Verifies agent frontmatter and provides usage guidance

## Expected Outcome
- Security scanner agent available in all workspaces
- Agent appears in VS Code chat dropdown
- Ready to use for security code reviews
