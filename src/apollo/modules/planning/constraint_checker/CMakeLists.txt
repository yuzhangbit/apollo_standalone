cmake_minimum_required(VERSION 3.5.1)

add_library(planning_constraint_checker constraint_checker.cc)
target_link_libraries(planning_constraint_checker
    cyber::common
    common::proto
    common::vehicle_state_provider
    planning::planning_gflags
    planning::discretized_trajectory)
add_library(planning::constraint_checker ALIAS planning_constraint_checker)

add_library(planning_constraint_checker1d constraint_checker1d.cc)
target_link_libraries(planning_constraint_checker1d
    cyber::common
    planning::frame
    planning::planning_gflags
    planning::discretized_trajectory
    planning::curve1d)
add_library(planning::constraint_checker1d ALIAS planning_constraint_checker1d)

add_library(planning_collision_checker collision_checker.cc)
target_link_libraries(planning_collision_checker
    cyber::common
    common::vehicle_config_helper
    common::geometry
    common::path_matcher
    planning::frame
    planning::obstacle
    planning::discretized_trajectory
    planning::path_time_graph
    prediction::proto)
add_library(planning::collision_checker ALIAS planning_collision_checker)

add_library(planning_constraint_checker_module INTERFACE)
target_link_libraries(planning_constraint_checker_module INTERFACE
    planning_constraint_checker
    planning_constraint_checker1d
    planning_collision_checker)

install(TARGETS planning_constraint_checker
                planning_constraint_checker1d
                planning_collision_checker
                planning_constraint_checker_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

