@echo off
echo "Copying dlls to execution directory"
cd /d %~dp0
::--Release
xcopy .\externals\3rdParty\bin\glew32.dll .\bin\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\freeimage.dll .\bin\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\msvcp140_app.dll .\bin\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\vcruntime140_app.dll .\bin\Release /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\log4cplusU.dll .\bin\Release /s /e /c /y /h /r

::----debug
xcopy .\externals\3rdParty\bin\glew32.dll .\bin\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\freeimage.dll .\bin\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\msvcp140_app.dll .\bin\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\vcruntime140_app.dll .\bin\Debug /s /e /c /y /h /r
xcopy .\externals\3rdParty\bin\log4cplusU.dll .\bin\Debug /s /e /c /y /h /r

::--Release
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Core.dll .\bin\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Gui.dll .\bin\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5OpenGL.dll .\bin\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Widgets.dll .\bin\Release /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Network.dll .\bin\Release /s /e /c /y /h /r

::----debug
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Core.dll .\bin\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Gui.dll .\bin\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5OpenGL.dll .\bin\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Widgets.dll .\bin\Debug /s /e /c /y /h /r
xcopy C:\Qt\Qt5.13.2\5.13.2\msvc2015_64\bin\Qt5Network.dll .\bin\Debug /s /e /c /y /h /r

::拷贝source/resource目录下所有的资源到bin目录
xcopy .\source\resource\*.*  .\bin\Release\   /s /h 


pause
exit