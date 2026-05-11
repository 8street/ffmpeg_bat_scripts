@echo off
chcp 65001 >nul
echo TS to AV1 converter with deinterlacing. Audio converter in PCM_S24LE. 


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
"%ffmpeg%" -i %1 -map_metadata 0 -map 0 -vf yadif=1 -c:v libsvtav1 -crf 23 -svtav1-params "tune=1:film-grain=4:film-grain-denoise=0:mbr=30000" -c:a pcm_s24le -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause