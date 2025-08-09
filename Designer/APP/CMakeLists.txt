##########################################################################################################
#--Date: 2021.03.10
#--Author:xu xu
#--Note:位于Source目录下面
#--Note: @2023.01.24 调整注释的内容
##########################################################################################################
message(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Designer app Directory<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")

message("CMAKE_SOURCE_DIR == ")
message("${CMAKE_SOURCE_DIR}")
message("${CMAKE_CURRENT_SOURCE_DIR}")
add_definitions(-D_USRDLL)
add_definitions(-D_CRT_SECURE_NO_WARNINGS)
# 批量添加程序文件，包括源文件 头文件 资源文件等
# 注意路径是当前目录，不然的话文件无法正确添加到VS中
FILE(GLOB APP_FILES "${PROJECT_SOURCE_DIR}/Designer/APP/*.cpp" "${PROJECT_SOURCE_DIR}/Designer/APP/*.h")

FILE(GLOB SOURCE_CPP_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
FILE(GLOB HEADER_H_FILES   "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
FILE(GLOB HEADER_HPP_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")

# QT的资源文件-qrc,qml,ui,pro
FILE(GLOB RESOURCE_QRC_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.qrc")
FILE(GLOB RESOURCE_QML_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.qml")
FILE(GLOB RESOURCE_UI_FILES  "${CMAKE_CURRENT_SOURCE_DIR}/*.ui")
FILE(GLOB RESOURCE_PRO_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.pro")
FILE(GLOB RESOURCE_XML_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.xml")

#-----------------------------------------------------------------------------
# 软件的文件夹分层架构为UI,DB,INTERACTION三个层次；
# DB层不能引用下层的头文件，例如UI和交互层
# 哪些属于DB层：目前包含数学库，渲染核心组件，将来的业务层的DB层需要区别处理；
# 哪些属于UI层，目前把QT框架相关的代码和模块都放进来。
# 哪些属于交互层，具体来说就是设计命令的具体实现部分；
# 需要讨论的问题：命令管理器放在哪个层？
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
# 定义多个筛选器管理物理层次
# 筛选器规则: 第一个参数是筛选器的名称，第二个参数是标识符，第三个参数是筛选器下面的文件路径
# TMD浪费了一天的时间弄这个分类
#-----------------------------------------------------------------------------

# 添加筛选器--common
FILE(GLOB COMMONS "${CMAKE_CURRENT_SOURCE_DIR}/DB/common/*.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/DB/common/*.h" "${CMAKE_CURRENT_SOURCE_DIR}/DB/common/*.hpp")
source_group(DB\\COMMONS FILES ${COMMONS})

# 筛选器--maths
FILE(GLOB MATHS "${CMAKE_CURRENT_SOURCE_DIR}/DB/maths/*.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/DB/maths/*.h" "${CMAKE_CURRENT_SOURCE_DIR}/DB/maths/*.hpp")
source_group(DB\\MATHS FILES ${MATHS})

# 筛选器--shaders
FILE(GLOB SHADERS "${CMAKE_CURRENT_SOURCE_DIR}/DB/shaders/*.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/DB/shaders/*.hpp")
source_group(DB\\SHADERS FILES ${SHADERS})

# 筛选器--IO
FILE(GLOB IO "${CMAKE_CURRENT_SOURCE_DIR}/DB/io/*.cpp"  "${CMAKE_CURRENT_SOURCE_DIR}/DB/io/.h")
source_group(DB\\IO FILES ${IO})

# 筛选器--render
FILE(GLOB RENDER "${CMAKE_CURRENT_SOURCE_DIR}/DB/render/*.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/DB/render/.h")
source_group(DB\\RENDER FILES ${RENDER})

# 筛选器--sys
FILE(GLOB SYS  "${CMAKE_CURRENT_SOURCE_DIR}/DB/sys/*.cpp"  "${CMAKE_CURRENT_SOURCE_DIR}/DB/sys/.h")
source_group(DB\\SYS FILES ${SYS})

# 筛选器--gui
FILE(GLOB GUI 
 ${CMAKE_CURRENT_SOURCE_DIR}/UI/gui/se.h
 ${CMAKE_CURRENT_SOURCE_DIR}/UI/gui/se.cpp
 ${CMAKE_CURRENT_SOURCE_DIR}/UI/gui/gui_librarywidget.h
 ${CMAKE_CURRENT_SOURCE_DIR}/UI/gui/gui_librarywidget.cpp)

source_group(UI\\GUI FILES ${GUI})

#-----------------------------------------------------------------------------
# 头文件搜索路径
#-----------------------------------------------------------------------------
include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

include_directories(${PROJECT_SOURCE_DIR}/Alice/AliceBasicService/Public)
include_directories(${PROJECT_SOURCE_DIR}/Alice/AliceCommonApplication/Public)
include_directories(${PROJECT_SOURCE_DIR}/Alice/InteractionLayer/Interface/AliceApplicationInterface/Public)
include_directories(${PROJECT_SOURCE_DIR}/QtFrameWork/AliceUiFrameWork)
include_directories(${PROJECT_SOURCE_DIR}/QtFrameWork/AliceUiFrameWork/Public)

#-----------------------------------------------------------------------------
# 自动添加include目录
#-----------------------------------------------------------------------------
#由于生成的C++文件都是放在编译目录里的（在Shadow Building中有别于源码目录），
#所以还需要将编译目录包含到Include目录，否则编译器会找不到这些头文件：
set(CMAKE_INCLUDE_CURRENT_DIR ON)


#============================================================================#
#  给SolidRender这个工程配置第三方的库
#============================================================================#
set(CMAKE_PREFIX_PATH "C:/Qt/Qt5.13.2/5.13.2/msvc2015_64")
find_package(Qt5 COMPONENTS Core Gui Widgets NetWork Quick Qml REQUIRED)

# 设置QT的头文件包含路径
# 如果找不到环境变量QTDIR的路径，那么自己设置吧; 也可以在GUI交互界面上手动设置
SET(QTDIR C:/Qt/Qt5.13.2/5.13.2/msvc2015_64)

# QT5头文件路径
message("----------------qt5 files include directory--------------------")
include_directories(${QTDIR}/include)
include_directories(${QTDIR}/include/QtWidgets)
include_directories(${QTDIR}/include/QtCore)
include_directories(${QTDIR}/include/QtGui)
include_directories(${QTDIR}/include/QtOpenGL)
include_directories(${QTDIR}/include/QtMultimedia)
include_directories(${QTDIR}/include/QtQuick)
include_directories(${QTDIR}/include/QtQml)
include_directories(${QTDIR}/include/QtNetwork)
include_directories(${QTDIR}/mkspecs/win32-msvc2012)

#-----------------------------------------------------------------------------
# 添加需要链接的库文件目录LINK_DIRECTORIES
# 例如QT库
#-----------------------------------------------------------------------------
link_directories(${QTDIR}/lib)


#-----------------------------------------------------------------------------
#---------------------------第三方库的头文件和二进制文件----------------------
#-----------------------------------------------------------------------------
#@1. 指定第三方的头文件
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/freetype)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/glad)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/GLFW)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/glm)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/KHR)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/log4cplus)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/SFML)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/include/soil)
include_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/src)

#@2. 指定第三方库的路径
link_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/lib)
link_directories(${CMAKE_SOURCE_DIR}/externals/3rdParty/lib/sfml)

#@3. 指定exe的输出路径
message("可执行文件的输出路径：")
message(${PROJECT_SOURCE_DIR})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x64/Debug) 
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x64/Release) 
 
#@4. 指定自定义库的链接路径
#这个话会一次性添加两条路径，自动判断编译类型，智能！
#link_directories(${PROJECT_SOURCE_DIR}/bin)
message("链接库的路径：")
message("${CMAKE_BINARY_DIR}")
link_directories(${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE})


#-----------------------------------------------------------------------------
# 库文件链接路径<add_executable之前>
# link_libraries 不会为每个目标生成链接路径。而是直接添加库的名称。
#-----------------------------------------------------------------------------
message("当前的工程名称是: ")
message(${PROJECT_NAME})
link_libraries(glu32.lib)
link_libraries(glew32.lib)
link_libraries(opengl32.lib)
link_libraries(freeimage.lib)
link_libraries(log4cplusU.lib)
link_libraries(AliceCommonApplication.lib)
link_libraries(AliceApplicationInterface.lib)
link_libraries(AliceUiFrameWork.lib)
link_libraries(AliceBasicService.lib)
link_libraries(AliceComponentSystem.lib)
#-----------------------------------------------------------------------------
# 添加可执行程序目标
#-----------------------------------------------------------------------------
# 生成可执行文件,包括筛选器common[COMMON_CPP_FILES,COMMON_H_FILES,COMMON_HPP_FILES]等
# 程序源文件
# 头文件
# 资源文件-QRC,QML,UI,PRO,XML
# 筛选器-common-CPP,H,HPP文件
add_executable(${PROJECT_NAME} 
 ${SOURCE_CPP_FILES}
 ${HEADER_H_FILES}
 ${HEADER_HPP_FILES}
 ${RESOURCE_QRC_FILES}
 ${RESOURCE_QML_FILES}
 ${RESOURCE_UI_FILES}
 ${RESOURCE_PRO_FILES}
 ${RESOURCE_XML_FILES}
 ${COMMONS}
 ${GUI}
 ${IO}
 ${MATHS}
 ${RENDER}
 ${SHADERS}
 ${SYS}
 ${APP_FILES})


set_target_properties(${PROJECT_NAME} PROPERTIES FOLDER "Designer/APP")


set (CMAKE_INSTALL_PREFIX "${INSTALL_DIR}/INSTALL" CACHE INTERNAL "" FORCE)

# 把目标文件安装到指定的目录
message("install is ${INSTALL_DIR}")
install(TARGETS ${PROJECT_NAME} DESTINATION "${INSTALL_DIR}/INSTALL")

# 安装第三方库的DLL
install(DIRECTORY "${CMAKE_SOURCE_DIR}/externals/3rdParty/bin/" DESTINATION "${INSTALL_DIR}/INSTALL" FILES_MATCHING PATTERN "*.dll")

# 安装第三方库的头文件
install(DIRECTORY "${CMAKE_SOURCE_DIR}/externals/3rdParty/include" DESTINATION "${INSTALL_DIR}/INSTALL")

install(DIRECTORY "${CMAKE_SOURCE_DIR}/source/resource/data" DESTINATION "${INSTALL_DIR}/INSTALL")

install(DIRECTORY "${CMAKE_SOURCE_DIR}/source/resource/Script" DESTINATION "${INSTALL_DIR}/INSTALL")

set(CMAKE_GENERATOR_PLATFORM x64)
if(SOLIDRENDER_WIN)
    if("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "x64")
        #install(DIRECTORY "${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE}" DESTINATION "${INSTALL_DIR}/INSTALL" FILES_MATCHING PATTERN "*.dll" PATTERN "${CMAKE_BUILD_TYPE}" EXCLUDE)
        install(FILES "${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE}/CommandSystem.dll" DESTINATION "${INSTALL_DIR}/INSTALL" )
        install(FILES "${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE}/AlicePropertyBrowser.dll" DESTINATION "${INSTALL_DIR}/INSTALL" )
        install(FILES "${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE}/XFrameWork.dll" DESTINATION "${INSTALL_DIR}/INSTALL" )
        install(FILES "${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE}/XRibbonBar.dll" DESTINATION "${INSTALL_DIR}/INSTALL" )
        install(FILES "${CMAKE_BINARY_DIR}/x64/${CMAKE_BUILD_TYPE}/XToolbar.dll" DESTINATION "${INSTALL_DIR}/INSTALL" )
    endif()

    if("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "Win32")
        install(DIRECTORY "${CMAKE_BINARY_DIR}/x86/${CMAKE_BUILD_TYPE}"  DESTINATION "${INSTALL_DIR}/INSTALL")
    endif()

elseif(SOLIDRENDER_LINUX)  
    install(DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}"  DESTINATION "${INSTALL_DIR}/INSTALL")
endif()

message(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>End Designer APP<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")