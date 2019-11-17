cmake_minimum_required(VERSION 3.5.1)

add_library(planning_util_lib util.cc)
target_link_libraries(planning_util_lib
    cyber::common
    common::util
    common::vehicle_state_provider
    planning::planning_gflags
    planning::reference_line_info
    planning::proto
    routing::proto)
add_library(planning::util_lib ALIAS planning_util_lib)


add_library(planning_common_lib common.cc)
target_link_libraries(planning_common_lib
    cyber::common
    common::util
    planning::frame
    planning::reference_line_info)
add_library(planning::common_lib ALIAS planning_common_lib)

add_library(planning_common_util_module INTERFACE)
target_link_libraries(planning_common_util_module INTERFACE
    planning_util_lib
    planning_common_lib)
install(TARGETS planning_util_lib
                planning_common_lib
                planning_common_util_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )