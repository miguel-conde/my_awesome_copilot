#!/bin/bash

# Unified CLI for VSCode Copilot Asset Management
# Usage: ./deploy-unified.sh <command> [options...]
# Commands: detect, install, collections, discover, suggest

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_REPO="${COPILOT_ASSETS_REPO:-github/awesome-copilot}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[CLI]${NC} $1" >&2; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1" >&2; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Show help
show_help() {
    cat << EOF
${CYAN}VSCode Copilot Asset Manager${NC}

USAGE:
  $0 <command> [options...]

COMMANDS:
  ${GREEN}detect${NC} <repo> [path] [tech]     Detect available assets in repository
  ${GREEN}install${NC} <repo> <asset> [dir]   Install individual asset
  ${GREEN}collections${NC} <repo> <collection> Install collection and contents
  ${GREEN}discover${NC} [technologies...]     Find relevant assets for your project
  ${GREEN}suggest${NC} [min_score]           Get personalized asset recommendations
  ${GREEN}list${NC}                          List installed assets
  ${GREEN}backup${NC}                        Create backup of current setup

EXAMPLES:
  # Detect all assets
  $0 detect github/awesome-copilot

  # Install specific prompt
  $0 install github/awesome-copilot prompts/code-review.prompt.md

  # Install collection with all dependencies
  $0 collections github/awesome-copilot collections/frontend.collection.yml

  # Discover assets for Python projects
  $0 discover python fastapi

  # Get suggestions based on current project
  $0 suggest

  # List what's currently installed
  $0 list

ENVIRONMENT VARIABLES:
  COPILOT_ASSETS_REPO    Default repository (default: github/awesome-copilot)
  OUTPUT_FORMAT          Output format: json|table (default: table)

EOF
}

# Detect assets in repository
cmd_detect() {
    local repo="$1"
    local path="$2"
    local tech="$3"
    
    if [[ -z "$repo" ]]; then
        repo="$DEFAULT_REPO"
    fi
    
    log_info "Detecting assets in: $repo"
    "$SCRIPT_DIR/detect-assets.sh" "$repo" "$path" "$tech"
}

# Install individual asset
cmd_install() {
    local repo="$1"
    local asset="$2"
    local target_dir="$3"
    
    if [[ -z "$repo" || -z "$asset" ]]; then
        log_error "Usage: $0 install <repo> <asset> [target_dir]"
        exit 1
    fi
    
    "$SCRIPT_DIR/deploy-asset.sh" "$repo" "$asset" "$target_dir"
}

# Install collection
cmd_collections() {
    local repo="$1"
    local collection="$2"
    
    if [[ -z "$repo" || -z "$collection" ]]; then
        log_error "Usage: $0 collections <repo> <collection>"
        exit 1
    fi
    
    "$SCRIPT_DIR/deploy-collection.sh" "$repo" "$collection"
}

# Discover relevant assets
cmd_discover() {
    local technologies=("$@")
    local repo="${COPILOT_ASSETS_REPO:-github/awesome-copilot}"
    
    log_info "Discovering assets for technologies: ${technologies[*]}"
    
    # If no technologies specified, detect from current project
    if [[ ${#technologies[@]} -eq 0 ]]; then
        log_info "Auto-detecting project technologies..."
        
        # Basic technology detection
        local detected_techs=()
        [[ -f "package.json" ]] && detected_techs+=("javascript")
        [[ -f "requirements.txt" ]] && detected_techs+=("python")
        [[ -f "Cargo.toml" ]] && detected_techs+=("rust")
        [[ -f "go.mod" ]] && detected_techs+=("go")
        
        # Framework detection
        if [[ -f "package.json" ]]; then
            if grep -q "react" package.json; then detected_techs+=("react"); fi
            if grep -q "vue" package.json; then detected_techs+=("vue"); fi
            if grep -q "angular" package.json; then detected_techs+=("angular"); fi
        fi
        
        if [[ ${#detected_techs[@]} -eq 0 ]]; then
            log_warn "No technologies detected in current project"
            technologies=("general")
        else
            technologies=("${detected_techs[@]}")
            log_info "Detected: ${technologies[*]}"
        fi
    fi
    
    # Search for relevant assets
    local tech_filter
    tech_filter=$(printf "%s|" "${technologies[@]}")
    tech_filter="${tech_filter%|}"  # Remove trailing |
    
    OUTPUT_FORMAT=json "$SCRIPT_DIR/detect-assets.sh" "$repo" "." "$tech_filter" | \
    jq -r --arg min_score "8" '
        map(select(.score >= ($min_score | tonumber)))
        | sort_by(-.score)
        | .[]
        | "\(.type | ascii_upcase | .[0:8]) \(.path | .[0:50]) (score: \(.score)) - \(.description)"'
}

# Generate personalized suggestions
cmd_suggest() {
    local min_score="${1:-10}"
    local repo="${COPILOT_ASSETS_REPO:-github/awesome-copilot}"
    
    log_info "Generating personalized suggestions (minimum score: $min_score)"
    
    # Analyze current setup
    local current_agents current_prompts current_instructions
    current_agents=$(find .github/agents -name "*.agent.md" 2>/dev/null | wc -l)
    current_prompts=$(find .github/prompts -name "*.prompt.md" 2>/dev/null | wc -l)
    current_instructions=$(find .github/instructions -name "*.instructions.md" 2>/dev/null | wc -l)
    
    echo "Current Setup:"
    echo "  Agents: $current_agents"
    echo "  Prompts: $current_prompts"
    echo "  Instructions: $current_instructions"
    echo ""
    
    # Get suggestions based on project analysis
    OUTPUT_FORMAT=json "$SCRIPT_DIR/detect-assets.sh" "$repo" | \
    jq -r --arg min_score "$min_score" '
        map(select(.score >= ($min_score | tonumber)))
        | sort_by(-.score)
        | .[:10]
        | .[]
        | "RECOMMENDED: \(.type) \(.path) (score: \(.score))\n  \(.description)\n"'
}

# List installed assets
cmd_list() {
    echo "Installed VSCode Copilot Assets:"
    echo ""
    
    # List agents
    if [[ -d ".github/agents" ]]; then
        echo "Agents (.github/agents/):"
        find .github/agents -name "*.agent.md" 2>/dev/null | while read -r file; do
            local name
            name=$(grep "^name:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)
            echo "  $(basename "$file") - $name"
        done || echo "  None found"
        echo ""
    fi
    
    # List prompts
    if [[ -d ".github/prompts" ]]; then
        echo "Prompts (.github/prompts/):"
        find .github/prompts -name "*.prompt.md" 2>/dev/null | while read -r file; do
            local desc
            desc=$(grep "^description:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)
            echo "  $(basename "$file") - $desc"
        done || echo "  None found"
        echo ""
    fi
    
    # List instructions
    if [[ -d ".github/instructions" ]]; then
        echo "Instructions (.github/instructions/):"
        find .github/instructions -name "*.instructions.md" 2>/dev/null | while read -r file; do
            local apply_to
            apply_to=$(grep "^applyTo:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)
            echo "  $(basename "$file") - applies to: $apply_to"
        done || echo "  None found"
        echo ""
    fi
    
    # List collections
    if [[ -d "collections" ]]; then
        echo "Collections (collections/):"
        find collections -name "*.collection.yml" 2>/dev/null | while read -r file; do
            local desc
            desc=$(grep "^description:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)
            echo "  $(basename "$file") - $desc"
        done || echo "  None found"
        echo ""
    fi
    
    # List skills
    if [[ -d ".github/skills" ]]; then
        echo "Skills (.github/skills/):"
        find .github/skills -name "SKILL.md" 2>/dev/null | while read -r file; do
            local skill_name skill_desc
            skill_name=$(grep "^name:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)
            skill_desc=$(grep "^description:" "$file" 2>/dev/null | cut -d':' -f2- | xargs)
            echo "  $(dirname "$file" | xargs basename) - $skill_name: $skill_desc"
        done || echo "  None found"
    fi
}

# Create backup
cmd_backup() {
    local backup_dir="$HOME/.copilot-backups/manual-$(date +%Y%m%d_%H%M%S)"
    
    log_info "Creating backup to: $backup_dir"
    mkdir -p "$backup_dir"
    
    # Backup each type of asset
    for dir in .github/agents .github/prompts .github/instructions .github/skills collections; do
        if [[ -d "$dir" ]]; then
            cp -r "$dir" "$backup_dir/"
            log_info "Backed up: $dir"
        fi
    done
    
    log_success "Backup completed: $backup_dir"
    
    # Create manifest
    cat > "$backup_dir/manifest.txt" << EOF
Backup created: $(date)
Working directory: $(pwd)
Git commit: $(git rev-parse HEAD 2>/dev/null || echo "Not a git repository")

Contents:
$(find "$backup_dir" -type f | sort)
EOF
    
    log_info "Manifest created: $backup_dir/manifest.txt"
}

# Main function
main() {
    local command="$1"
    shift
    
    case "$command" in
        "detect")
            cmd_detect "$@"
            ;;
        "install")
            cmd_install "$@"
            ;;
        "collections")
            cmd_collections "$@"
            ;;
        "discover")
            cmd_discover "$@"
            ;;
        "suggest")
            cmd_suggest "$@"
            ;;
        "list")
            cmd_list "$@"
            ;;
        "backup")
            cmd_backup "$@"
            ;;
        "help"|"-h"|"--help"|"")
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Execute if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi