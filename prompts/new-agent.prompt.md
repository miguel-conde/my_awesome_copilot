---
agent: agent-builder
name: new-agent-file
description: Interactive wizard for creating a new custom agent definition
---

Guide the user through creating a new custom agent definition with proper structure and best practices.

## Interactive Agent Creation Process

Follow these steps in order:

### Step 1: Understand Requirements
Ask the user:
- What is the agent's purpose? (e.g., "code reviewer", "Python testing assistant", "documentation writer")
- What tasks should it perform?
- Who is the target user? (beginner, expert, specific team role)

### Step 1.5: Agent vs Skill Decision
Help the user decide between creating an agent or an Agent Skill:

**Choose Agent when**:
- Need interactive conversation capabilities
- Require complex reasoning and context management
- Want to switch personas/modes during chat
- Need handoffs to other agents
- Focused on conversational assistance

**Choose Agent Skill when**:
- Want automatic activation based on context
- Need bundled resources (templates, scripts, examples)
- Creating reusable capability across projects
- Building specialized workflow that loads on-demand
- Want portable capability across AI tools

If they need an Agent Skill instead, suggest using the [new-skill prompt](/new-skill) instead.

### Step 2: Research Similar Agents
Use #tool:githubRepo to search Awesome Copilot for similar agent examples and show them to the user for inspiration.

### Step 3: Design Agent Structure

Determine together:
- **Name**: Short, descriptive identifier (e.g., `code-reviewer`, `pytest-helper`)
- **Description**: One-line summary for the chat input placeholder
- **Tools**: Which tools does this agent need?
  - Read-only: `fetch`, `githubRepo`, `search`, `readFile`, `codebase`
  - Editing: `createFile`, `editFiles`, `edit` tool set
  - Execution: `runInTerminal`, `runTask`, `terminal` tool set
  - Specialized: `problems`, `testFailure`, `changes`, etc.
- **Model**: Recommend based on task:
  - `Claude Sonnet 4` for reasoning/planning/documentation
  - Smaller models for simpler, faster tasks
- **Handoffs**: Does this agent need to hand off to others?
  - To `@plan` for complex planning
  - To `@agent` for implementation
  - To specialized agents in the team

### Step 4: Define Persona and Instructions

Draft the agent's:
- Role and expertise
- Key behaviors and guidelines
- Workflow steps
- File creation guidelines (if applicable)
- Example interactions

### Step 5: Create the File

Use #tool:createFile to create `.github/agents/<agent-name>.agent.md` with:
- Complete YAML frontmatter
- Well-structured instructions
- Clear workflow
- References to project context (ARCHITECTURE.md, RESOURCES.md)

### Step 6: Validation

Before finishing:
1. Read `.github/instructions/agents.instructions.md` to ensure compliance
2. Verify YAML frontmatter syntax
3. Check that tool names are valid
4. Explain how to test the agent
5. Suggest next steps (testing, refinement, creating supporting prompts)

## Example Questions to Guide Creation

- "Should this agent be read-only or have editing capabilities?"
- "What existing agents should it collaborate with?"
- "What's a typical workflow this agent would follow?"
- "What edge cases or common mistakes should it handle?"

## Remember

- Fetch official documentation when needed
- Show examples from Awesome Copilot
- Explain the "why" behind choices
- Follow project's agent architecture (see ARCHITECTURE.md)
