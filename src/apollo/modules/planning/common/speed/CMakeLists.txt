cmake_minimum_required(VERSION 3.5.1)

add_library(planning_st_point st_point.cc)
target_link_libraries(planning_st_point common::math
                                        ${gflags_LIBRARIES})
add_library(planning::st_point ALIAS planning_st_point)

add_library(planning_st_boundary st_boundary.cc)
target_link_libraries(planning_st_boundary planning::st_point
                                           cyber::common
                                           planning::planning_gflags
                                           planning::proto)
add_library(planning::st_boundary ALIAS planning_st_boundary)


add_library(planning_speed_data speed_data.cc)
target_link_libraries(planning_speed_data planning::st_point
                                          common::math
                                          common::proto
                                          common::util
                                          planning::planning_gflags
                                          planning::proto
                                          ${gflags_LIBRARIES})
add_library(planning::speed_data ALIAS planning_speed_data)


add_executable(st_boundary_test st_boundary_test.cc)
target_link_libraries(st_boundary_test planning::st_boundary
                                       cyber::common
                                       common::time
                                       common::util
                                       gtest
                                       gtest_main)

add_library(planning_common_speed_module INTERFACE)
target_link_libraries(planning_common_speed_module INTERFACE
        planning_st_point
        planning_st_boundary
        planning_speed_data)

install(TARGETS planning_st_point
                planning_st_boundary
                planning_speed_data
                planning_common_speed_module
        export apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS st_boundary_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
