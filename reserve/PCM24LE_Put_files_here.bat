@echo off
chcp 65001 >nul
echo Audio converter in PCM_s24le format in videofile.


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
set output_filename=%~n1_pcm24%~x1
"%ffmpeg%" -i %1 -map_metadata 0 -c:v copy -c:a pcm_s24le -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause