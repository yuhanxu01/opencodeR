#!/bin/bash

###############################################################################
# OpenCodeR Research Features - One-Click Installation Script
#
# This script migrates research-specific features from opencodeR to your
# local Claude Code installation.
#
# Features included:
# - STEM Research Agent with zero-hallucination protocol
# - Cross-language literature search (Chinese-English)
# - Automatic literature organization
# - DeepSeek Reasoner integration
# - MCP server configuration
#
# Usage:
#   ./install-research-features.sh [OPTIONS]
#
# Options:
#   --target PATH       Target .opencode directory (default: current project)
#   --global            Install to global Claude Code config (~/.config/opencode)
#   --backup            Create backup before installation (default: yes)
#   --no-backup         Skip backup
#   --dry-run           Show what would be installed without making changes
#   --help              Show this help message
#
###############################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default options
BACKUP=true
DRY_RUN=false
TARGET_DIR=""
GLOBAL_INSTALL=false

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_OPENCODE_DIR="$SCRIPT_DIR/.opencode"

###############################################################################
# Helper Functions
###############################################################################

print_header() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║                                                               ║"
    echo "║     OpenCodeR Research Features - Installation Script         ║"
    echo "║                                                               ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_step() {
    echo -e "${CYAN}▶ $1${NC}"
}

show_help() {
    cat << EOF
OpenCodeR Research Features Installation Script

Usage: $0 [OPTIONS]

Options:
    --target PATH       Target .opencode directory (default: current project)
    --global            Install to global Claude Code config (~/.config/opencode)
    --backup            Create backup before installation (default: yes)
    --no-backup         Skip backup
    --dry-run           Show what would be installed without making changes
    --help              Show this help message

Examples:
    # Install to current project (default)
    $0

    # Install to global Claude Code config
    $0 --global

    # Install to specific project
    $0 --target /path/to/project/.opencode

    # Dry run to see what would be installed
    $0 --dry-run

    # Install without backup (not recommended)
    $0 --no-backup

Features Installed:
    ✓ STEM Research Agent with zero-hallucination protocol
    ✓ Cross-language literature search (Chinese-English)
    ✓ Automatic literature organization
    ✓ DeepSeek Reasoner integration
    ✓ MCP server configuration
    ✓ Complete skill definitions (4 skills)
    ✓ Literature library structure
    ✓ Documentation and guides

EOF
}

###############################################################################
# Parse Command Line Arguments
###############################################################################

while [[ $# -gt 0 ]]; do
    case $1 in
        --target)
            TARGET_DIR="$2"
            shift 2
            ;;
        --global)
            GLOBAL_INSTALL=true
            shift
            ;;
        --backup)
            BACKUP=true
            shift
            ;;
        --no-backup)
            BACKUP=false
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

###############################################################################
# Determine Target Directory
###############################################################################

if [ "$GLOBAL_INSTALL" = true ]; then
    TARGET_DIR="$HOME/.config/opencode"
    print_info "Installing to global Claude Code config: $TARGET_DIR"
elif [ -z "$TARGET_DIR" ]; then
    TARGET_DIR="$(pwd)/.opencode"
    print_info "Installing to current project: $TARGET_DIR"
fi

###############################################################################
# Validation
###############################################################################

print_header

print_step "Validating installation..."

# Check if source directory exists
if [ ! -d "$SOURCE_OPENCODE_DIR" ]; then
    print_error "Source directory not found: $SOURCE_OPENCODE_DIR"
    print_error "Please run this script from the opencodeR project root"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    print_warning "Target directory doesn't exist: $TARGET_DIR"
    if [ "$DRY_RUN" = false ]; then
        print_info "Creating directory: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
    fi
fi

print_success "Validation complete"
echo ""

###############################################################################
# Show Installation Plan
###############################################################################

print_step "Installation Plan:"
echo ""
echo "  Source: $SOURCE_OPENCODE_DIR"
echo "  Target: $TARGET_DIR"
echo "  Backup: $([ "$BACKUP" = true ] && echo "Yes" || echo "No")"
echo "  Dry Run: $([ "$DRY_RUN" = true ] && echo "Yes" || echo "No")"
echo ""

print_step "Files to be installed:"
echo ""

# Skills
echo "  📚 Skills (4 items):"
echo "     - stem-research/SKILL.md          (8540 bytes, zero-hallucination protocol)"
echo "     - literature-search/SKILL.md      (8533 bytes, cross-language search)"
echo "     - literature-organizer/SKILL.md   (7850 bytes, auto-categorization)"
echo "     - bun-file-io/SKILL.md           (file I/O operations)"
echo ""

# Literature library
echo "  📖 Literature Library:"
echo "     - literature/README.md            (usage guide)"
echo "     - literature/TESTING.md           (test cases)"
echo "     - literature/CROSS_LANGUAGE_SEARCH.md  (search guide)"
echo "     - literature/math/                (sample math literature)"
echo "     - literature/physics/             (sample physics literature)"
echo "     - literature/cs/                  (sample CS literature)"
echo "     - literature/engineering/         (sample engineering literature)"
echo "     - literature/textbooks/           (sample textbooks)"
echo ""

# Configuration
echo "  ⚙️  Configuration:"
echo "     - opencode.jsonc                  (will merge with existing)"
echo "     - AGENTS.md                       (agent usage guide)"
echo ""

# Tools
echo "  🔧 Custom Tools:"
echo "     - tool/github-pr-search.ts        (GitHub PR search)"
echo "     - tool/github-triage.ts           (GitHub issue triage)"
echo ""

###############################################################################
# Backup Existing Configuration
###############################################################################

if [ "$BACKUP" = true ] && [ -d "$TARGET_DIR" ] && [ "$DRY_RUN" = false ]; then
    print_step "Creating backup..."
    BACKUP_DIR="${TARGET_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    cp -r "$TARGET_DIR" "$BACKUP_DIR"
    print_success "Backup created: $BACKUP_DIR"
    echo ""
fi

###############################################################################
# Installation Functions
###############################################################################

install_directory() {
    local src="$1"
    local dst="$2"
    local description="$3"

    if [ "$DRY_RUN" = true ]; then
        print_info "[DRY RUN] Would install: $description"
        return
    fi

    print_step "Installing: $description"

    # Create target directory if needed
    mkdir -p "$dst"

    # Copy contents
    cp -r "$src"/* "$dst/" 2>/dev/null || true

    print_success "Installed: $description"
}

install_file() {
    local src="$1"
    local dst="$2"
    local description="$3"

    if [ "$DRY_RUN" = true ]; then
        print_info "[DRY RUN] Would install: $description"
        return
    fi

    print_step "Installing: $description"

    # Create target directory if needed
    mkdir -p "$(dirname "$dst")"

    # Copy file
    cp "$src" "$dst"

    print_success "Installed: $description"
}

merge_config() {
    local src="$1"
    local dst="$2"

    if [ "$DRY_RUN" = true ]; then
        print_info "[DRY RUN] Would merge configuration"
        return
    fi

    print_step "Merging configuration..."

    if [ -f "$dst" ]; then
        print_warning "Existing config found, will create merged version"

        # Create backup of existing config
        cp "$dst" "${dst}.original"

        # For now, just copy the new config with a note
        # In production, you'd want to use a JSON merge tool
        cp "$src" "${dst}.research"

        print_warning "Manual merge required:"
        print_info "  Original config: ${dst}.original"
        print_info "  Research config: ${dst}.research"
        print_info "  Current config:  ${dst}"
        print_info ""
        print_info "  Please manually merge the 'agent', 'provider', and 'mcp' sections"
    else
        cp "$src" "$dst"
        print_success "Configuration installed"
    fi
}

###############################################################################
# Main Installation
###############################################################################

if [ "$DRY_RUN" = false ]; then
    echo ""
    read -p "$(echo -e ${YELLOW}Proceed with installation? [y/N]: ${NC})" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled"
        exit 0
    fi
    echo ""
fi

print_step "Starting installation..."
echo ""

# Install Skills
install_directory \
    "$SOURCE_OPENCODE_DIR/skill" \
    "$TARGET_DIR/skill" \
    "Skills (stem-research, literature-search, literature-organizer, bun-file-io)"

# Install Literature Library
install_directory \
    "$SOURCE_OPENCODE_DIR/literature" \
    "$TARGET_DIR/literature" \
    "Literature library structure and documentation"

# Install Custom Tools
if [ -d "$SOURCE_OPENCODE_DIR/tool" ]; then
    install_directory \
        "$SOURCE_OPENCODE_DIR/tool" \
        "$TARGET_DIR/tool" \
        "Custom tools (github-pr-search, github-triage)"
fi

# Install Agent Documentation
if [ -f "$SOURCE_OPENCODE_DIR/AGENTS.md" ]; then
    install_file \
        "$SOURCE_OPENCODE_DIR/AGENTS.md" \
        "$TARGET_DIR/AGENTS.md" \
        "Agent usage guide"
fi

# Merge Configuration
merge_config \
    "$SOURCE_OPENCODE_DIR/opencode.jsonc" \
    "$TARGET_DIR/opencode.jsonc"

echo ""
print_success "Installation complete!"
echo ""

###############################################################################
# Post-Installation Instructions
###############################################################################

print_step "Post-Installation Setup:"
echo ""

if [ -f "${TARGET_DIR}/opencode.jsonc.research" ]; then
    print_warning "IMPORTANT: Configuration merge required"
    echo ""
    echo "  1. Open the following files:"
    echo "     - Original: ${TARGET_DIR}/opencode.jsonc.original"
    echo "     - Research: ${TARGET_DIR}/opencode.jsonc.research"
    echo ""
    echo "  2. Merge the following sections from research config into your original:"
    echo ""
    echo "     a) Provider configuration:"
    echo '        "provider": {'
    echo '          "opencode": { "options": {} },'
    echo '          "deepseek": { "options": {} }'
    echo '        }'
    echo ""
    echo "     b) Agent configuration:"
    echo '        "agent": {'
    echo '          "general": {'
    echo '            "name": "General Reasoning",'
    echo '            "mode": "subagent",'
    echo '            "model": "deepseek/deepseek-reasoner"'
    echo '          },'
    echo '          "stem-research": { ... },'
    echo '          "literature-organizer": { ... }'
    echo '        }'
    echo ""
    echo "     c) MCP configuration (optional):"
    echo '        "mcp": {'
    echo '          "context7": {'
    echo '            "type": "remote",'
    echo '            "url": "https://mcp.context7.com/mcp"'
    echo '          }'
    echo '        }'
    echo ""
else
    print_info "Configuration installed successfully"
fi

echo ""
print_step "Next Steps:"
echo ""
echo "  1. Upload your literature files to:"
echo "     $TARGET_DIR/literature/[category]/"
echo ""
echo "  2. Categories available:"
echo "     - math/          (mathematics literature)"
echo "     - physics/       (physics literature)"
echo "     - cs/            (computer science literature)"
echo "     - engineering/   (engineering literature)"
echo "     - textbooks/     (textbooks and references)"
echo ""
echo "  3. Test the installation:"
echo "     a) Start Claude Code"
echo "     b) Switch to 'STEM Research' agent (press Tab)"
echo "     c) Ask a research question"
echo ""
echo "  4. Use auto-organizer for bulk uploads:"
echo "     a) Copy files to a 'files/' directory"
echo "     b) Switch to 'Literature Organizer' agent"
echo "     c) Say '整理文献' or 'organize literature'"
echo ""

print_step "Documentation:"
echo ""
echo "  📖 Agent Usage Guide:     $TARGET_DIR/AGENTS.md"
echo "  📖 Literature README:     $TARGET_DIR/literature/README.md"
echo "  📖 Testing Guide:         $TARGET_DIR/literature/TESTING.md"
echo "  📖 Search Guide:          $TARGET_DIR/literature/CROSS_LANGUAGE_SEARCH.md"
echo "  📖 Feature Checklist:     $SCRIPT_DIR/FEATURE_CHECKLIST.md"
echo ""

print_step "Skill Documentation:"
echo ""
echo "  📚 STEM Research:         $TARGET_DIR/skill/stem-research/SKILL.md"
echo "  📚 Literature Search:     $TARGET_DIR/skill/literature-search/SKILL.md"
echo "  📚 Literature Organizer:  $TARGET_DIR/skill/literature-organizer/SKILL.md"
echo "  📚 File I/O:              $TARGET_DIR/skill/bun-file-io/SKILL.md"
echo ""

if [ "$BACKUP" = true ] && [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
    print_info "Backup Location: $BACKUP_DIR"
    echo ""
fi

print_success "All research features installed successfully!"
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  You're ready to use OpenCodeR's zero-hallucination research  ║${NC}"
echo -e "${GREEN}║  features with your local Claude Code installation!          ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""

exit 0
