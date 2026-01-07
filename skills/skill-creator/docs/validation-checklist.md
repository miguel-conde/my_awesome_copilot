# Agent Skill Quality Validation Checklist

Use this checklist to ensure your Agent Skill meets the open standard and Agent Builder Framework requirements.

## ✅ YAML Frontmatter Validation

### Required Fields
- [ ] `name` field is present and follows lowercase-with-hyphens format
- [ ] `name` is unique and descriptive (maximum 64 characters)
- [ ] `description` field is present and specific (maximum 1024 characters)
- [ ] `description` includes both WHAT the skill does AND WHEN to use it

### Format Validation
- [ ] YAML frontmatter is properly formatted (starts and ends with `---`)
- [ ] No syntax errors in YAML structure
- [ ] All values are properly quoted if they contain special characters

### Content Quality
- [ ] Name clearly identifies the skill's purpose (e.g., `python-testing`, not `helper`)
- [ ] Description is specific enough for Copilot to decide when to load the skill
- [ ] Description avoids generic terms like "helps with" or "assists in"

## 📝 Instructions Content Validation

### Structure Requirements
- [ ] Clear "When to Use This Skill" section
- [ ] Step-by-step procedures are included
- [ ] Input/output examples are provided
- [ ] Resource references use relative paths

### Content Quality
- [ ] Instructions are actionable and specific
- [ ] Examples are relevant and comprehensive
- [ ] Language is clear and imperative ("Create a file", not "You should create")
- [ ] All procedures include expected outcomes

### Integration Standards
- [ ] Content follows project-agnostic design principles
- [ ] No hardcoded paths, tool names, or project-specific assumptions
- [ ] Aligns with Agent Builder Framework methodology
- [ ] References existing framework assets appropriately

## 📁 File Structure Validation

### Directory Organization
- [ ] Skill is located in `.github/skills/{skill-name}/` directory
- [ ] Main `SKILL.md` file is present
- [ ] Subdirectories follow standard structure (`templates/`, `scripts/`, `examples/`, `docs/`)

### Resource Management
- [ ] All bundled resources are in appropriate subdirectories
- [ ] Resource file names are descriptive and follow naming conventions
- [ ] No unused or orphaned files in skill directory

### Path References
- [ ] All resource references in SKILL.md use relative paths
- [ ] Resource links are properly formatted: `[description](./path/to/file.ext)`
- [ ] All referenced files actually exist

## 🎯 Progressive Loading Validation

### Level 1: Discovery
- [ ] Skill name and description enable accurate discovery
- [ ] Description helps Copilot determine relevance to user requests
- [ ] Skill doesn't have overly broad or narrow trigger conditions

### Level 2: Instructions Loading
- [ ] SKILL.md content is comprehensive and self-contained
- [ ] Instructions provide complete workflow without requiring external resources
- [ ] Content is appropriately sized (not too long, not too brief)

### Level 3: Resource Access
- [ ] Bundled resources are referenced appropriately in instructions
- [ ] Resources enhance but don't replace clear instructions
- [ ] Resource access is on-demand based on instruction content

## 🔧 Technical Validation

### Script Files (if applicable)
- [ ] Scripts have proper executable permissions (`chmod +x`)
- [ ] Scripts include appropriate shebang lines (`#!/bin/bash`, `#!/usr/bin/env python3`)
- [ ] Scripts include usage instructions and error handling
- [ ] Scripts follow security best practices

### Template Files (if applicable)
- [ ] Templates use clear placeholder syntax (e.g., `{{VARIABLE_NAME}}`)
- [ ] Template instructions are included
- [ ] Templates are well-documented and easy to customize

### Documentation Files (if applicable)
- [ ] Additional documentation enhances rather than duplicates SKILL.md
- [ ] Documentation is properly structured and formatted
- [ ] All links and references are valid

## 🧪 Functional Testing

### Skill Discovery Testing
- [ ] Create prompts that should trigger this skill
- [ ] Verify Copilot loads the skill for relevant requests
- [ ] Confirm skill doesn't load for irrelevant requests

### Resource Access Testing
- [ ] Test all relative path references
- [ ] Verify bundled resources are accessible when referenced
- [ ] Confirm resource content is appropriate and useful

### Integration Testing
- [ ] Test skill in different project contexts
- [ ] Verify project-agnostic design works across technology stacks
- [ ] Confirm integration with other Agent Builder Framework assets

## 📋 Agent Builder Framework Compliance

### Design Principles
- [ ] Skill follows project-agnostic methodology
- [ ] Content focuses on reusable workflows and patterns
- [ ] Skill enhances rather than duplicates existing framework assets

### Educational Value
- [ ] Skill teaches concepts while providing tools
- [ ] Instructions explain the "why" behind procedures
- [ ] Content promotes learning and understanding

### Framework Integration
- [ ] Skill references appropriate framework documentation
- [ ] Naming and terminology are consistent with framework conventions
- [ ] Skill complements existing agents, prompts, and instructions

## 🎉 Final Validation

### Pre-Release Checklist
- [ ] All validation items above are completed
- [ ] Skill has been tested in realistic scenarios
- [ ] Documentation is complete and accurate
- [ ] No security or privacy concerns identified

### Quality Assurance
- [ ] Skill provides clear value over existing solutions
- [ ] Implementation follows open standards (agentskills.io)
- [ ] Code and content meet professional quality standards
- [ ] Skill is ready for production use

---

**Note**: Complete this checklist before considering any Agent Skill ready for use. Each item represents a critical quality standard that ensures the skill will work effectively within the Agent Builder Framework and VSCode Copilot ecosystem.