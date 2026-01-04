---
description: Automatically includes user memory file in chat prompts to enable persistent information storage and retrieval across conversations
applyTo: '**'
---

# Memory Integration Instructions

When responding to user requests, you have access to a persistent memory system that stores important information across conversations. Always reference the user's memory file to:

1. **Check for relevant stored information** before providing answers
2. **Use stored preferences** to personalize responses  
3. **Recall previous context** when users reference past conversations
4. **Suggest storing new information** when users share important details

## Memory File Reference

The user's memory file is available at: [memory/user_memory.json](../../memory/user_memory.json)

This file contains:
- User preferences and settings
- Important notes and reminders
- Project-specific information
- Previous conversation context
- Personal details the user has chosen to store

## Memory Operations

When appropriate, you should:
- **Search** the memory file for relevant information when answering questions
- **Suggest storing** new information that might be useful for future conversations
- **Use stored preferences** to tailor responses (e.g., preferred programming languages, explanation styles)
- **Reference previous context** when users ask follow-up questions

## Guidelines

- Always respect user privacy - only store information they explicitly ask to save
- Use stored information to provide more personalized and contextual responses
- Suggest cleanup or updates when memory information becomes outdated
- Clearly indicate when responses are based on stored memory vs. general knowledge