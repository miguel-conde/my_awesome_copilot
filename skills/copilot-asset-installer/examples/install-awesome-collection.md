# Install Awesome-Copilot Collection

This example demonstrates how to install a complete collection from the awesome-copilot repository.

## Scenario
You want to set up a complete Python development environment with all relevant agents, prompts, and instructions.

## User Input
```
"Install the Python development collection from awesome-copilot to my workspace"
```

## Skill Response
```
Repository: github/awesome-copilot (default)
Asset Type: collection
Collection: python-development
Location: workspace (.github/)
```

## What Happens
1. Skill detects request for collection installation
2. Uses default awesome-copilot repository
3. Locates python-development.collection.yml
4. Installs all assets defined in collection to `.github/` folders
5. Provides confirmation and usage instructions

## Expected Outcome
- Python expert agent installed to `.github/agents/`
- Python testing prompts installed to `.github/prompts/`
- Python coding standards installed to `.github/instructions/`
- Ready-to-use Python development environment
