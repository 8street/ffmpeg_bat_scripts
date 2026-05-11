@echo off
chcp 65001 >nul
echo Video converter in 1080p AV1 format.


@echo.

set "ffmpeg=%~dp0ffmpeg\ffmpeg.exe"
@echo "%ffmpeg%"


if "%~1"=="" (
    echo Put files on this script.

)

:loop
if "%~1"=="" goto :end1
echo Full path: %1
echo Filename: %~nx1
echo Directory path: %~dp1
set output_filename=%~n1_1080p_av1.MP4
"%ffmpeg%" -i %1 -map_metadata 0 -c:v libsvtav1 -crf 35 -svtav1-params "tune=1:film-grain=12:film-grain-denoise=0:mbr=8000" -vf "scale=-1:1080" -c:a copy -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause