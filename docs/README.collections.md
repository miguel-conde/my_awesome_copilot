# 📦 Copilot Collections

Curated collections of GitHub Copilot customizations (agents, prompts, instructions, and skills) organized around specific themes, technologies, or workflows.

### How to Use Collections

**To Install:**
- Browse the collection markdown files to see all included items
- Click individual install buttons for each agent, prompt, or instruction you want
- Collections organize related customizations - install the ones you need

**To Deploy:**
- Use the `deploy-collection` prompt with a collection YAML file
- Collections support both local and remote repository sources
- Dependency resolution ensures proper installation order

**Collection Benefits:**
- **Curated**: Pre-tested combinations of customizations that work well together
- **Themed**: Focused on specific technologies, workflows, or use cases
- **Versioned**: Track and manage collections as cohesive units
- **Shareable**: Distribute complete development environments

## Available Collections

| Title | Description | Items | Tags |
|-------|-------------|-------|----- |
| [Agent Builder Framework](../collections/agent-builder.md) | A comprehensive project-agnostic framework for VSCode Copilot customization that helps teams create and manage custom agents, prompts, instructions, and Agent Skills across any development workflow. | 23 items (agents, prompts, instructions, skills, resources) | `vscode-copilot`, `customization`, `framework`, `project-agnostic`, `meta-learning` |

## Collection Format

Collections use YAML format with the following structure:

```yaml
id: collection-id
name: Collection Display Name
description: Brief description of the collection
tags: [tag1, tag2, tag3]
version: "1.0.0"
author: Your Name
license: MIT
repository: https://github.com/your-repo

items:
  - path: .github/agents/example.agent.md
    kind: agent
    description: Optional description
    
  - path: .github/prompts/example.prompt.md
    kind: prompt
    
  - path: .github/instructions/example.instructions.md
    kind: instruction
    
  - path: .github/skills/example-skill/SKILL.md
    kind: skill

dependencies:
  - id: another-collection
    source: https://github.com/other-repo
    version: ">=1.0.0"
```

## Creating Collections

### Step 1: Define Your Collection

1. Create a `*.collection.yml` file in the `collections/` directory
2. Define metadata (id, name, description, tags)
3. List all items to include with their types
4. Specify any dependencies

### Step 2: Test Your Collection

1. Use the `deploy-collection` prompt to test installation
2. Verify all items install correctly
3. Test that agents, prompts, and instructions work as expected
4. Validate dependency resolution

### Step 3: Document Your Collection

1. Add comprehensive description in the YAML file
2. Include relevant tags for discoverability
3. Document any special requirements or setup
4. Provide usage examples

## Collection Categories

### Framework Collections
- **Agent Builder Framework**: Complete meta-framework for Copilot customization
- Development environment setups
- Multi-agent workflow systems

### Technology-Specific Collections
- Language-specific development stacks
- Framework and library combinations
- Platform and cloud provider toolsets

### Workflow Collections
- CI/CD pipeline customizations
- Testing and quality assurance
- Documentation and knowledge management

## Contributing

To contribute a new collection:

1. Create your `*.collection.yml` file in the `collections/` directory
2. Follow the collection format guidelines above
3. Test your collection thoroughly
4. Update this README.md with your collection's details
5. Submit a pull request

## Repository Structure

```
/
├── collections/    # Collection definition files
├── agents/         # Custom agent definitions
├── prompts/        # Reusable prompt files
├── instructions/   # Custom instructions files
├── skills/         # Agent Skills packages
└── docs/          # Documentation
```

For more examples and community-contributed collections, see the [Awesome Copilot repository](https://github.com/github/awesome-copilot/tree/main).