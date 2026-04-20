@echo off
chcp 65001 >nul
title VT Studio - All Tools

echo.
echo  ========================================
echo    VT Studio Suite
echo    VeeVee  Stage Director  FAL Studio x2
echo  ========================================
echo.

set VEEVEE_DIR=E:\git_git\vt_VeeVee
set STAGE_DIR=E:\git_git\stage-director
set FAL_NEW_DIR=E:\git_git\vt_fal_studio
set FAL_LEG_DIR=E:\git_git\vt_fal_studio_app
set HUB_DIR=%~dp0

echo  Clearing ports 5173 / 5174 / 5175 / 3737...
for %%p in (5173 5174 5175 3737) do (
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%%p.*LISTENING" 2^>nul') do (
        taskkill /PID %%a /F >nul 2>&1
    )
)
echo  [OK] Ports cleared
echo.

if exist "%VEEVEE_DIR%\package.json" (
    echo  [1/4] VeeVee           -- http://localhost:5173
    start "VeeVee :5173" cmd /k "cd /d %VEEVEE_DIR% && npm run dev"
) else ( echo  [SKIP] VeeVee not found at %VEEVEE_DIR% )

if exist "%STAGE_DIR%\package.json" (
    echo  [2/4] Stage Director   -- http://localhost:5174
    start "Stage Director :5174" cmd /k "cd /d %STAGE_DIR% && npm run dev"
) else ( echo  [SKIP] Stage Director not found at %STAGE_DIR% )

if exist "%FAL_NEW_DIR%\package.json" (
    echo  [3/4] FAL Studio (new) -- http://localhost:5175
    start "FAL Studio new :5175" cmd /k "cd /d %FAL_NEW_DIR% && npm run dev"
) else ( echo  [SKIP] FAL Studio (new) not found at %FAL_NEW_DIR% )

if exist "%FAL_LEG_DIR%\server.js" (
    echo  [4/4] FAL Studio (leg) -- http://localhost:3737
    if not exist "%FAL_LEG_DIR%\dist" (
        echo       Building first...
        pushd "%FAL_LEG_DIR%" && call npm run build && popd
    )
    start "FAL Studio legacy :3737" cmd /k "cd /d %FAL_LEG_DIR% && node server.js"
) else ( echo  [SKIP] FAL Studio (legacy) not found at %FAL_LEG_DIR% )

echo.
echo  Waiting 4 seconds for servers to come up...
timeout /t 4 /nobreak >nul
start "" "%HUB_DIR%index.html"

echo.
echo  All tools launched in separate windows.
echo  Close those windows (or Ctrl+C) to stop each server.
echo.
pause
