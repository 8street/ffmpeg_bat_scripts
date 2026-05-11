@echo off
chcp 65001 >nul
echo AV1 converter. 4K preset.
echo Use Vulkan driver. Nvidia >=4000 GPU needs.


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
"%ffmpeg%" -init_hw_device vulkan -hwaccel vulkan -hwaccel_output_format vulkan -i %1 -map_metadata 0 -c:v av1_vulkan -crf 45 -c:a copy -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause