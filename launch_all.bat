@echo off
chcp 65001 >nul
title VT Studio — All Tools

echo.
echo  ╔═══════════════════════════════════════════╗
echo  ║   VT Studio Suite                        ║
echo  ║   VeeVee · Stage Director · FAL Studio   ║
echo  ╚═══════════════════════════════════════════╝
echo.

set VEEVEE_DIR=E:\git_git\vt_VeeVee
set STAGE_DIR=E:\git_git\stage-director
set FAL_DIR=E:\git_git\vt_fal_studio
set HUB_DIR=%~dp0

:: ── Kill any stale processes on the three ports ──────────────────────────
echo  Clearing ports 5173 / 5174 / 5175...
for %%p in (5173 5174 5175) do (
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%%p.*LISTENING" 2^>nul') do (
        taskkill /PID %%a /F >nul 2>&1
    )
)

:: ── VeeVee :5173 ─────────────────────────────────────────────────────────
if not exist "%VEEVEE_DIR%\package.json" (
    echo  [WARN] VeeVee not found at %VEEVEE_DIR% — skipping
) else (
    echo  [+] Starting VeeVee       → http://localhost:5173
    start "VeeVee :5173" cmd /c "cd /d %VEEVEE_DIR% && npm run dev"
)

:: ── Stage Director :5174 ─────────────────────────────────────────────────
if not exist "%STAGE_DIR%\package.json" (
    echo  [WARN] Stage Director not found at %STAGE_DIR% — skipping
) else (
    echo  [+] Starting Stage Director → http://localhost:5174
    start "Stage Director :5174" cmd /c "cd /d %STAGE_DIR% && npm run dev"
)

:: ── FAL Studio :5175 ─────────────────────────────────────────────────────
if not exist "%FAL_DIR%\package.json" (
    echo  [WARN] FAL Studio not found at %FAL_DIR% — skipping
) else (
    echo  [+] Starting FAL Studio   → http://localhost:5175
    start "FAL Studio :5175" cmd /c "cd /d %FAL_DIR% && npm run dev"
)

:: ── Open hub dashboard ───────────────────────────────────────────────────
echo.
echo  Waiting 3 seconds for servers to start...
timeout /t 3 /nobreak >nul

echo  Opening launch dashboard...
start "" "%HUB_DIR%index.html"

echo.
echo  All three servers launching in separate windows.
echo  Close those windows to stop the servers.
echo.
pause
