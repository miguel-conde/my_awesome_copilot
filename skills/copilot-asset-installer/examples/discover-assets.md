# Discover Assets for Current Project

This example demonstrates intelligent asset discovery based on project analysis.

## Scenario
You have a React/JavaScript project and want to find relevant copilot assets.

## User Input
```
"Analyze this project and discover relevant copilot assets"
```

## Skill Response
```
Action: discover
Technology: javascript, react
Repository: github/awesome-copilot (default)
```

## What Happens
1. Skill analyzes current directory for:
   - package.json (detects React, TypeScript, testing frameworks)
   - File extensions (.js, .jsx, .ts, .tsx)
   - Build tools (webpack, vite, etc.)
   - Development patterns

2. Searches awesome-copilot repository for compatible assets:
   - Frontend development agents
   - React-specific prompts
   - JavaScript coding standards
   - Testing and debugging tools

3. Provides compatibility scores and recommendations

## Expected Outcome
- List of relevant assets with compatibility scores
- Personalized recommendations based on project stack
- Option to install suggested assets with one command
