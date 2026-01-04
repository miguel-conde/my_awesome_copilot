# Asset Detection and Analysis

This example shows advanced asset detection capabilities across repositories.

## Scenario 1: Detect All Assets in Repository
You want to discover all available assets in a repository.

### User Input
```
"Detect all copilot assets in the awesome-copilot repository"
```

### Skill Response
```bash
./scripts/deploy-unified.sh detect github/awesome-copilot
```

### What Happens
1. Clones or fetches repository
2. Scans for `.agent.md`, `.prompt.md`, `.instructions.md`, `.collection.yml`, `SKILL.md` files
3. Parses frontmatter to extract metadata
4. Returns JSON with asset details and compatibility scores

### Expected Outcome
- Complete inventory of available assets
- Metadata including descriptions, tools, models
- Compatibility assessment for current project

## Scenario 2: Technology-Filtered Detection
You want to find Python-specific assets across repositories.

### User Input
```
"Find all Python-related copilot assets from multiple repositories"
```

### Skill Response
```bash
./scripts/deploy-unified.sh detect github/awesome-copilot "" python
./scripts/detect-assets.sh myorg/python-tools "" python
```

### What Happens
1. Searches specified repositories
2. Filters assets by technology keywords in descriptions
3. Analyzes compatibility with detected Python frameworks
4. Ranks results by relevance score

### Expected Outcome
- Python-focused asset recommendations
- Framework-specific matches (Django, FastAPI, Flask)
- Cross-repository comparison

## Scenario 3: Path-Specific Detection
You want to explore assets in a specific subdirectory.

### User Input
```
"Detect assets in the collections directory of awesome-copilot"
```

### Skill Response
```bash
./scripts/deploy-unified.sh detect github/awesome-copilot collections
```

### What Happens
1. Focuses scan on `collections/` subdirectory
2. Discovers collection files and their contents
3. Analyzes collection dependencies
4. Shows what would be installed with each collection

### Expected Outcome
- Targeted discovery results
- Collection contents preview
- Dependency analysis
