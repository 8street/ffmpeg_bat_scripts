@echo off
setlocal enableextensions enabledelayedexpansion
chcp 65001 >nul
echo Add audio track to video file with mixing.

@echo.

if "%~2"=="" (
    echo Put video and audio files on to this script. 
    goto :end1
)

set "ffmpeg=%~dp0ffmpeg\ffmpeg.exe"

set "volume_audio=1.0"
set "volume_video=0.35"

set "ext=%~x1"
if /i "%ext%"==".mp4" goto :video
if /i "%ext%"==".mvi" goto :video
if /i "%ext%"==".mov" goto :video
if /i "%ext%"==".mkv" goto :video
if /i "%ext%"==".avi" goto :video
goto :audio

:video
set "vid=%1"
set "aud=%2"
set output_filename=%~n1_added%~x1
goto :end_if

:audio
set "vid=%2"
set "aud=%1"
set "output_filename=%~n2_added%~x2"
:end_if

echo Concatenate:
echo Video: "%vid%"
echo Audio: "%aud%"
echo Output file: "%output_filename%"

:: add audio
"%ffmpeg%" -i %vid% -i %aud% -filter_complex "[0:a]volume=%volume_video%[a1]; [1:a]volume=%volume_audio%[a2]; [a1][a2]amix=inputs=2:duration=first[a]" -map 0:v -map "[a]" -map 0:a -c:v copy -c:a aac -map_metadata 0 -dn "%output_filename%"

:end1

endlocal


@echo.
@echo.

pause
