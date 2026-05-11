@echo off
setlocal enableextensions enabledelayedexpansion
chcp 65001 >nul
echo Concat files.

@echo.

if "%~2"=="" (
    echo Put two or more files on this script.
    goto :end1
)

set "ffmpeg=%~dp0ffmpeg\ffmpeg.exe"
set "fflist=%~dp0resources\concat_list.txt"
set "ffsort=%~dp0resources\concat_sort.txt"

copy nul "%fflist%"

echo Concatenate:
:loop
if "%~1"=="" goto :end_loop
echo Full path: %1
set output_filename=%~n1_concat%~x1
echo file '%~1%'>>"!fflist!"
shift
goto :loop
:end_loop

sort "%fflist%" > "%ffsort%"

"%ffmpeg%" -f concat -safe 0 -i "%ffsort%" -map_metadata 0 -map 0 -dn -c copy -ignore_unknown "%output_filename%"

:end1

endlocal


@echo.
@echo.

pause
