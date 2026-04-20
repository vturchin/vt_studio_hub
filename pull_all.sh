#!/usr/bin/env bash
# VT Studio — Pull All Repos (Mac / Linux)
chcp_utf8() { :; }  # no-op on bash

G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; NC='\033[0m'

echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║   VT Studio — Pull Latest           ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

pull() {
    local LABEL="$1"
    local DIR="$2"
    local BRANCH="$3"

    if [ ! -d "$DIR/.git" ]; then
        echo -e "  ${Y}[SKIP]${NC} $LABEL — not a git repo"
        return
    fi

    echo -e "  ${G}[$LABEL]${NC}"
    pushd "$DIR" > /dev/null
    git fetch origin 2>/dev/null
    git pull origin "$BRANCH" 2>&1 | grep -v '^$'
    popd > /dev/null
    echo ""
}

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

pull "vt_VeeVee"        "$HOME/git_git/vt_VeeVee"         "main"
pull "Stage Director"   "$HOME/git_git/stage-director"     "master"
pull "FAL Studio (new)" "$HOME/git_git/vt_fal_studio"      "master"
pull "FAL Studio (leg)" "$HOME/git_git/vt_fal_studio_app"  "experimental"
pull "Studio Hub"       "$SCRIPT_DIR"                      "master"

echo "  All repos up to date."
echo ""
