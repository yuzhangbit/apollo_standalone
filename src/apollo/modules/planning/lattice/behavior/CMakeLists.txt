cmake_minimum_required(VERSION 3.5.1)

add_library(planning_path_time_graph path_time_graph.cc)
target_link_libraries(planning_path_time_graph
    cyber::common
    common::linear_interpolation
    common::path_matcher
    common::proto
    planning::frame
    planning::obstacle
    planning::planning_gflags
    planning::proto
    planning::reference_line)
add_library(planning::path_time_graph ALIAS planning_path_time_graph)

add_library(planning_prediction_querier prediction_querier.cc)
target_link_libraries(planning_prediction_querier
    common::math
    common::path_matcher
    planning::obstacle
    planning::proto)
add_library(planning::prediction_querier ALIAS planning_prediction_querier)

add_library(planning_feasible_region feasible_region.cc)
target_link_libraries(planning_feasible_region
    cyber::common
    common::proto
    planning::planning_gflags)
add_library(planning::feasible_region ALIAS planning_feasible_region)

add_library(planning_lattice_behavior_module INTERFACE)
target_link_libraries(planning_lattice_behavior_module INTERFACE
    planning_path_time_graph
    planning_prediction_querier
    planning_feasible_region)

install(TARGETS planning_path_time_graph
                planning_prediction_querier
                planning_feasible_region
                planning_lattice_behavior_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
