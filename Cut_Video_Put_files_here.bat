@echo off
chcp 65001 >nul
echo Cut video without coding.



set "start_cut=00:00:48"
set "end_cut=00:01:52"


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
set output_filename=%~n1_cut%~x1
echo "%output_filename%"
"%ffmpeg%" -i %1 -map_metadata 0 -ss %start_cut% -to %end_cut% -c copy "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause