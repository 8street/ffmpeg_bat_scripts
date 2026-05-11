@echo off
chcp 65001 >nul
echo AV1 video converter with settings.
@echo.

if "%~1"=="" (
    echo Put files on this script.
    goto :end1
)
set "ffmpeg=%~dp0ffmpeg\ffmpeg.exe"

:quality: values 1-63. 18-22 - high quality. 35 - default. 45 - low quality
:resolution: vertical video resolution, values: 320, 480, 720, 1080, 1440, 2160
:brightness: values from -1.0 to 1.0 (default 0)
:contrast: from -2.0 to 2.0 (value >1.0 increase contrast)
:saturation: from 0 to 3.0 (default 1.0)
:sharp: from 0.0 to 1.0 (usually 0.5-0.7 is enough)
:rotate: y - rotate clockvise by 90
:rot_angle: 0 - counterclockwise and mirror, 1 - clockvise, 2 - counterclockwise, 3 - clockwise and mirror
:test: y - convert only the beginning of the video, the duration is set by the following parameter
:test_duration: from 0 to 99999 - the time to be compressed during testing

set "quality=35"
set "resolution=1080"
set "brightness=0.0"
set "contrast=1.00"
set "saturation=1.0"
set "sharp=0.7"
set "rotate=n"
set "rot_angle=1"
set "test=n"
set "test_duration=10"

if /i "%test%"=="y" (
    set "t_long= -ss 00:00:00 -t %test_duration%"
    set "t_name=_test"
) 
if /i "%rotate%"=="y" set "rot=,transpose=%rot_angle%"
set /a "mbr=%resolution%*7"

:loop
if "%~1"=="" goto :end1
echo Full path: %1
echo Filename: %~nx1
echo Directory path: %~dp1
set output_filename=%~n1_%resolution%_av1%t_name%.MP4
"%ffmpeg%" -i %1 -map_metadata 0%t_long% -c:v libsvtav1 -crf %quality% -svtav1-params "tune=1:film-grain=8:film-grain-denoise=0:mbr=%mbr%" -vf "eq=brightness=%brightness%:contrast=%contrast%:saturation=%saturation%,cas=strength=%sharp%,scale=-1:%resolution%%rot%" -c:a copy -map 0 -dn "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause