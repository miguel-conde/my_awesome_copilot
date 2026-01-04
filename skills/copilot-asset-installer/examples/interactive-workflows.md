# Interactive Workflows and Advanced Features

This example demonstrates interactive discovery and advanced workflow capabilities.

## Scenario 1: Interactive Recommendation Wizard
You want a guided experience to discover relevant assets.

### User Input
```
"Start an interactive session to discover copilot assets for my project"
```

### Skill Response
```bash
./scripts/discover-assets.sh interactive
```

### What Happens
1. **Project Analysis**: Automatically detects languages, frameworks, tools
2. **Technology Confirmation**: Asks user to confirm or add technologies
3. **Use Case Selection**: Prompts for development focus areas (testing, deployment, etc.)
4. **Repository Selection**: Offers multiple asset sources
5. **Asset Recommendations**: Provides ranked suggestions with explanations
6. **Installation Options**: Offers bulk installation or selective picking

### Expected Outcome
- Guided discovery experience
- Personalized recommendations
- Bulk installation options
- Learning about asset purposes

## Scenario 2: Smart Project Analysis
You want detailed analysis of your current project for recommendations.

### User Input
```
"Analyze my project structure and recommend specific copilot assets"
```

### Skill Response
```bash
./scripts/discover-assets.sh smart
```

### What Happens
1. **Deep Project Scan**: 
   - Analyzes `package.json`, `requirements.txt`, `Cargo.toml`, etc.
   - Detects frameworks (React, Django, Express, etc.)
   - Identifies development patterns (testing, CI/CD, deployment)
   - Checks existing copilot setup

2. **Technology Fingerprinting**:
   - Creates project technology profile
   - Assigns confidence scores to detected technologies
   - Maps to asset compatibility matrix

3. **Context-Aware Suggestions**:
   - Recommends based on project complexity
   - Suggests learning vs production-ready assets
   - Prioritizes by team size and experience level

### Expected Outcome
- Detailed project technology profile
- Highly relevant asset suggestions
- Explanation of why each asset is recommended
- Installation priority ranking

## Scenario 3: Environment Variable Configuration
You want to set up custom repository defaults and preferences.

### User Input
```
"Configure custom repository defaults for my team's copilot assets"
```

### Skill Response
```bash
# Set custom default repository
export COPILOT_ASSETS_REPO="mycompany/copilot-standards"

# Discover from company repo
./scripts/deploy-unified.sh detect

# Compare with community assets
./scripts/deploy-unified.sh detect github/awesome-copilot
```

### What Happens
1. Configures custom repository as default source
2. Maintains access to community repositories
3. Prioritizes company-specific assets in recommendations
4. Enables team-wide standardization

### Expected Outcome
- Team-consistent asset management
- Company standards integrated with community assets
- Streamlined onboarding for new team members
