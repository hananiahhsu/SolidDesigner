#pragma once
// 此头文件包含DLL导出的宏
#include "AliceMacroDefines.h"
#include <iostream>
#ifdef ALICE_UI_ROBOT_HOME
#define ALICE_UI_ROBOT_EXPORT DLL_EXPORT
#else
#define ALICE_UI_ROBOT_EXPORT DLL_IMPORT
#endif


namespace
{
    void InitTest()
    {
        int i = 0;
        std::cout << "Here is init test..." << std::endl;
    }

    void UnInitTest()
    {
        int i = 0;
        std::cout << "Here is uninit test..." << std::endl;
    }
}


extern "C" void InitializePlugin()
{
    InitTest();
}


extern "C" void UnInitializePlugin()
{
    UnInitTest();
}



