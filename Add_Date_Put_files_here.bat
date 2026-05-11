@echo off
chcp 65001 >nul
echo Add date to filename.

@echo.

if "%~1"=="" (
    echo Put files on this script.
    goto :end1
)

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "mydate=%datetime:~0,4%%datetime:~4,2%%datetime:~6,2%"
echo Date: %mydate%

:loop
if "%~1"=="" goto :end1
set "output_filename=%~n1_%mydate%%~x1"
echo Full Path: %1
echo New Filename: "%output_filename%"
ren %1 "%output_filename%"
@echo.
@echo.
shift
goto :loop
:end1

pause