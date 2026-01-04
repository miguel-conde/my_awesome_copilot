# Smart Project Recommendations

This example shows how the skill provides intelligent recommendations based on project analysis.

## Scenario
You're starting a new FastAPI Python project and want personalized asset recommendations.

## User Input
```
"Get personalized suggestions for this Python FastAPI project"
```

## Skill Response
The skill analyzes your project and provides:

### Detected Technologies
- Python 3.11
- FastAPI framework
- SQLAlchemy ORM
- Pytest testing
- Docker deployment

### Recommended Assets

**High Priority (95% match)**
- `agents/python-api-expert.agent.md` - Specialized for API development
- `prompts/fastapi-testing.prompt.md` - Generate FastAPI tests
- `instructions/python-api-standards.instructions.md` - API coding guidelines

**Medium Priority (80% match)**
- `agents/docker-deployment.agent.md` - Container deployment assistance
- `prompts/api-documentation.prompt.md` - Generate OpenAPI docs

**Collections Available**
- `collections/python-web-development.collection.yml` - Complete web dev setup
- `collections/api-testing-suite.collection.yml` - Testing focused collection

## Expected Outcome
- Tailored recommendations based on actual project needs
- Compatibility scoring helps prioritize installations
- Option to install individual assets or complete collections
- Project-specific setup guidance
