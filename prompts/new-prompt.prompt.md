---
agent: agent-builder
name: new-prompt-file
description: Interactive wizard for creating a new prompt file
---

Guide the user through creating a new prompt file with proper structure and best practices.

## Interactive Prompt File Creation Process

Follow these steps in order:

### Step 1: Understand the Task
Ask the user:
- What task should this prompt accomplish?
- Who will use it? (team members, specific role, general use)
- Is it a workflow, a question template, or a specialized command?
- Should it invoke a specific agent?

### Step 2: Research Similar Prompts
Use #tool:githubRepo to search Awesome Copilot for similar prompt file examples and show them for inspiration.

### Step 3: Design Prompt Structure

Determine together:
- **Prompt name**: Short, descriptive (becomes `/prompt-name` command)
- **Description**: What the prompt does (shown in prompt picker)
- **Target agent**: Should it invoke a specific agent? (optional)
  - Use `agent: agent-builder` to invoke this agent
  - Use `agent: plan` for planning workflows
  - Use `agent: agent` for implementation tasks
  - Leave blank for default agent
- **Tools override**: Does this prompt need specific tools? (optional)

### Step 4: Write Prompt Instructions

Draft the prompt content:
- Clear, actionable instructions
- Specific workflow steps if multi-turn
- Context references (files, documentation, examples)
- Expected output format
- Clarifying questions if needed

**Good prompt patterns**:
- Workflow prompts: Step-by-step process
- Template prompts: Fill-in-the-blank with examples
- Clarifying prompts: Ask questions first, then execute
- Research prompts: Gather context, then respond

### Step 5: Create the File

Use #tool:createFile to create `.github/prompts/<prompt-name>.prompt.md` with:
- Complete YAML frontmatter
- Clear, specific instructions
- References to relevant context
- Examples if helpful

### Step 6: Validation

Before finishing:
1. Read `.github/instructions/prompts.instructions.md` to ensure compliance
2. Verify YAML frontmatter syntax
3. Check that agent reference is valid (if specified)
4. Explain how to invoke: `/prompt-name` in chat
5. Suggest testing and refinement

## Example Prompt Types

### Workflow Prompt
```markdown
---
agent: plan
description: Create implementation plan with clarifying questions
---

Ask me 3 clarifying questions about the feature requirements.
Then create a detailed implementation plan following the template.
```

### Research Prompt
```markdown
---
description: Analyze codebase architecture
---

Search the codebase for:
1. Entry points and main components
2. Data flow patterns
3. External dependencies

Summarize the architecture with a diagram.
```

### Specialized Command
```markdown
---
agent: agent-builder
description: Quick reference for VSCode Copilot tools
---

List all available chat tools with brief descriptions.
Group by category (read-only, editing, execution).
```

## Remember

- Fetch Prompt Files documentation when needed
- Show examples from Awesome Copilot
- Keep prompts focused on one clear task
- Test the prompt before finalizing
