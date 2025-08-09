#!/bin/bash
echo "Automatically generate vs project by cmake"

# 切换到当前的工作目录
cd "$(dirname "$0")" || {
    echo "Failed to change directory."
    exit 1
}

# 删除旧的编译目录
if [ -d "../SolidDesigner_Build" ]; then
    echo "Build directory already exists. Do you want to delete it? (Y/N)"
    read -r choice
    if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
        echo "Deleting existing build directory..."
        rm -rf "../SolidDesigner_Build"
        if [ $? -ne 0 ]; then
            echo "Failed to delete existing build directory."
            exit 1
        else
            echo "Build directory deleted successfully."
        fi
    else
        echo "Operation cancelled. Proceeding with CMake..."
    fi
else
    echo "Build directory does not exist. Proceeding with CMake..."
fi

# 创建目录
echo "Create directory for build and installation"
cd ..
mkdir -p SolidDesigner_Build
cd SolidDesigner_Build
mkdir Install

# 显示路径
echo "The full path of script is : $(pwd)"
echo "The current workdir is : $(pwd)"

# 执行 CMake
echo "Start to cmake... ..."
cmake -B ../SolidDesigner_Build -H../SolidDesigner -DCMAKE_GENERATOR_PLATFORM=x64 -G "Unix Makefiles"
if [ $? -ne 0 ]; then
    echo "CMake failed."
    exit 1
fi

echo "End Cmake work... ..."

# 编译项目
echo "Start building project... ..."
cd ../SolidDesigner_Build
make
if [ $? -ne 0 ]; then
    echo "Build failed."
    exit 1
fi

echo "End building project... ..."

# 打开项目（此处为示例，您需要根据实际情况提供正确的命令）
echo "Opening Visual Studio..."
# 由于在 Linux 上无法直接打开 Visual Studio，您需要使用其他编辑器或 IDE，如 VS Code、CLion 等
echo "Please provide the correct command to open the project."

echo "Success to finish cmake and build project... ..."
exit 0
