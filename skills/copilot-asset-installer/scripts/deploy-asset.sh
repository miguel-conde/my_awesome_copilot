#!/bin/bash

# Individual Asset Installer for VSCode Copilot Customizations
# Usage: ./deploy-asset.sh <repo_url> <asset_path> [target_dir]
# Supports: agents, prompts, instructions, collections, skills

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_DIR="/tmp/asset-deploy-$(date +%s)"
BACKUP_DIR="$HOME/.copilot-backups/$(date +%Y%m%d_%H%M%S)"

# Default directories
AGENTS_DIR=".github/agents"
PROMPTS_DIR=".github/prompts"
INSTRUCTIONS_DIR=".github/instructions"
COLLECTIONS_DIR="collections"
SKILLS_DIR=".github/skills"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[DEPLOY]${NC} $1" >&2; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1" >&2; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Validate asset file
validate_asset() {
    local file_path="$1"
    local asset_type="$2"
    
    log_info "Validating $asset_type: $file_path"
    
    if [[ ! -f "$file_path" ]]; then
        log_error "Asset file not found: $file_path"
        return 1
    fi
    
    # Check for frontmatter
    if ! head -n 1 "$file_path" | grep -q "^---$"; then
        log_warn "No frontmatter found in $file_path"
        return 1
    fi
    
    # Type-specific validation
    case "$asset_type" in
        "agent")
            if ! grep -q "^name:" "$file_path"; then
                log_warn "Agent missing 'name' field in frontmatter"
            fi
            ;;
        "prompt")
            if ! grep -q "^description:" "$file_path"; then
                log_warn "Prompt missing 'description' field in frontmatter"
            fi
            ;;
        "instruction")
            if ! grep -q "^applyTo:" "$file_path"; then
                log_warn "Instruction missing 'applyTo' field in frontmatter"
            fi
            ;;
        "collection")
            if ! grep -q "^agents:" "$file_path" && ! grep -q "^prompts:" "$file_path"; then
                log_error "Collection missing agents or prompts section"
                return 1
            fi
            ;;
        "skill")
            if ! grep -q "^name:" "$file_path" || ! grep -q "^description:" "$file_path"; then
                log_error "Skill missing required name or description"
                return 1
            fi
            ;;
    esac
    
    return 0
}

# Backup existing file if it exists
backup_existing() {
    local target_path="$1"
    
    if [[ -f "$target_path" ]]; then
        local backup_path="$BACKUP_DIR/$(basename "$target_path")"
        mkdir -p "$(dirname "$backup_path")"
        cp "$target_path" "$backup_path"
        log_info "Backed up existing file to: $backup_path"
    fi
}

# Resolve naming conflicts
resolve_naming_conflict() {
    local target_path="$1"
    local counter=1
    
    while [[ -f "$target_path" ]]; do
        local dir=$(dirname "$target_path")
        local name=$(basename "$target_path" | sed 's/\.[^.]*$//')
        local ext="${target_path##*.}"
        
        target_path="$dir/${name}-${counter}.${ext}"
        counter=$((counter + 1))
    done
    
    echo "$target_path"
}

# Install individual asset
install_asset() {
    local repo_url="$1"
    local asset_path="$2"
    local target_dir="$3"
    local asset_type asset_name target_path
    
    # Detect asset type
    case "$asset_path" in
        *.agent.md) asset_type="agent" ;;
        *.prompt.md) asset_type="prompt" ;;
        *.instructions.md) asset_type="instruction" ;;
        *.collection.yml) asset_type="collection" ;;
        */SKILL.md) asset_type="skill" ;;
        *) 
            log_error "Unknown asset type for: $asset_path"
            return 1 
            ;;
    esac
    
    log_info "Installing $asset_type: $asset_path"
    
    # Clone repository
    mkdir -p "$TEMP_DIR"
    if ! git clone --depth 1 "$repo_url" "$TEMP_DIR/repo" 2>/dev/null; then
        log_error "Failed to clone repository: $repo_url"
        return 1
    fi
    
    local source_file="$TEMP_DIR/repo/$asset_path"
    if [[ ! -f "$source_file" ]]; then
        log_error "Asset not found in repository: $asset_path"
        rm -rf "$TEMP_DIR"
        return 1
    fi
    
    # Validate asset
    if ! validate_asset "$source_file" "$asset_type"; then
        log_error "Asset validation failed"
        rm -rf "$TEMP_DIR"
        return 1
    fi
    
    # Determine target directory
    local install_dir
    if [[ -n "$target_dir" ]]; then
        install_dir="$target_dir"
    else
        case "$asset_type" in
            "agent") install_dir="$AGENTS_DIR" ;;
            "prompt") install_dir="$PROMPTS_DIR" ;;
            "instruction") install_dir="$INSTRUCTIONS_DIR" ;;
            "collection") install_dir="$COLLECTIONS_DIR" ;;
            "skill") 
                # Skills are directories, extract name from SKILL.md
                local skill_name
                skill_name=$(grep "^name:" "$source_file" | sed 's/^name:\s*//' | sed 's/[^a-zA-Z0-9-]/-/g' | tr '[:upper:]' '[:lower:]')
                install_dir="$SKILLS_DIR/$skill_name"
                ;;
        esac
    fi
    
    # Create target directory
    mkdir -p "$install_dir"
    
    # Determine target path
    if [[ "$asset_type" == "skill" ]]; then
        # Install entire skill directory
        local skill_dir="$(dirname "$source_file")"
        target_path="$install_dir"
        
        # Copy entire skill structure
        cp -r "$skill_dir"/* "$install_dir/"
        
        log_success "Installed skill to: $install_dir"
    else
        # Install individual file
        asset_name=$(basename "$asset_path")
        target_path="$install_dir/$asset_name"
        
        # Handle naming conflicts
        if [[ -f "$target_path" ]]; then
            backup_existing "$target_path"
            local resolved_path
            resolved_path=$(resolve_naming_conflict "$target_path")
            if [[ "$resolved_path" != "$target_path" ]]; then
                log_warn "Naming conflict resolved: $target_path -> $resolved_path"
                target_path="$resolved_path"
            fi
        fi
        
        # Copy the file
        cp "$source_file" "$target_path"
        log_success "Installed $asset_type to: $target_path"
    fi
    
    # Post-installation validation
    case "$asset_type" in
        "collection")
            log_info "Collection installed. Run deploy-collection.sh to install its contents."
            ;;
        "skill")
            if [[ -f "$target_path/scripts/install.sh" ]]; then
                log_info "Skill has install script. Run: $target_path/scripts/install.sh"
            fi
            ;;
    esac
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    return 0
}

# Show asset information
show_asset_info() {
    local repo_url="$1"
    local asset_path="$2"
    
    # Clone repository
    mkdir -p "$TEMP_DIR"
    if ! git clone --depth 1 "$repo_url" "$TEMP_DIR/repo" 2>/dev/null; then
        log_error "Failed to clone repository: $repo_url"
        return 1
    fi
    
    local source_file="$TEMP_DIR/repo/$asset_path"
    if [[ ! -f "$source_file" ]]; then
        log_error "Asset not found: $asset_path"
        rm -rf "$TEMP_DIR"
        return 1
    fi
    
    log_info "Asset Information:"
    echo "  Path: $asset_path"
    echo "  Type: $(detect_asset_type "$asset_path")"
    echo "  Size: $(wc -l < "$source_file") lines"
    
    # Extract frontmatter
    local frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$source_file" | sed '1d;$d')
    
    if [[ -n "$frontmatter" ]]; then
        echo "  Frontmatter:"
        echo "$frontmatter" | sed 's/^/    /'
    fi
    
    # Cleanup
    rm -rf "$TEMP_DIR"
}

# Detect asset type from path
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

# Main function
main() {
    local repo_url="$1"
    local asset_path="$2"
    local target_dir="$3"
    local action="${4:-install}"
    
    if [[ -z "$repo_url" || -z "$asset_path" ]]; then
        cat << EOF
Usage: $0 <repo_url> <asset_path> [target_dir] [action]

Actions:
  install (default) - Install the asset
  info             - Show asset information

Examples:
  $0 github/awesome-copilot agents/code-reviewer.agent.md
  $0 https://github.com/myorg/tools prompts/testing.prompt.md .github/prompts
  $0 github/awesome-copilot collections/frontend.collection.yml info

Asset Types:
  *.agent.md        -> .github/agents/
  *.prompt.md       -> .github/prompts/
  *.instructions.md -> .github/instructions/
  *.collection.yml  -> collections/
  */SKILL.md        -> .github/skills/{skill-name}/
EOF
        exit 1
    fi
    
    # Convert owner/repo format to full URL
    if [[ "$repo_url" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+$ ]]; then
        repo_url="https://github.com/$repo_url"
    fi
    
    case "$action" in
        "install")
            install_asset "$repo_url" "$asset_path" "$target_dir"
            ;;
        "info")
            show_asset_info "$repo_url" "$asset_path"
            ;;
        *)
            log_error "Unknown action: $action"
            exit 1
            ;;
    esac
}

# Execute if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi