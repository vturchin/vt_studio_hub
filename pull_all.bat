@echo off
chcp 65001 >nul
title VT Studio — Pull All

echo.
echo  ╔══════════════════════════════════════╗
echo  ║   VT Studio — Pull Latest           ║
echo  ╚══════════════════════════════════════╝
echo.

call :pull "vt_VeeVee"       "E:\git_git\vt_VeeVee"          "main"
call :pull "Stage Director"  "E:\git_git\stage-director"      "master"
call :pull "FAL Studio (new)""E:\git_git\vt_fal_studio"       "master"
call :pull "FAL Studio (leg)""E:\git_git\vt_fal_studio_app"   "experimental"
call :pull "Studio Hub"      "%~dp0"                          "master"

echo.
echo  All repos up to date.
pause
exit /b

:pull
set LABEL=%~1
set DIR=%~2
set BRANCH=%~3
if not exist "%DIR%\.git" ( echo  [SKIP] %LABEL% — not a git repo & exit /b )
echo  [%LABEL%]
pushd "%DIR%"
git fetch origin >nul 2>&1
git pull origin %BRANCH% 2>&1 | findstr /V "^$"
popd
echo.
exit /b
