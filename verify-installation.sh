#!/bin/bash

###############################################################################
# OpenCodeR Research Features - Installation Verification Script
#
# This script verifies that all research features are properly installed.
#
# Usage:
#   ./verify-installation.sh [PATH]
#
# Arguments:
#   PATH    Optional path to .opencode directory (default: current project)
#
###############################################################################

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Default target
TARGET_DIR="${1:-.opencode}"

# Counters
total_checks=0
passed_checks=0
warnings=0

print_header() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║                                                               ║"
    echo "║     OpenCodeR Research Features - Verification Report         ║"
    echo "║                                                               ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_section() {
    echo ""
    echo -e "${BLUE}▶ $1${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

check_pass() {
    echo -e "${GREEN}  ✓${NC} $1"
    ((passed_checks++))
}

check_fail() {
    echo -e "${RED}  ✗${NC} $1"
}

check_warn() {
    echo -e "${YELLOW}  ⚠${NC} $1"
    ((warnings++))
}

check_info() {
    echo -e "${BLUE}  ℹ${NC} $1"
}

###############################################################################
# Main Verification
###############################################################################

print_header

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}✗ Target directory not found: $TARGET_DIR${NC}"
    echo ""
    echo "Usage: $0 [PATH]"
    echo "  PATH: Path to .opencode directory (default: .opencode)"
    exit 1
fi

echo "Target: $TARGET_DIR"
echo ""

# 1. Check Skills
print_section "1. Skills Verification"
((total_checks++))

skills_found=0
skills_expected=("stem-research" "literature-search" "literature-organizer" "bun-file-io")

for skill in "${skills_expected[@]}"; do
    skill_path="$TARGET_DIR/skill/$skill/SKILL.md"
    if [ -f "$skill_path" ]; then
        size=$(wc -c < "$skill_path")
        check_pass "$skill skill installed ($size bytes)"
        ((skills_found++))
    else
        check_fail "$skill skill NOT found at $skill_path"
    fi
done

if [ $skills_found -eq ${#skills_expected[@]} ]; then
    check_pass "All $skills_found skills installed successfully"
    ((passed_checks++))
else
    check_fail "Only $skills_found/${#skills_expected[@]} skills installed"
fi

# 2. Check Literature Library
print_section "2. Literature Library Verification"

# Check literature directory
((total_checks++))
if [ -d "$TARGET_DIR/literature" ]; then
    check_pass "Literature directory exists"
    ((passed_checks++))
else
    check_fail "Literature directory NOT found"
fi

# Check documentation
((total_checks++))
docs_found=0
docs_expected=("README.md" "TESTING.md" "CROSS_LANGUAGE_SEARCH.md")

for doc in "${docs_expected[@]}"; do
    if [ -f "$TARGET_DIR/literature/$doc" ]; then
        check_pass "Documentation: $doc"
        ((docs_found++))
    else
        check_fail "Documentation missing: $doc"
    fi
done

if [ $docs_found -eq ${#docs_expected[@]} ]; then
    ((passed_checks++))
fi

# Check categories
((total_checks++))
categories_found=0
categories_expected=("math" "physics" "cs" "engineering" "textbooks")

for category in "${categories_expected[@]}"; do
    if [ -d "$TARGET_DIR/literature/$category" ]; then
        file_count=$(find "$TARGET_DIR/literature/$category" -name "*.md" 2>/dev/null | wc -l)
        check_pass "Category: $category ($file_count files)"
        ((categories_found++))
    else
        check_warn "Category directory not found: $category (will be created when needed)"
    fi
done

if [ $categories_found -gt 0 ]; then
    check_info "Found $categories_found/${#categories_expected[@]} category directories"
    ((passed_checks++))
else
    check_warn "No category directories found (OK if fresh install)"
fi

# 3. Check Configuration
print_section "3. Configuration Verification"

((total_checks++))
if [ -f "$TARGET_DIR/opencode.jsonc" ]; then
    check_pass "Configuration file exists"

    # Check for key sections
    if grep -q '"agent"' "$TARGET_DIR/opencode.jsonc"; then
        check_pass "Agent configuration found"
    else
        check_warn "Agent configuration not found in opencode.jsonc"
    fi

    if grep -q '"provider"' "$TARGET_DIR/opencode.jsonc"; then
        check_pass "Provider configuration found"
    else
        check_warn "Provider configuration not found in opencode.jsonc"
    fi

    if grep -q '"stem-research"' "$TARGET_DIR/opencode.jsonc"; then
        check_pass "STEM Research agent configured"
    else
        check_warn "STEM Research agent not configured"
    fi

    if grep -q '"literature-organizer"' "$TARGET_DIR/opencode.jsonc"; then
        check_pass "Literature Organizer agent configured"
    else
        check_warn "Literature Organizer agent not configured"
    fi

    ((passed_checks++))
else
    check_fail "Configuration file NOT found: $TARGET_DIR/opencode.jsonc"
fi

# 4. Check Agent Documentation
print_section "4. Documentation Verification"

((total_checks++))
if [ -f "$TARGET_DIR/AGENTS.md" ]; then
    check_pass "Agent usage guide installed"
    ((passed_checks++))
else
    check_warn "Agent guide not found: AGENTS.md"
fi

# 5. Check Custom Tools
print_section "5. Custom Tools Verification"

((total_checks++))
if [ -d "$TARGET_DIR/tool" ]; then
    tool_count=$(find "$TARGET_DIR/tool" -name "*.ts" 2>/dev/null | wc -l)
    if [ $tool_count -gt 0 ]; then
        check_pass "Custom tools directory exists ($tool_count tools)"

        if [ -f "$TARGET_DIR/tool/github-pr-search.ts" ]; then
            check_pass "GitHub PR search tool installed"
        fi

        if [ -f "$TARGET_DIR/tool/github-triage.ts" ]; then
            check_pass "GitHub triage tool installed"
        fi

        ((passed_checks++))
    else
        check_warn "Tools directory exists but no tools found"
    fi
else
    check_warn "Custom tools directory not found (optional)"
fi

# 6. File Count Statistics
print_section "6. Content Statistics"

# Count literature files
lit_files=$(find "$TARGET_DIR/literature" -name "*.md" 2>/dev/null | wc -l)
check_info "Total literature files: $lit_files"

# Count by category
for category in "${categories_expected[@]}"; do
    if [ -d "$TARGET_DIR/literature/$category" ]; then
        count=$(find "$TARGET_DIR/literature/$category" -name "*.md" 2>/dev/null | wc -l)
        if [ $count -gt 0 ]; then
            check_info "  - $category: $count files"
        fi
    fi
done

# 7. Backup Check
print_section "7. Backup Verification"

backup_count=$(find "$(dirname "$TARGET_DIR")" -maxdepth 1 -name "$(basename "$TARGET_DIR")_backup_*" -type d 2>/dev/null | wc -l)
if [ $backup_count -gt 0 ]; then
    check_pass "Found $backup_count backup(s)"
    check_info "Latest backup: $(find "$(dirname "$TARGET_DIR")" -maxdepth 1 -name "$(basename "$TARGET_DIR")_backup_*" -type d 2>/dev/null | sort -r | head -1)"
else
    check_info "No backups found"
fi

# Summary
print_section "Summary"

echo ""
echo -e "  Total Checks:   ${total_checks}"
echo -e "  ${GREEN}Passed:         ${passed_checks}${NC}"
echo -e "  ${RED}Failed:         $((total_checks - passed_checks))${NC}"
echo -e "  ${YELLOW}Warnings:       ${warnings}${NC}"
echo ""

# Overall result
if [ $passed_checks -eq $total_checks ]; then
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✓ ALL CHECKS PASSED - Installation successful!              ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}Next Steps:${NC}"
    echo "  1. Upload literature files to: $TARGET_DIR/literature/[category]/"
    echo "  2. Start Claude Code and switch to 'STEM Research' agent (Tab key)"
    echo "  3. Try a research question to test the system"
    echo ""
    echo -e "${CYAN}Documentation:${NC}"
    echo "  - Agent Guide:  $TARGET_DIR/AGENTS.md"
    echo "  - Testing:      $TARGET_DIR/literature/TESTING.md"
    echo "  - Search Guide: $TARGET_DIR/literature/CROSS_LANGUAGE_SEARCH.md"
    echo ""
    exit 0
elif [ $passed_checks -ge $((total_checks * 2 / 3)) ]; then
    echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║  ⚠ PARTIAL INSTALLATION - Some components missing            ║${NC}"
    echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Recommendations:${NC}"
    echo "  1. Re-run the installation script: ./install-research-features.sh"
    echo "  2. Manually merge configuration if needed"
    echo "  3. Check warnings above for specific issues"
    echo ""
    exit 1
else
    echo -e "${RED}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ✗ INSTALLATION FAILED - Critical components missing          ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${RED}Action Required:${NC}"
    echo "  1. Run the installation script: ./install-research-features.sh"
    echo "  2. Check for errors during installation"
    echo "  3. Verify you have write permissions to: $TARGET_DIR"
    echo ""
    exit 2
fi
