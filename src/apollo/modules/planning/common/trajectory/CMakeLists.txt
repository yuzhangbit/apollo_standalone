cmake_minimum_required(VERSION 3.5.1)

add_library(planning_discretized_trajectory discretized_trajectory.cc)
target_link_libraries(planning_discretized_trajectory common::math
                                                      common::proto
                                                      common::vehicle_state_proto
                                                      planning::planning_context)
add_library(planning::discretized_trajectory ALIAS planning_discretized_trajectory)



add_library(planning_publishable_trajectory publishable_trajectory.cc)
target_link_libraries(planning_publishable_trajectory planning::discretized_trajectory
                                                      cyber::common
                                                      planning::proto)
add_library(planning::publishable_trajectory ALIAS planning_publishable_trajectory)


add_executable(discretized_trajectory_test discretized_trajectory_test.cc)
target_link_libraries(discretized_trajectory_test planning::discretized_trajectory
                                                  common::util
                                                  cyber::common
                                                  gtest
                                                  gtest_main)


add_executable(publishable_trajectory_test discretized_trajectory_test.cc)
target_link_libraries(publishable_trajectory_test
    planning::publishable_trajectory
    common::util
    gtest
    gtest_main)
install(TARGETS planning_discretized_trajectory
                planning_publishable_trajectory
                discretized_trajectory_test
                publishable_trajectory_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
