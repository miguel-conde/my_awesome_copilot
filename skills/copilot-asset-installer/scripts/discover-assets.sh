#!/bin/bash

# Discovery Engine for VSCode Copilot Assets
# Provides intelligent recommendations based on project analysis

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_DIR="$HOME/.copilot-discovery-cache"
CACHE_TTL=3600  # 1 hour

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[DISCOVERY]${NC} $1" >&2; }

# Analyze project structure and patterns
analyze_project() {
    local project_dir="${1:-.}"
    local analysis_file="$CACHE_DIR/project-analysis-$(pwd | sed 's|/|_|g').json"
    
    # Check cache
    if [[ -f "$analysis_file" ]] && [[ $(($(date +%s) - $(date -r "$analysis_file" +%s 2>/dev/null || echo 0))) -lt $CACHE_TTL ]]; then
        cat "$analysis_file"
        return
    fi
    
    log_info "Analyzing project structure..."
    mkdir -p "$CACHE_DIR"
    
    local analysis='{}'
    
    # Detect programming languages
    local languages=()
    [[ $(find "$project_dir" -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o -name "*.tsx" | head -1) ]] && languages+=("javascript")
    [[ $(find "$project_dir" -name "*.py" | head -1) ]] && languages+=("python")
    [[ $(find "$project_dir" -name "*.rs" | head -1) ]] && languages+=("rust")
    [[ $(find "$project_dir" -name "*.go" | head -1) ]] && languages+=("go")
    [[ $(find "$project_dir" -name "*.java" | head -1) ]] && languages+=("java")
    [[ $(find "$project_dir" -name "*.cpp" -o -name "*.c" -o -name "*.h" | head -1) ]] && languages+=("cpp")
    [[ $(find "$project_dir" -name "*.rb" | head -1) ]] && languages+=("ruby")
    [[ $(find "$project_dir" -name "*.php" | head -1) ]] && languages+=("php")
    
    # Detect frameworks
    local frameworks=()
    if [[ -f "$project_dir/package.json" ]]; then
        if grep -q "react" "$project_dir/package.json"; then frameworks+=("react"); fi
        if grep -q "vue" "$project_dir/package.json"; then frameworks+=("vue"); fi
        if grep -q "@angular" "$project_dir/package.json"; then frameworks+=("angular"); fi
        if grep -q "next" "$project_dir/package.json"; then frameworks+=("nextjs"); fi
        if grep -q "express" "$project_dir/package.json"; then frameworks+=("express"); fi
        if grep -q "nestjs" "$project_dir/package.json"; then frameworks+=("nestjs"); fi
    fi
    
    if [[ -f "$project_dir/requirements.txt" ]] || [[ -f "$project_dir/pyproject.toml" ]]; then
        if grep -q "django" "$project_dir/requirements.txt" "$project_dir/pyproject.toml" 2>/dev/null; then frameworks+=("django"); fi
        if grep -q "flask" "$project_dir/requirements.txt" "$project_dir/pyproject.toml" 2>/dev/null; then frameworks+=("flask"); fi
        if grep -q "fastapi" "$project_dir/requirements.txt" "$project_dir/pyproject.toml" 2>/dev/null; then frameworks+=("fastapi"); fi
    fi
    
    # Detect project type
    local project_types=()
    [[ -d "$project_dir/test" ]] || [[ -d "$project_dir/tests" ]] && project_types+=("testing")
    [[ -f "$project_dir/Dockerfile" ]] && project_types+=("containerized")
    [[ -f "$project_dir/.github/workflows" ]] || [[ -d "$project_dir/.github/workflows" ]] && project_types+=("ci-cd")
    [[ -d "$project_dir/docs" ]] || [[ -f "$project_dir/README.md" ]] && project_types+=("documented")
    [[ $(find "$project_dir" -name "*.md" | wc -l) -gt 3 ]] && project_types+=("documentation-heavy")
    
    # Detect development patterns
    local patterns=()
    [[ -f "$project_dir/.eslintrc"* ]] && patterns+=("linting")
    [[ -f "$project_dir/.prettierrc"* ]] && patterns+=("formatting")
    [[ -f "$project_dir/jest.config"* ]] && patterns+=("unit-testing")
    [[ -f "$project_dir/cypress.config"* ]] && patterns+=("e2e-testing")
    [[ -d "$project_dir/.vscode" ]] && patterns+=("vscode-configured")
    
    # Build analysis object
    analysis=$(cat <<EOF
{
  "languages": [$(printf '"%s",' "${languages[@]}" | sed 's/,$//')],
  "frameworks": [$(printf '"%s",' "${frameworks[@]}" | sed 's/,$//')],
  "project_types": [$(printf '"%s",' "${project_types[@]}" | sed 's/,$//')],
  "patterns": [$(printf '"%s",' "${patterns[@]}" | sed 's/,$//')],
  "file_count": $(find "$project_dir" -type f | wc -l),
  "has_tests": $(if [[ -d "$project_dir/test" ]] || [[ -d "$project_dir/tests" ]]; then echo "true"; else echo "false"; fi),
  "has_docs": $(if [[ -d "$project_dir/docs" ]]; then echo "true"; else echo "false"; fi),
  "git_repo": $(if [[ -d "$project_dir/.git" ]]; then echo "true"; else echo "false"; fi),
  "analyzed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
    )
    
    echo "$analysis" > "$analysis_file"
    echo "$analysis"
}

# Generate recommendations based on project analysis
generate_recommendations() {
    local analysis="$1"
    local repo="${2:-github/awesome-copilot}"
    
    log_info "Generating recommendations..."
    
    # Extract project characteristics
    local languages frameworks project_types patterns
    languages=$(echo "$analysis" | jq -r '.languages[]' | tr '\n' ' ')
    frameworks=$(echo "$analysis" | jq -r '.frameworks[]' | tr '\n' ' ')
    project_types=$(echo "$analysis" | jq -r '.project_types[]' | tr '\n' ' ')
    patterns=$(echo "$analysis" | jq -r '.patterns[]' | tr '\n' ' ')
    
    local has_tests has_docs
    has_tests=$(echo "$analysis" | jq -r '.has_tests')
    has_docs=$(echo "$analysis" | jq -r '.has_docs')
    
    # Priority recommendations based on analysis
    local recommendations=()
    
    # Core development recommendations
    if [[ "$languages" =~ python ]]; then
        recommendations+=("agents/python-expert.agent.md:High priority - Python development specialist")
        recommendations+=("prompts/python-testing.prompt.md:Testing support for Python projects")
    fi
    
    if [[ "$languages" =~ javascript ]]; then
        recommendations+=("agents/frontend-specialist.agent.md:Essential for JavaScript/TypeScript development")
        recommendations+=("prompts/js-debugging.prompt.md:Debug JavaScript issues effectively")
    fi
    
    if [[ "$frameworks" =~ react ]]; then
        recommendations+=("collections/react-toolkit.collection.yml:Complete React development suite")
        recommendations+=("agents/react-expert.agent.md:React-specific development assistance")
    fi
    
    # Testing recommendations
    if [[ "$has_tests" == "true" ]]; then
        recommendations+=("agents/test-writer.agent.md:Enhanced testing capabilities")
        recommendations+=("prompts/tdd-workflow.prompt.md:Test-driven development guidance")
    else
        recommendations+=("prompts/add-testing.prompt.md:Critical - Add testing to your project")
        recommendations+=("instructions/testing-standards.instructions.md:Establish testing standards")
    fi
    
    # Documentation recommendations  
    if [[ "$has_docs" == "true" ]]; then
        recommendations+=("agents/documentation-specialist.agent.md:Improve documentation quality")
    else
        recommendations+=("prompts/create-docs.prompt.md:Important - Add project documentation")
    fi
    
    # Pattern-based recommendations
    if [[ "$patterns" =~ linting ]]; then
        recommendations+=("instructions/code-quality.instructions.md:Enhance code quality standards")
    fi
    
    if [[ "$project_types" =~ ci-cd ]]; then
        recommendations+=("agents/devops-specialist.agent.md:CI/CD and deployment assistance")
    fi
    
    # Output recommendations
    printf '%s\n' "${recommendations[@]}" | while IFS=':' read -r asset_path description; do
        echo "RECOMMEND: $asset_path"
        echo "  Reason: $description"
        echo ""
    done
}

# Smart discovery workflow
smart_discover() {
    local repo="${1:-github/awesome-copilot}"
    local project_dir="${2:-.}"
    
    echo -e "${CYAN}Smart Discovery Engine${NC}"
    echo ""
    
    # Analyze current project
    local analysis
    analysis=$(analyze_project "$project_dir")
    
    # Show project summary
    echo "Project Analysis:"
    echo "  Languages: ${languages[*]}"
    echo "  Frameworks: ${frameworks[*]}" 
    echo "  Types: ${project_types[*]}"
    echo "  Patterns: ${patterns[*]}"
    echo "  Has Tests: $has_tests"
    echo "  Has Docs: $has_docs"
    echo ""
    
    # Generate and display recommendations
    generate_recommendations "$analysis" "$repo"
    
    # Get asset compatibility scores
    log_info "Fetching available assets with compatibility scores..."
    
    # Use detect-assets.sh with technology filter
    local tech_filter
    tech_filter=$(echo "$analysis" | jq -r '[.languages[], .frameworks[]] | join("|")')
    
    if [[ -n "$tech_filter" && "$tech_filter" != "" ]]; then
        OUTPUT_FORMAT=json "$SCRIPT_DIR/detect-assets.sh" "$repo" "." "$tech_filter" | \
        jq -r --arg min_score "12" '
            map(select(.score >= ($min_score | tonumber)))
            | sort_by(-.score)
            | .[:15]
            | .[]
            | "COMPATIBLE: \(.type) \(.path) (score: \(.score))"'
    fi
}

# Interactive recommendation mode
interactive_recommend() {
    local repo="${1:-github/awesome-copilot}"
    
    echo -e "${CYAN}Interactive Asset Recommendation${NC}"
    echo ""
    
    # Ask about project characteristics
    echo "Let's analyze your project needs..."
    echo ""
    
    read -p "Primary programming language: " primary_lang
    read -p "Framework (if any): " framework
    read -p "Project type (web app, api, cli, library): " project_type
    read -p "Team size (1-3, 4-10, 10+): " team_size
    read -p "Experience level (beginner, intermediate, expert): " experience
    
    # Generate targeted recommendations
    echo ""
    echo "Recommendations based on your answers:"
    echo ""
    
    case "$primary_lang" in
        python|py)
            echo "RECOMMEND: agents/python-expert.agent.md - Python specialist agent"
            echo "RECOMMEND: prompts/python-debugging.prompt.md - Debug Python code"
            ;;
        javascript|js|typescript|ts)
            echo "RECOMMEND: agents/frontend-specialist.agent.md - Frontend development"
            echo "RECOMMEND: prompts/js-optimization.prompt.md - Optimize JavaScript"
            ;;
    esac
    
    case "$experience" in
        beginner)
            echo "RECOMMEND: agents/mentor.agent.md - Learning and mentorship"
            echo "RECOMMEND: prompts/explain-code.prompt.md - Code explanation"
            ;;
        expert)
            echo "RECOMMEND: agents/architect.agent.md - System design and architecture"
            echo "RECOMMEND: prompts/code-review.prompt.md - Advanced code review"
            ;;
    esac
    
    if [[ "$team_size" =~ ^(4-10|10\+)$ ]]; then
        echo "RECOMMEND: instructions/team-standards.instructions.md - Team coding standards"
        echo "RECOMMEND: collections/collaboration.collection.yml - Team collaboration tools"
    fi
}

# Main function
main() {
    local mode="${1:-smart}"
    shift
    
    case "$mode" in
        "smart")
            smart_discover "$@"
            ;;
        "interactive")
            interactive_recommend "$@"
            ;;
        "analyze")
            analyze_project "${1:-.}"
            ;;
        *)
            echo "Usage: $0 <mode> [options...]"
            echo ""
            echo "Modes:"
            echo "  smart [repo] [project_dir]  - Smart discovery based on project analysis"
            echo "  interactive [repo]          - Interactive recommendation wizard"
            echo "  analyze [project_dir]       - Just analyze project structure"
            exit 1
            ;;
    esac
}

# Execute if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi