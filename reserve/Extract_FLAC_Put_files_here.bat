@echo off
chcp 65001 >nul
echo Extract audio track in FLAC format from video.


@echo.

set "ffmpeg=%~dp0ffmpeg\ffmpeg.exe"

if "%~1"=="" (
    echo Put files to this script.

)

:loop
if "%~1"=="" goto :end1
echo Full path: %1
echo Filename: %~nx1
echo Directory path: %~dp1
set output_filename=%~n1.flac
"%ffmpeg%" -i %1 -vn -c:a flac -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause