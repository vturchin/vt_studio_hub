@echo off
chcp 65001 >nul
title VT Studio — Push All

echo.
echo  ╔══════════════════════════════════════╗
echo  ║   VT Studio — Push All Changes      ║
echo  ╚══════════════════════════════════════╝
echo.

:: Ask for one commit message used across all repos that have changes
set /p MSG=  Commit message (leave blank to auto-name per repo):

echo.

call :push "vt_VeeVee"        "E:\git_git\vt_VeeVee"         "main"
call :push "Stage Director"   "E:\git_git\stage-director"     "master"
call :push "FAL Studio (new)" "E:\git_git\vt_fal_studio"      "master"
call :push "FAL Studio (leg)" "E:\git_git\vt_fal_studio_app"  "experimental"
call :push "Studio Hub"       "%~dp0"                         "master"

echo.
echo  Done.
pause
exit /b

:push
set LABEL=%~1
set DIR=%~2
set BRANCH=%~3
if not exist "%DIR%\.git" ( echo  [SKIP] %LABEL% — not a git repo & exit /b )
pushd "%DIR%"

:: Check for any uncommitted changes
git status --porcelain >nul 2>&1
for /f "tokens=*" %%s in ('git status --porcelain 2^>nul') do set HAS_CHANGES=1

if not defined HAS_CHANGES (
    echo  [%LABEL%] nothing to commit — pushing any unpushed commits...
    git push origin %BRANCH% 2>&1 | findstr /V "^$"
    set HAS_CHANGES=
    popd & exit /b
)

:: Stage everything and commit
git add .
if "%MSG%"=="" (
    git commit -m "Updates — %DATE% %TIME:~0,5%" 2>&1 | findstr /V "^$"
) else (
    git commit -m "%MSG%" 2>&1 | findstr /V "^$"
)
git push origin %BRANCH% 2>&1 | findstr /V "^$"
echo  [%LABEL%] pushed to %BRANCH%
set HAS_CHANGES=
popd
echo.
exit /b
