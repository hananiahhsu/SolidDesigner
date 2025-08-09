##########################################################################################################
#--Date:    2023.02.19
#--Project: pugixml
#--Author:  xu xu
##########################################################################################################
message("=====================================Start pugixml=======================================")
message("${PROJECT_SOURCE_DIR}")

add_definitions(-D_WINDOWS)

FILE(GLOB SOURCE_CPP_FILES "${PROJECT_SOURCE_DIR}/Externals/pugixml/*.cpp")
FILE(GLOB HEADER_H_FILES   "${PROJECT_SOURCE_DIR}/Externals/pugixml/*.hpp")

source_group("Header Files" FILES ${HEADER_H_FILES})
source_group("Source Files" FILES ${SOURCE_CPP_FILES})


#-----------------------------------------------------------------------------
# @ 设置制品的输出路径
# @ 定义项目构建中间文件的生成目录
# @ 必须放在add_library之前，否则无效
#-----------------------------------------------------------------------------
#set(SOLIDRENDER_WIN true)
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
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/${CMAKE_INSTALL_LIBDIR})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/${CMAKE_INSTALL_LIBDIR})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/${CMAKE_INSTALL_BINDIR})
endif()

#=============================================================================
#指定工程为动态库程序
add_library(pugixml SHARED ${HEADER_H_FILES} ${SOURCE_CPP_FILES} )

set_target_properties(pugixml PROPERTIES FOLDER "Externals")
#=============================================================================

#-----------------------------------------------------------------------------
# 头文件搜索路径
#-----------------------------------------------------------------------------
include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

#-----------------------------------------------------------------------------
# 根据系统及机器位数设置链接的位数
# 必须放在link之后,否则设置无效
#-----------------------------------------------------------------------------
set(CMAKE_SHARED_LINKER_FLAGS "/machine:x64")


if(WIN32)
    # include the major version number in Windows shared library names (but not import library names)
    set_target_properties(pugixml PROPERTIES DEBUG_POSTFIX "")
    set_target_properties(pugixml PROPERTIES SUFFIX "${CMAKE_SHARED_LIBRARY_SUFFIX}")
else()
    set_target_properties(pugixml PROPERTIES DEBUG_POSTFIX "d")
endif()
if (WIN32 AND MINGW)
    # on Windows/gcc get rid of "lib" prefix for shared libraries,
    # and transform the ".dll.a" suffix into ".a" for import libraries
    set_target_properties(pugixml PROPERTIES PREFIX "")
    set_target_properties(pugixml PROPERTIES IMPORT_SUFFIX ".a")
endif()


message("=====================================End pugixml==========================================")