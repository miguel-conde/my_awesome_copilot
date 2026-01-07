---
name: {{SKILL_NAME}}
description: {{SKILL_DESCRIPTION}} Use when {{USE_CASES}}.
---

# {{SKILL_TITLE}}

{{BRIEF_OVERVIEW}}

## When to Use This Skill

{{SPECIFIC_SCENARIOS}}

## {{MAIN_WORKFLOW_TITLE}}

### Step 1: {{STEP_1_TITLE}}

{{STEP_1_INSTRUCTIONS}}

### Step 2: {{STEP_2_TITLE}}

{{STEP_2_INSTRUCTIONS}}

### Step 3: {{STEP_3_TITLE}}

{{STEP_3_INSTRUCTIONS}}

## Examples

### {{EXAMPLE_1_TITLE}}
{{EXAMPLE_1_CONTENT}}

### {{EXAMPLE_2_TITLE}}
{{EXAMPLE_2_CONTENT}}

## Resource References

{{RESOURCE_LINKS}}

## Integration Notes

{{FRAMEWORK_INTEGRATION_GUIDANCE}}

---

## Template Instructions

**Required Replacements:**
- `{{SKILL_NAME}}`: Lowercase-with-hyphens identifier (max 64 chars)
- `{{SKILL_DESCRIPTION}}`: Specific capabilities description (max 1024 chars)
- `{{USE_CASES}}`: Specific scenarios when Copilot should load this skill
- `{{SKILL_TITLE}}`: Human-readable title for the skill
- `{{BRIEF_OVERVIEW}}`: Short explanation of what the skill accomplishes

**Content Sections:**
- Replace all `{{STEP_*}}` placeholders with actual workflow steps
- Add specific examples relevant to your skill's purpose
- Include resource references using relative paths: `[resource name](./resource-file.ext)`
- Provide framework integration guidance for project-agnostic usage

**Quality Checklist:**
- [ ] YAML frontmatter includes required name and description
- [ ] Name follows lowercase-with-hyphens convention
- [ ] Description is specific about capabilities AND use cases
- [ ] All placeholders have been replaced with actual content
- [ ] Resource references use relative paths
- [ ] Content follows project-agnostic design principles