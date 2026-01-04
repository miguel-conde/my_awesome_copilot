#!/bin/bash

# VSCode Copilot Collection Deployment Script
# Usage: ./deploy-collection.sh <repo_url> <branch> <collection_path> [target_dir]

set -e  # Exit on error

# Configuration
REPO_URL="${1:-}"
BRANCH="${2:-main}"
COLLECTION_PATH="${3:-collections.yml}"
TARGET_DIR="${4:-$(pwd)}"
TEMP_DIR="/tmp/copilot-deploy-$(date +%s)"
BACKUP_DIR="${TARGET_DIR}/.copilot-backups/$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        log_info "Cleaning up temporary directory: $TEMP_DIR"
        rm -rf "$TEMP_DIR"
    fi
}

validate_inputs() {
    if [ -z "$REPO_URL" ]; then
        log_error "Repository URL is required"
        echo "Usage: $0 <repo_url> [branch] [collection_path] [target_dir]"
        exit 1
    fi
    
    # Create target directory if it doesn't exist
    if [ ! -d "$TARGET_DIR" ]; then
        log_info "Creating target directory: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
    fi
}

clone_repository() {
    log_info "Cloning repository: $REPO_URL (branch: $BRANCH)"
    
    if ! git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TEMP_DIR"; then
        log_error "Failed to clone repository"
        exit 1
    fi
    
    log_success "Repository cloned successfully"
}

parse_collection() {
    local collection_file="$TEMP_DIR/$COLLECTION_PATH"
    
    if [ ! -f "$collection_file" ]; then
        log_error "Collection file not found: $COLLECTION_PATH"
        exit 1
    fi
    
    log_info "Parsing collection file: $COLLECTION_PATH"
    
    # Extract collection items using Python (more robust than yq)
    local items_file="$TEMP_DIR/collection_items.txt"
    
    python3 -c "
import yaml
import sys
try:
    with open('$collection_file', 'r') as f:
        data = yaml.safe_load(f)
    items = data.get('items', [])
    if not items:
        print('No items found in collection', file=sys.stderr)
        sys.exit(1)
    for item in items:
        path = item.get('path', '').strip()
        if path:
            print(path)
except Exception as e:
    print(f'Error parsing YAML: {e}', file=sys.stderr)
    sys.exit(1)
" > "$items_file"
    
    if [ $? -ne 0 ] || [ ! -s "$items_file" ]; then
        log_error "Failed to parse collection file. Ensure YAML is valid and contains items array."
        log_error "Python with PyYAML is required for YAML parsing."
        exit 1
    fi
    
    local item_count=$(wc -l < "$items_file")
    log_success "Collection parsed: $item_count items found"
}

create_backup() {
    local source_file="$1"
    
    # Only create backup if source file exists
    if [ -f "$source_file" ]; then
        local backup_file="$BACKUP_DIR/$(basename "$source_file")"
        mkdir -p "$BACKUP_DIR"
        if cp "$source_file" "$backup_file" 2>/dev/null; then
            log_info "Backed up: $(basename "$source_file")"
        else
            log_warning "Failed to backup: $(basename "$source_file")"
        fi
    fi
}

deploy_files() {
    log_info "Starting collection-specific file deployment..."
    
    # Create standard directories
    mkdir -p "$TARGET_DIR/.github/agents"
    mkdir -p "$TARGET_DIR/.github/prompts" 
    mkdir -p "$TARGET_DIR/.github/instructions"
    
    local items_file="$TEMP_DIR/collection_items.txt"
    local deployed_count=0
    local failed_count=0
    
    # Deploy only files specified in collection
    while IFS= read -r file_path; do
        [ -z "$file_path" ] && continue
        
        local source_file="$TEMP_DIR/$file_path"
        local target_file="$TARGET_DIR/.github/$file_path"
        
        if [ -f "$source_file" ]; then
            # Create target directory if it doesn't exist
            local target_dir=$(dirname "$target_file")
            mkdir -p "$target_dir"
            
            # Create backup if target exists
            create_backup "$target_file"
            
            # Copy the file
            if cp "$source_file" "$target_file"; then
                log_success "Deployed: $file_path"
                ((deployed_count++))
            else
                log_error "Failed to deploy: $file_path"
                ((failed_count++))
            fi
        else
            log_warning "Source file not found: $file_path"
            ((failed_count++))
        fi
    done < "$items_file"
    
    log_info "Deployment summary: $deployed_count deployed, $failed_count failed"
    
    if [ $failed_count -gt 0 ]; then
        log_warning "Some files failed to deploy. Check the logs above."
        return 1
    fi
}

validate_deployment() {
    log_info "Validating collection deployment..."
    
    local items_file="$TEMP_DIR/collection_items.txt"
    local expected_count=0
    
    # Count expected files safely
    if [ -f "$items_file" ]; then
        expected_count=$(wc -l < "$items_file" 2>/dev/null || echo 0)
    fi
    
    # Count by type
    local agent_count=0
    local prompt_count=0
    local instruction_count=0
    
    while IFS= read -r file_path || [ -n "$file_path" ]; do
        [ -z "$file_path" ] && continue
        local target_file="$TARGET_DIR/.github/$file_path"
        
        if [ -f "$target_file" ]; then
            if [[ "$file_path" == agents/*.agent.md ]]; then
                ((agent_count++))
            elif [[ "$file_path" == prompts/*.prompt.md ]]; then
                ((prompt_count++))
            elif [[ "$file_path" == instructions/*.instructions.md ]]; then
                ((instruction_count++))
            fi
        fi
    done < "$items_file"
    
    local total_deployed=$((agent_count + prompt_count + instruction_count))
    
    log_success "Collection deployment completed:"
    log_success "  Expected: $expected_count files"
    log_success "  Deployed: $total_deployed files"
    log_success "  Agents: $agent_count files"
    log_success "  Prompts: $prompt_count files"  
    log_success "  Instructions: $instruction_count files"
    
    if [ $total_deployed -eq $expected_count ] && [ $expected_count -gt 0 ]; then
        log_success "✓ All collection items deployed successfully"
    elif [ $total_deployed -gt 0 ]; then
        log_warning "⚠ Deployed count ($total_deployed) doesn't match expected ($expected_count)"
    else
        log_error "✗ No files were deployed"
        return 1
    fi
    
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        log_info "Backups created in: $BACKUP_DIR"
    fi
    
    return 0
}

# Main execution
main() {
    log_info "Starting VSCode Copilot collection deployment"
    
    # Set up cleanup trap
    trap cleanup EXIT
    
    # Execute deployment steps
    validate_inputs
    clone_repository
    parse_collection
    
    # Deploy files and continue even if some fail
    if deploy_files; then
        log_success "All files deployed successfully"
    else
        log_warning "Some files failed to deploy, continuing with validation"
    fi
    
    validate_deployment
    
    log_success "Deployment completed!"
}

# Run main function
main "$@"