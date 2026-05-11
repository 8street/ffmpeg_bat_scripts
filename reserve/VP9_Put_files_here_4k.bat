@echo off
chcp 65001 >nul
echo VP9 video converter.


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
set output_filename=%~n1_vp9.MP4
"%ffmpeg%" -i %1 -map_metadata 0 -c:v libvpx-vp9 -crf 45 -b:v 0 -c:a copy -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause