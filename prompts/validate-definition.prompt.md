---
agent: agent-builder
name: validate-definition
description: Validate agent or prompt file structure against official documentation
---

Validate an agent definition (`.agent.md`) or prompt file (`.prompt.md`) against official VSCode documentation and project guidelines.

## Validation Process

### Step 1: Identify File Type
Ask the user which file to validate, or use #tool:search to find recent agent/prompt files in the workspace.

### Step 2: Read the File
Use #tool:readFile to load the file content.

### Step 3: Fetch Official Documentation
- For `.agent.md`: Fetch [Custom Agents documentation](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- For `.prompt.md`: Fetch [Prompt Files documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files)

### Step 4: Check Structure

#### For Agent Files (`.agent.md`)
Validate:
- [ ] **File location**: Is it in `.github/agents/`?
- [ ] **File extension**: Is it `.agent.md`?
- [ ] **YAML frontmatter**: Present and properly formatted?
- [ ] **Required fields**: `description` is present
- [ ] **Optional fields**: Check `name`, `tools`, `model`, `handoffs`, `target`, `infer`
- [ ] **Tool names**: Are all tools valid? (check against available tools list)
- [ ] **Handoff structure**: If present, has `label`, `agent`, `prompt`, optional `send`
- [ ] **Model name**: If specified, is it a valid model?
- [ ] **Body content**: Clear instructions and persona?
- [ ] **Project compliance**: Follows `.github/instructions/agents.instructions.md`?

#### For Prompt Files (`.prompt.md`)
Validate:
- [ ] **File location**: Is it in `.github/prompts/`?
- [ ] **File extension**: Is it `.prompt.md`?
- [ ] **YAML frontmatter**: Present and properly formatted?
- [ ] **Required fields**: `description` is present
- [ ] **Optional fields**: Check `agent`, `tools`
- [ ] **Agent reference**: If present, does the agent exist?
- [ ] **Tool names**: If specified, are they valid?
- [ ] **Body content**: Clear, actionable instructions?
- [ ] **Project compliance**: Follows `.github/instructions/prompts.instructions.md`?

### Step 5: Report Findings

Provide a validation report with:

**✅ Valid Items**
- List what's correct

**⚠️ Warnings**
- Optional improvements
- Best practice suggestions
- Examples from Awesome Copilot

**❌ Errors**
- Required fixes
- Syntax errors
- Invalid references

### Step 6: Offer Fixes

If errors are found:
1. Explain what's wrong and why
2. Show the correct structure from documentation
3. Offer to fix the file with #tool:editFiles

## Common Issues to Check

### YAML Frontmatter Issues
- Missing closing `---`
- Incorrect indentation
- Invalid YAML syntax (quotes, colons, lists)

### Tool Issues
- Misspelled tool names
- Deprecated tools
- Missing required tools for the task

### Handoff Issues
- Missing required fields
- Invalid agent reference
- Incorrect prompt syntax

### Content Issues
- Vague or unclear instructions
- Missing workflow steps
- No examples or context

## Example Validation Output

```markdown
## Validation Report for `agent-builder.agent.md`

✅ **Valid Structure**
- Location: `.github/agents/` ✓
- Extension: `.agent.md` ✓
- YAML frontmatter: Valid ✓
- Description: Present ✓

✅ **Fields**
- `name`: "agent-builder" ✓
- `tools`: All valid (fetch, githubRepo, search, readFile, createFile, editFiles, edit) ✓
- `model`: "Claude Sonnet 4" ✓
- `handoffs`: Valid structure with proper labels and agents ✓

✅ **Content**
- Clear persona and role definition ✓
- Detailed workflow steps ✓
- File creation guidelines ✓
- Example interactions ✓

⚠️ **Suggestions**
- Consider adding `argument-hint` to guide users on how to interact
- Could reference more specific documentation sections

**Overall**: Valid and ready to use!
```

## Remember
- Be thorough but constructive
- Explain why things matter
- Offer to fix issues immediately
