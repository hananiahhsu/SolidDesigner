@echo off
echo "Automatically generate vs project by cmake.exe"


:: 检查是否已经以管理员权限运行
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Already running with elevated privileges.
    goto :continue
)

:: 以管理员权限重新运行脚本
echo Restarting script with elevated privileges...
powershell -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~dpnx0 & pause'"
exit /b


:continue

::切换到当前的工作目录，主要是CMAKE工作需要知道CMAKELISTS.TXT的路径
cd /d %~dp0 || (
    echo "Failed to change directory."
    pause
)

:: 平台
set BUILD_PLATFORM=x64


:: 检测编译目录是否存在
if exist "..\SolidDesigner_Build" (
    echo "Build directory already exists. Do you want to delete it? (Y/N)"
    set /p choice=
    if /i "%choice%"=="Y" (
        echo "Deleting existing build directory..."
        rmdir /s /q "..\SolidDesigner_Build"
        if errorlevel 1 (
            echo "Failed to delete existing build directory."
            pause
        ) else (
            echo "Build directory deleted successfully."
        )
    ) else (
        echo "Operation cancelled. Proceeding with CMake..."
    )
) else (
    echo "Build directory does not exist. Proceeding with CMake..."
)

:: 创建目录
echo "Create directory for build and installation"
cd ..
md SolidDesigner_Build
cd SolidDesigner_Build
md Install

:: 显示批处理脚本所在的完整路径
echo "The full path of bat is :"
echo %~dp0%
:: 显示当前的工作路径
echo "The current workdir is :"
echo %cd%

echo "Start to cmake... ..."

:: -B 指定工程的输出路径  -H 指定CMAKELIST.TXT的路径
..\SolidDesigner\ToolChain\cmake\bin\cmake.exe -B ..\SolidDesigner_Build -H..\SolidDesigner -DCMAKE_GENERATOR_PLATFORM=x64 -G "Visual Studio 15 2017"

if errorlevel 1 (
    echo "CMake failed."
    pause
)

echo "End Cmake work... ..."


"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Get-Process devenv -ErrorAction SilentlyContinue" >nul

if %errorlevel% neq 0 (
    echo "devenv.exe is not running. Starting a new instance..."
    echo "Opening Visual Studio..."
    ::start "" "%VS140COMNTOOLS%\..\IDE\devenv.exe" "%cd%\SolidDesigner.sln"
    start "" "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Enterprise\\Common7\\IDE\\devenv.exe" "%cd%\SolidDesigner.sln"
) else (
    echo "devenv.exe is already running with PID %vs_pid%. Proceeding to open project..."
)


echo "Success to finish cmake and open project... ..."
pause
exit /b 0