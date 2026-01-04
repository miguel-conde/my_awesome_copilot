#!/bin/bash

# Asset Detection Engine for Copilot Customizations
# Usage: ./detect-assets.sh <repo_url> [path] [technology_filter]
# Returns: JSON array of discovered assets with metadata

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_DIR="/tmp/asset-detection-$(date +%s)"
OUTPUT_FORMAT="${OUTPUT_FORMAT:-json}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[DETECT]${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1" >&2; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Detect asset type from file path
detect_asset_type() {
    local file_path="$1"
    case "$file_path" in
        *.agent.md) echo "agent" ;;
        *.prompt.md) echo "prompt" ;;
        *.instructions.md) echo "instruction" ;;
        *.collection.yml) echo "collection" ;;
        */SKILL.md) echo "skill" ;;
        *) echo "unknown" ;;
    esac
}

# Extract frontmatter from markdown file
parse_frontmatter() {
    local file_path="$1"
    local content
    
    if [[ -f "$file_path" ]]; then
        # Extract YAML frontmatter between --- markers
        content=$(sed -n '/^---$/,/^---$/p' "$file_path" | sed '1d;$d')
        echo "$content"
    fi
}

# Extract specific field from frontmatter
get_frontmatter_field() {
    local frontmatter="$1"
    local field="$2"
    
    echo "$frontmatter" | grep "^${field}:" | sed "s/^${field}:\s*//" | sed 's/^["'"'"']//' | sed 's/["'"'"']$//'
}

# Analyze project technologies from current directory
detect_project_technologies() {
    local technologies=()
    
    # Check for common files and patterns
    [[ -f "package.json" ]] && technologies+=("javascript" "nodejs")
    [[ -f "requirements.txt" ]] && technologies+=("python")
    [[ -f "Cargo.toml" ]] && technologies+=("rust")
    [[ -f "go.mod" ]] && technologies+=("go")
    [[ -f "pom.xml" ]] && technologies+=("java")
    [[ -f "Dockerfile" ]] && technologies+=("docker")
    [[ -f ".terraform" ]] && technologies+=("terraform")
    
    # Check package.json for frameworks
    if [[ -f "package.json" ]]; then
        if grep -q "react" package.json; then technologies+=("react"); fi
        if grep -q "vue" package.json; then technologies+=("vue"); fi
        if grep -q "angular" package.json; then technologies+=("angular"); fi
        if grep -q "next" package.json; then technologies+=("nextjs"); fi
    fi
    
    # Check Python imports
    if [[ -f "requirements.txt" ]]; then
        if grep -q "django" requirements.txt; then technologies+=("django"); fi
        if grep -q "flask" requirements.txt; then technologies+=("flask"); fi
        if grep -q "fastapi" requirements.txt; then technologies+=("fastapi"); fi
    fi
    
    printf "%s\n" "${technologies[@]}" | sort -u
}

# Calculate relevance score for asset
calculate_relevance_score() {
    local asset_path="$1"
    local asset_type="$2"
    local description="$3"
    local tags="$4"
    local project_techs="$5"
    local score=0
    
    # Base score by asset type preference
    case "$asset_type" in
        "collection") score=$((score + 10)) ;;
        "agent") score=$((score + 8)) ;;
        "prompt") score=$((score + 6)) ;;
        "instruction") score=$((score + 4)) ;;
        "skill") score=$((score + 12)) ;;
    esac
    
    # Technology matching
    while IFS= read -r tech; do
        [[ -n "$tech" ]] || continue
        if echo "$description $tags" | grep -qi "$tech"; then
            score=$((score + 15))
        fi
    done <<< "$project_techs"
    
    # Quality indicators
    [[ ${#description} -gt 50 ]] && score=$((score + 2))
    [[ -n "$tags" ]] && score=$((score + 3))
    
    echo "$score"
}

# Scan repository for assets
scan_repository() {
    local repo_url="$1"
    local scan_path="${2:-.}"
    local tech_filter="$3"
    local project_techs
    
    log_info "Scanning repository: $repo_url"
    
    # Get project technologies if not filtered
    if [[ -z "$tech_filter" ]]; then
        project_techs=$(detect_project_technologies)
        log_info "Detected project technologies: $(echo "$project_techs" | tr '\n' ' ')"
    else
        project_techs="$tech_filter"
        log_info "Using technology filter: $tech_filter"
    fi
    
    # Clone repository
    mkdir -p "$TEMP_DIR"
    if ! git clone --depth 1 "$repo_url" "$TEMP_DIR/repo" 2>/dev/null; then
        log_error "Failed to clone repository: $repo_url"
        exit 1
    fi
    
    cd "$TEMP_DIR/repo"
    
    # Find all potential assets
    local assets=()
    while IFS= read -r -d '' file; do
        local rel_path="${file#./}"
        local asset_type
        asset_type=$(detect_asset_type "$rel_path")
        
        [[ "$asset_type" != "unknown" ]] || continue
        
        local frontmatter description name tags score
        frontmatter=$(parse_frontmatter "$file")
        description=$(get_frontmatter_field "$frontmatter" "description")
        name=$(get_frontmatter_field "$frontmatter" "name")
        tags=$(get_frontmatter_field "$frontmatter" "tags")
        
        # Skip if no description
        [[ -n "$description" ]] || continue
        
        # Calculate relevance score
        score=$(calculate_relevance_score "$rel_path" "$asset_type" "$description" "$tags" "$project_techs")
        
        # Create asset record
        local asset_record
        asset_record=$(cat <<EOF
{
  "path": "$rel_path",
  "type": "$asset_type",
  "name": "${name:-$(basename "$rel_path" .${asset_type}.md)}",
  "description": "$description",
  "tags": "$tags",
  "score": $score,
  "size": $(wc -l < "$file")
}
EOF
        )
        assets+=("$asset_record")
        
    done < <(find "$scan_path" -name "*.agent.md" -o -name "*.prompt.md" -o -name "*.instructions.md" -o -name "*.collection.yml" -o -name "SKILL.md" -print0)
    
    # Output results
    if [[ "$OUTPUT_FORMAT" == "json" ]]; then
        echo "["
        local first=true
        for asset in "${assets[@]}"; do
            [[ "$first" == "true" ]] && first=false || echo ","
            echo "$asset"
        done
        echo "]"
    else
        # Human-readable format
        echo "Found ${#assets[@]} assets:"
        for asset in "${assets[@]}"; do
            local path type description score
            path=$(echo "$asset" | grep -o '"path": "[^"]*"' | cut -d'"' -f4)
            type=$(echo "$asset" | grep -o '"type": "[^"]*"' | cut -d'"' -f4)
            description=$(echo "$asset" | grep -o '"description": "[^"]*"' | cut -d'"' -f4)
            score=$(echo "$asset" | grep -o '"score": [0-9]*' | cut -d' ' -f2)
            
            printf "  %-8s %-40s (score: %2d) %s\n" "[$type]" "$path" "$score" "$description"
        done
    fi
    
    # Cleanup
    cd - >/dev/null
    rm -rf "$TEMP_DIR"
}

# Generate installation suggestions
generate_suggestions() {
    local assets_json="$1"
    local min_score="${2:-10}"
    
    log_info "Generating installation suggestions (min score: $min_score)"
    
    # Sort by score and filter
    echo "$assets_json" | jq -r --arg min_score "$min_score" '
        map(select(.score >= ($min_score | tonumber)))
        | sort_by(-.score)
        | .[]
        | "SUGGESTED: " + .type + " " + .path + " (score: " + (.score | tostring) + ") - " + .description'
}

# Main function
main() {
    local repo_url="$1"
    local scan_path="$2"
    local tech_filter="$3"
    
    if [[ -z "$repo_url" ]]; then
        echo "Usage: $0 <repo_url> [path] [technology_filter]"
        echo ""
        echo "Examples:"
        echo "  $0 https://github.com/github/awesome-copilot"
        echo "  $0 github/awesome-copilot agents python"
        echo "  $0 myorg/custom-tools . react"
        exit 1
    fi
    
    # Convert owner/repo format to full URL
    if [[ "$repo_url" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+$ ]]; then
        repo_url="https://github.com/$repo_url"
    fi
    
    local results
    results=$(scan_repository "$repo_url" "$scan_path" "$tech_filter")
    
    if [[ "$OUTPUT_FORMAT" == "json" ]]; then
        echo "$results"
    else
        echo "$results"
        echo ""
        generate_suggestions "$results" 10
    fi
}

# Execute if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi