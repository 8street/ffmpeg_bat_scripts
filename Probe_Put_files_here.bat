@echo off
chcp 65001 >nul
echo Probing.


@echo.

set "ffprobe=%~dp0ffmpeg\ffprobe.exe"

if "%~1"=="" (
    echo Put files on this script.
)

:loop
if "%~1"=="" goto :end1
echo Full path: %1
"%ffprobe%" %1
@echo.
@echo.
shift
goto :loop
:end1

pause


