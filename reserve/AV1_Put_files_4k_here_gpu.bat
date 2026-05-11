@echo off
chcp 65001 >nul
echo AV1 converter. 4K preset.
echo Nvidia >=4000 GPU needs.

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
set output_filename=%~n1_av1.MP4
"%ffmpeg%" -hwaccel cuda -hwaccel_output_format cuda -i %1 -map_metadata 0 -c:v av1_nvenc -crf 45 -c:a copy -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause