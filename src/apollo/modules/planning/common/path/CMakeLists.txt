cmake_minimum_required(VERSION 3.5.1)

add_library(planning_discretized_path discretized_path.cc)
target_link_libraries(planning_discretized_path common::math
                                                common::proto)
add_library(planning::discretized_path ALIAS planning_discretized_path)


add_library(planning_frenet_frame_path frenet_frame_path.cc)
target_link_libraries(planning_frenet_frame_path common::math
                                                 planning::proto)
add_library(planning::frenet_frame_path ALIAS planning_frenet_frame_path)


add_library(planning_path_data path_data.cc)
target_link_libraries(planning_path_data common::math
                                         planning::discretized_path
                                         planning::frenet_frame_path
                                         planning::planning_gflags
                                         planning::reference_line)
add_library(planning::path_data ALIAS planning_path_data)

add_executable(discretized_path_test discretized_path_test.cc)
target_link_libraries(discretized_path_test planning::discretized_path
                                            common::util
                                            gtest
                                            gtest_main)

add_executable(frenet_frame_path_test frenet_frame_path_test.cc)
target_link_libraries(frenet_frame_path_test planning::frenet_frame_path
                                             gtest
                                             gtest_main)

add_library(planning_common_path_module INTERFACE)
target_link_libraries(planning_common_path_module INTERFACE
        planning_discretized_path
        planning_frenet_frame_path
        planning_path_data)

install(TARGETS planning_discretized_path
                planning_frenet_frame_path
                planning_path_data
                planning_common_path_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(discretized_path_test
        frenet_frame_path_test
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
