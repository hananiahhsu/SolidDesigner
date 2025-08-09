##########################################################################################################
#--Date: 2021.03.10
#--Author:xu xu
#--Note:位于Designer,目的在于管理产品Designer
##########################################################################################################
message("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Start Designer~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

message("产品Designer current dir is: ")
message("${PROJECT_SOURCE_DIR}")

add_subdirectory(APP)
add_subdirectory(DB)
add_subdirectory(Interaction)
add_subdirectory(UI)


message("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~End Designer~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")













