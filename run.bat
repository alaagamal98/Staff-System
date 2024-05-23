@echo off

set build_dir=".\_build"

rem set the current folder to root dir of repo
cd %~dp0

echo [run.bat] configuring ...
cmake -B %build_dir% %generator% -DCMAKE_BUILD_TYPE=Release
if %ERRORLEVEL% EQU 0 (
    echo [run.bat] configuring succeeded!
) else (
    echo [run.bat] configuring failed!
    GOTO:_exit
)

echo [run.bat] building ...
cmake --build %build_dir% --config Release -j
if %ERRORLEVEL% EQU 0 (
    echo [run.bat] build succeeded!
) else (
    echo [run.bat] build failed!
    GOTO:_exit
)

set bin_dir=%build_dir:"=%\bin\release
echo [run.bat] binary directory is "%bin_dir%"

echo [run.bat] running the application ...
START /b /wait "" "%bin_dir%\StaffSystem"

:_exit
