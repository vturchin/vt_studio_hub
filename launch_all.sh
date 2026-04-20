#!/usr/bin/env bash
# VT Studio — launch all four tools (Mac / Linux)
# Edit REPOS section below if your paths differ.

# ── Paths ────────────────────────────────────────────────────────────────
VEEVEE_DIR="$HOME/git_git/vt_VeeVee"
STAGE_DIR="$HOME/git_git/stage-director"
FAL_NEW_DIR="$HOME/git_git/vt_fal_studio"
FAL_LEG_DIR="$HOME/git_git/vt_fal_studio_app"
HUB_DIR="$(cd "$(dirname "$0")" && pwd)"

G='\033[0;32m'; Y='\033[1;33m'; NC='\033[0m'

echo ""
echo "  ╔═══════════════════════════════════════════════════╗"
echo "  ║  VT Studio Suite                                 ║"
echo "  ║  VeeVee · Stage Director · FAL Studio x2        ║"
echo "  ╚═══════════════════════════════════════════════════╝"
echo ""

# ── Kill stale processes ─────────────────────────────────────────────────
for port in 5173 5174 5175 3737; do
    pid=$(lsof -ti tcp:$port 2>/dev/null)
    [ -n "$pid" ] && kill -9 $pid 2>/dev/null && echo "  Cleared port $port"
done

open_tab() {
    local label="$1" cmd="$2"
    osascript -e "tell application \"Terminal\" to do script \"echo '$label' && $cmd\"" 2>/dev/null \
        || (eval "$cmd" &)
}

# ── VeeVee :5173 ─────────────────────────────────────────────────────────
if [ -f "$VEEVEE_DIR/package.json" ]; then
    echo -e "  ${G}[1/4]${NC} VeeVee            → http://localhost:5173"
    open_tab "VeeVee :5173" "cd '$VEEVEE_DIR' && npm run dev"
else echo -e "  ${Y}[SKIP]${NC} VeeVee not found at $VEEVEE_DIR"; fi

# ── Stage Director :5174 ─────────────────────────────────────────────────
if [ -f "$STAGE_DIR/package.json" ]; then
    echo -e "  ${G}[2/4]${NC} Stage Director    → http://localhost:5174"
    open_tab "Stage Director :5174" "cd '$STAGE_DIR' && npm run dev"
else echo -e "  ${Y}[SKIP]${NC} Stage Director not found at $STAGE_DIR"; fi

# ── FAL Studio new :5175 ─────────────────────────────────────────────────
if [ -f "$FAL_NEW_DIR/package.json" ]; then
    echo -e "  ${G}[3/4]${NC} FAL Studio (new)  → http://localhost:5175"
    open_tab "FAL Studio new :5175" "cd '$FAL_NEW_DIR' && npm run dev"
else echo -e "  ${Y}[SKIP]${NC} FAL Studio (new) not found at $FAL_NEW_DIR"; fi

# ── FAL Studio legacy :3737 ──────────────────────────────────────────────
if [ -f "$FAL_LEG_DIR/server.js" ]; then
    echo -e "  ${G}[4/4]${NC} FAL Studio (leg)  → http://localhost:3737"
    [ ! -d "$FAL_LEG_DIR/dist" ] && (cd "$FAL_LEG_DIR" && npm run build)
    open_tab "FAL Studio legacy :3737" "cd '$FAL_LEG_DIR' && node server.js"
else echo -e "  ${Y}[SKIP]${NC} FAL Studio (legacy) not found at $FAL_LEG_DIR"; fi

# ── Open dashboard ───────────────────────────────────────────────────────
sleep 4
echo ""
echo "  Opening dashboard..."
open "$HUB_DIR/index.html" 2>/dev/null || xdg-open "$HUB_DIR/index.html" 2>/dev/null

echo ""
echo "  All tools launched. Close their Terminal tabs to stop."
echo ""
