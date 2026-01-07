---
agent: agent-builder
name: validate-definition
description: Validate agent, prompt, instructions, or skill file structure against official documentation
---

Validate an agent definition (`.agent.md`), prompt file (`.prompt.md`), instructions file (`.instructions.md`), or Agent Skill (`SKILL.md`) against official VSCode documentation and project guidelines.

## Validation Process

### Step 1: Identify File Type
Ask the user which file to validate, or use #tool:search to find recent agent/prompt/instructions/skill files in the workspace.

File types supported:
- `.agent.md` - Custom agent definitions
- `.prompt.md` - Prompt files  
- `.instructions.md` - Instructions files
- `SKILL.md` - Agent Skills (in `.github/skills/*/` directories)

### Step 2: Read the File
Use #tool:readFile to load the file content.

### Step 3: Fetch Official Documentation
- For `.agent.md`: Fetch [Custom Agents documentation](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- For `.prompt.md`: Fetch [Prompt Files documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- For `.instructions.md`: Fetch [Custom Instructions documentation](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- For `SKILL.md`: Fetch [Agent Skills documentation](https://code.visualstudio.com/docs/copilot/customization/agent-skills)

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

#### For Instructions Files (`.instructions.md`)
Validate:
- [ ] **File location**: Typically in `.github/instructions/` or other directories
- [ ] **File extension**: Is it `.instructions.md`?
- [ ] **YAML frontmatter**: Present and properly formatted?
- [ ] **Required fields**: `description` and `applyTo` are present
- [ ] **ApplyTo pattern**: Valid glob pattern (e.g., `**/*.py`, `src/**`)
- [ ] **Description**: Clear explanation of what the instructions cover
- [ ] **Body content**: Concise, actionable guidelines?
- [ ] **Project compliance**: Follows `.github/instructions/instructions.instructions.md`?

#### For Agent Skills (`SKILL.md`)
Validate:
- [ ] **File location**: Is it in `.github/skills/{skill-name}/SKILL.md`?
- [ ] **File name**: Is it exactly `SKILL.md`?
- [ ] **YAML frontmatter**: Present and properly formatted?
- [ ] **Required fields**: `name` and `description` are present
- [ ] **Name field**: Lowercase with hyphens, max 64 characters, unique identifier?
- [ ] **Description field**: Specific about capabilities AND use cases, max 1024 characters?
- [ ] **Directory name**: Does `.github/skills/{skill-name}/` match the skill name?
- [ ] **Body content**: Clear instructions describing what, when, and how?
- [ ] **Resource references**: Do relative path references to bundled resources work?
- [ ] **Progressive loading design**: Follows three-level loading principles?
- [ ] **Project compliance**: Follows `.github/instructions/skills.instructions.md`?
- [ ] **Bundled resources**: If present, are they properly organized and referenced?

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

### Skills-Specific Issues
- Invalid skill name format (not lowercase with hyphens)
- Description too generic (doesn't specify capabilities AND use cases)
- Missing progressive loading design
- Broken relative path references to bundled resources
- Directory name doesn't match skill name

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

### Skills Validation Example

```markdown
## Validation Report for `skill-creator/SKILL.md`

✅ **Valid Structure**
- Location: `.github/skills/skill-creator/SKILL.md` ✓
- File name: `SKILL.md` ✓
- YAML frontmatter: Valid ✓

✅ **Required Fields**
- Name: "skill-creator" (valid format, 12 chars) ✓
- Description: Specific about capabilities and use cases (158 chars) ✓

✅ **Progressive Loading Design**
- Level 1: Name and description optimize discovery ✓
- Level 2: Clear step-by-step instructions in body ✓
- Level 3: Proper relative path references to bundled resources ✓

✅ **Bundled Resources**
- Templates directory: Referenced correctly ✓
- Scripts directory: Referenced correctly ✓
- Examples directory: Referenced correctly ✓
- All relative paths: Working ✓

⚠️ **Suggestions**
- Could add more specific examples for different skill complexity levels
- Consider referencing the validation checklist for self-checking

**Overall**: Excellent Agent Skill following the open standard!
```

## Remember
- Be thorough but constructive
- Explain why things matter
- Offer to fix issues immediately
