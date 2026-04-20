#!/usr/bin/env bash
# VT Studio — Push All Repos (Mac / Linux)

G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; NC='\033[0m'

echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║   VT Studio — Push All Changes      ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

# Ask for one commit message used across all repos that have changes
echo -n "  Commit message (leave blank to auto-name per repo): "
read -r MSG
echo ""

push() {
    local LABEL="$1"
    local DIR="$2"
    local BRANCH="$3"

    if [ ! -d "$DIR/.git" ]; then
        echo -e "  ${Y}[SKIP]${NC} $LABEL — not a git repo"
        return
    fi

    pushd "$DIR" > /dev/null

    if [ -z "$(git status --porcelain 2>/dev/null)" ]; then
        echo -e "  [$LABEL] nothing to commit — pushing any unpushed commits..."
        git push origin "$BRANCH" 2>&1 | grep -v '^$'
        popd > /dev/null
        return
    fi

    git add .
    if [ -z "$MSG" ]; then
        git commit -m "Updates — $(date '+%Y-%m-%d %H:%M')" 2>&1 | grep -v '^$'
    else
        git commit -m "$MSG" 2>&1 | grep -v '^$'
    fi
    git push origin "$BRANCH" 2>&1 | grep -v '^$'
    echo -e "  ${G}[$LABEL]${NC} pushed to $BRANCH"

    popd > /dev/null
    echo ""
}

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

push "vt_VeeVee"        "$HOME/git_git/vt_VeeVee"         "main"
push "Stage Director"   "$HOME/git_git/stage-director"     "master"
push "FAL Studio (new)" "$HOME/git_git/vt_fal_studio"      "master"
push "FAL Studio (leg)" "$HOME/git_git/vt_fal_studio_app"  "experimental"
push "Studio Hub"       "$SCRIPT_DIR"                      "master"

echo "  Done."
echo ""
