@echo off
chcp 65001 >nul
echo H265 HEVC converter.
echo Nvidia GPU needs.

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
set output_filename=%~n1_h265.MP4
"%ffmpeg%" -hwaccel cuda -hwaccel_output_format cuda -i %1 -map_metadata 0 -c:v hevc_nvenc -preset slow -b:v 8000k -c:a copy -map 0 -dn -tag:v hvc1 "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause