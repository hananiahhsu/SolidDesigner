##########################################################################################################
#--Date:    2021.03.10
#--Project: SolidRender
#--Author:  xu xu
#--Note:位于SolidRender顶级目录下面
#--2021.10.03: 增加INSTALL项目，实现工程的自动安装功能
#              今日对工程的生成目录做重大调整，以后禁止VS工程的路径与源码同目录
##########################################################################################################
message("*--*--*--*--*--*--*--*--*--*--*--*--Start Top Level CmakeList*--*--*--*--*--*--*--*--*--*--*--*")

#-----------------------------------------------------------------------------
# 工程属性设置
#-----------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
# 设置项目名称 语言
project(SolidDesigner VERSION 1.1.0  LANGUAGES CXX  DESCRIPTION "SolidRender is a parametric modeling software")

#-----------------------------------------------------------------------------
# 编译系统设置
#-----------------------------------------------------------------------------
# 指定是否使用编译器特定的扩展
set(CMAKE_CXX_EXTENSIONS OFF)

#设置C++标准
set(CMAKE_CXX_STANDARDS 11)

# 是否强制要求C++标准为${CMAKE_CXX_STANDARD},如果为OFF则可能使用旧的标准
set(CMAKE_CXX_STANDARD_REQUIRED YES)

#VS /MT模式的设置
message("The cmake source dir is:")
message("${CMAKE_SOURCE_DIR}")

set(CMAKE_USE_MAKE_RULES_OVERRIDE
    "${CMAKE_SOURCE_DIR}/cmake/c_flag_overrides.cmake")

set(CMAKE_USE_MAKE_RULES_OVERRIDE_CXX
    "${CMAKE_SOURCE_DIR}/cmake/cxx_flag_overrides.cmake")

#-----------------------------------------------------------------------------
# 检测操作系统
#-----------------------------------------------------------------------------
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(SOLIDRENDER_LINUX True)
    
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(SOLIDRENDER_WIN True)
    # if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
        # set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/INSTALL" CACHE PATH "${PROJECT_NAME}的安装路径" FORCE)
    # endif()
else()
    message(SEND_ERROR, "No Support System!")
endif()


#-----------------------------------------------------------------------------
# 指定编译选项
#-----------------------------------------------------------------------------
#设置编译类型，此处需要考虑多种编译选项
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE debug)
endif()

set(CMAKE_EXE_LINKER_FLAGS "/machine:x64")

if(MSVC)
    add_definitions(-DUNICODE -D_UNICODE)
endif()


#配置项目的安装选项
message("The project binary dir is:")
message("${PROJECT_BINARY_DIR}")
message("The current binary dir is:")
message("${CMAKE_CURRENT_BINARY_DIR}")
message("The cmake install bin dir is:")
message("${CMAKE_INSTALL_BINDIR}")
message("The cmake install prefix is:")
message("${CMAKE_INSTALL_PREFIX}")
message("The cmake binary dir is:")
message("${CMAKE_BINARY_DIR}")


#-----------------------------------------------------------------------------
# 定义变量作为项目的安装路径
#-----------------------------------------------------------------------------
#隐藏CMAKE_INSTALL_PREFIX宏
# set (CMAKE_INSTALL_PREFIX "${INSTALL_DIR}" CACHE INTERNAL "" FORCE)
# message("${CMAKE_INSTALL_PREFIX}")

# 安装路径预定义
if (NOT DEFINED INSTALL_DIR)
    message("install dir is not defined")
    # 设置Windows环境下的默认安装路径
    if (WIN32 AND NOT DEFINED CMAKE_INSTALL_PREFIX)
      message("set cmake install prefix macro")
      set (CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}")
    endif()
      message("set the value of install dir")
    # 设置安装路径
    set (INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}" CACHE PATH "")
else()
  message("The definition of install dir exists already")
  set (INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}" CACHE PATH "SolidRender的预设安装目录" FORCE)
  message("${INSTALL_DIR}")
endif()


#-----------------------------------------------------------------------------
# 定义项目构建中间文件的生成目录
#-----------------------------------------------------------------------------
set(CMAKE_GENERATOR_PLATFORM x64)
if(SOLIDRENDER_WIN)
    if("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "x64")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x64/Debug)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x64/Debug)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x64/Debug)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x64/Release)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x64/Release)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x64/Release)
    endif()

    if("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "Win32")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x86/Debug)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x86/Debug)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/x86/Debug)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x86/Release)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x86/Release)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/x86/Release)
    endif()

elseif(SOLIDRENDER_LINUX)  
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})
endif()

#-----------------------------------------------------------------------------
# 从系统查找Qt模块,开启Qt中间文件的自动生成
#-----------------------------------------------------------------------------
#设置QT5的库路径
# set(Qt5_FOUND false)
# set(CMAKE_PREFIX_PATH $ENV{QTDIR})
# message("ENVIRONMENT PATH OF QT IS ${CMAKE_PREFIX_PATH}")
#set(Qt5_DIR "${CMAKE_PREFIX_PATH}/lib/cmake/Qt5")
#Qt程序中的QRC资源文件需要用rcc来进行预处理，生成相应.h和.cpp文件。
#QObject派生的C++类也需要通过moc进行处理。
#这些都是编译系统中所谓的Rules。
#CMake中通过打开下面两个选项可以自动对这些后缀的文件进行相应处理
# set(CMAKE_AUTOMOC ON)
# set(CMAKE_AUTORCC ON)
# set(CMAKE_AUTOUIC ON)


#----------------------------------------------------------------------------
# 开启项目分组
#----------------------------------------------------------------------------
# option 目录定义了一个变量叫做USE_SOLUTION_FOLDERS，并给了初始值ON
option(USE_SOLUTION_FOLDERS "使用资源管理器文件夹" ON)
if(USE_SOLUTION_FOLDERS)
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
  set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMakeTargets")
endif()

#-----------------------------------------------------------------------------
# 定义全局的链接路径
#-----------------------------------------------------------------------------
set(ALICE_LibDir, ${CMAKE_BINARY_DIR}/${Alice}/${Configuration})


#-----------------------------------------------------------------------------
# 定义GNU标准的安装目录（GNUInstallDirs.cmake）
#-----------------------------------------------------------------------------
include(GNUInstallDirs)
set(CMAKE_INSTALL_LIBDIR "lib")


#-----------------------------------------------------------------------------
# 定义源代码的路径
#-----------------------------------------------------------------------------
# APPS 目录
add_subdirectory(Designer)

# QtFrameWork框架
add_subdirectory(QtFrameWork)

# 平台层
add_subdirectory(Alice)

# 外部项目(包括第三方库)
add_subdirectory(externals)

# 单元测试
add_subdirectory(UnitTest)

message("*--*--*--*--*--*--*--*--*--*--*--End Top Level CmakeList--*--*--*--*--*--*--*--*--*--*--*--*--*")