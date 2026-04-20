#!/usr/bin/env bash
# VT Studio — launch all three tools (Mac / Linux)
# Adjust the paths below if your repos live elsewhere.

VEEVEE_DIR="$HOME/git_git/vt_VeeVee"
STAGE_DIR="$HOME/git_git/stage-director"
FAL_DIR="$HOME/git_git/vt_fal_studio"
HUB_DIR="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo ""
echo "  ╔══════════════════════════════════════════╗"
echo "  ║  VT Studio Suite                        ║"
echo "  ║  VeeVee · Stage Director · FAL Studio   ║"
echo "  ╚══════════════════════════════════════════╝"
echo ""

# Kill anything on our ports
for port in 5173 5174 5175; do
    pid=$(lsof -ti tcp:$port 2>/dev/null)
    [ -n "$pid" ] && kill -9 $pid 2>/dev/null && echo "  Cleared port $port (PID $pid)"
done

# VeeVee :5173
if [ -f "$VEEVEE_DIR/package.json" ]; then
    echo -e "  ${GREEN}[+]${NC} Starting VeeVee       → http://localhost:5173"
    osascript -e "tell app \"Terminal\" to do script \"cd '$VEEVEE_DIR' && npm run dev\"" 2>/dev/null \
        || (cd "$VEEVEE_DIR" && npm run dev &)
else
    echo -e "  ${YELLOW}[!]${NC} VeeVee not found at $VEEVEE_DIR — skipping"
fi

# Stage Director :5174
if [ -f "$STAGE_DIR/package.json" ]; then
    echo -e "  ${GREEN}[+]${NC} Starting Stage Director → http://localhost:5174"
    osascript -e "tell app \"Terminal\" to do script \"cd '$STAGE_DIR' && npm run dev\"" 2>/dev/null \
        || (cd "$STAGE_DIR" && npm run dev &)
else
    echo -e "  ${YELLOW}[!]${NC} Stage Director not found at $STAGE_DIR — skipping"
fi

# FAL Studio :5175
if [ -f "$FAL_DIR/package.json" ]; then
    echo -e "  ${GREEN}[+]${NC} Starting FAL Studio   → http://localhost:5175"
    osascript -e "tell app \"Terminal\" to do script \"cd '$FAL_DIR' && npm run dev\"" 2>/dev/null \
        || (cd "$FAL_DIR" && npm run dev &)
else
    echo -e "  ${YELLOW}[!]${NC} FAL Studio not found at $FAL_DIR — skipping"
fi

# Open hub dashboard
sleep 3
echo ""
echo "  Opening launch dashboard..."
open "$HUB_DIR/index.html" 2>/dev/null || xdg-open "$HUB_DIR/index.html" 2>/dev/null

echo ""
echo "  All three servers launching. Close their Terminal tabs to stop."
echo ""
