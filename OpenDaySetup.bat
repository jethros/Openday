@echo off
REM Switch to the directory where this batch file is located
cd /d "%~dp0"

echo ==========================================
echo Setting up Open Day workspace...
echo ==========================================

REM 1. Clone the repository into a folder named "openday" (Primary source)
if not exist "openday" (
    echo Cloning repository...
    git clone https://github.com/jethros/Openday.git "openday"
) else (
    echo Directory "openday" already exists. Pulling latest updates or skipping clone...
    REM Optional: git -C "openday" pull
)

echo.
echo ==========================================
echo Managing Additional/Secondary Project Folder...
echo ==========================================

REM Check if the additional folder "openday_copy" already exists
if exist "openday_copy" (
    echo.
    echo The additional folder "openday_copy" already exists.
    choice /c E /n /m "Press 'e' to clear and replace the additional folder with a fresh copy from 'openday' (or wait/press to keep existing)..."
    if errorlevel 1 (
        echo.
        echo Closing any running Unity instances before resetting...
        taskkill /f /im Unity.exe >nul 2>&1
        
        echo Removing existing additional folder...
        rmdir /s /q "openday_copy"
        
        echo Copying fresh project from 'openday' to 'openday_copy'...
        xcopy /e /i /h "openday" "openday_copy" >nul
    )
) else (
    echo Creating additional folder and copying project for the first time...
    xcopy /e /i /h "openday" "openday_copy" >nul
)

echo.
echo ==========================================
echo Opening Word Document...
echo ==========================================

REM 2. Open the Word file called OpenDayUnityLite.docx
if exist "OpenDayUnityLite.docx" (
    start "" "OpenDayUnityLite.docx"
) else if exist "openday\OpenDayUnityLite.docx" (
    start "" "openday\OpenDayUnityLite.docx"
) else (
    echo Warning: OpenDayUnityLite.docx was not found in the root or cloned folder.
)

echo.
echo ==========================================
echo Locating Unity Editor and Scene...
echo ==========================================

REM 3. Find Unity.exe automatically from Unity Hub installations
set "UNITY_EXE="
for /d %%D in ("C:\Program Files\Unity\Hub\Editor\*") do (
    if exist "%%D\Editor\Unity.exe" (
        set "UNITY_EXE=%%D\Editor\Unity.exe"
    )
)
REM Fallback check for standard standalone installation
if not defined UNITY_EXE if exist "C:\Program Files\Unity\Editor\Unity.exe" (
    set "UNITY_EXE=C:\Program Files\Unity\Editor\Unity.exe"
)

if not defined UNITY_EXE (
    echo Error: Unity Editor installation could not be found automatically.
    goto :error
)

REM 4. Find the first .unity scene file inside the additional folder's Assets\Scenes\ directory
set "SCENE_PATH="
if exist "openday_copy\Assets\Scenes\" (
    for %%F in ("openday_copy\Assets\Scenes\*.unity") do (
        set "SCENE_PATH=%%F"
        goto :launch_unity
    )
)

echo Error: No .unity scene file found in openday_copy\Assets\Scenes\
goto :error

:launch_unity
echo.
echo ==========================================
echo Launching Unity Project and Scene from Additional Folder...
echo ==========================================
echo Launching: %SCENE_PATH%
start "" "%UNITY_EXE%" -projectPath "%~dp0openday_copy" -openFile "%SCENE_PATH%"
goto :end

:error
echo.
echo Setup finished with errors. Please check the messages above.

:end
echo.
echo Setup complete!
pause