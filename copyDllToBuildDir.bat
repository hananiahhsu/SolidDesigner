@echo off
echo "Copying dlls to execution directory"


rem 获取项目CMakeLists.txt文件所在目录的名称，用于新建构建目录
for /f "delims=" %%i in ("%cd%") do set CURRENT_DIR_NAME=%%~ni

rem 到项目CMakeLists.txt文件所在目录的上级目录
cd..

rem 获取当前目录，%cd%与%~dp0的区别在于获取的目录尾部少了“\”
set CURRENT_DIR=%cd%

rem 设置需要外部构建的目录名称，在源文件目录后面加“_build”
set PROJECT_NAME=%CURRENT_DIR_NAME%_build


rem 设置外部构建的完整路径
set CURRENT_NEW_DIR=%CURRENT_DIR%\%PROJECT_NAME%



cd /d %~dp0
::--Release
xcopy .\externals\3rdParty\bin\glew32.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\freeimage.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\msvcp140_app.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\vcruntime140_app.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\log4cplusU.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r

::----debug
xcopy .\externals\3rdParty\bin\glew32.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\freeimage.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\msvcp140_app.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\vcruntime140_app.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\log4cplusU.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r

::--Release
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Core.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Gui.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5OpenGL.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Widgets.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Network.dll %CURRENT_NEW_DIR%\x64\Release /s /e /c /y /h /r

::----debug
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Core.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Gui.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5OpenGL.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Widgets.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Network.dll %CURRENT_NEW_DIR%\x64\Debug /s /e /c /y /h /r

::拷贝source/resource目录下所有的资源到bin目录
xcopy .\source\resource\*.*  %CURRENT_NEW_DIR%\x64\Release\   /s /h 
xcopy .\source\resource\*.*  %CURRENT_NEW_DIR%\x64\Debug\   /s /h 

pause
exit