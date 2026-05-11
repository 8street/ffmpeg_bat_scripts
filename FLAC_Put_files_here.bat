@echo off
chcp 65001 >nul
echo FLAC audio track converter in video.


@echo.

set "ffmpeg=%~dp0ffmpeg\ffmpeg.exe"

if "%~1"=="" (
    echo Put files on this script.

)

:loop
if "%~1"=="" goto :end1
echo Full path: %1
echo Filename: %~nx1
echo Directory path: %~dp1
set output_filename=%~n1_flac%~x1
"%ffmpeg%" -i %1 -map_metadata 0 -c:v copy -c:a flac -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause