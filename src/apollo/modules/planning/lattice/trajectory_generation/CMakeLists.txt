cmake_minimum_required(VERSION 3.5.1)

add_library(planning_lattice_trajectory1d lattice_trajectory1d.cc)
target_link_libraries(planning_lattice_trajectory1d
    cyber::common
    planning::curve1d)
add_library(planning::lattice_trajectory1d ALIAS planning_lattice_trajectory1d)

add_library(planning_end_condition_sampler end_condition_sampler.cc)
target_link_libraries(planning_end_condition_sampler
    common::vehicle_config_helper
    planning::planning_gflags
    planning::feasible_region
    planning::path_time_graph
    planning::prediction_querier
    planning::proto)
add_library(planning::end_condition_sampler ALIAS planning_end_condition_sampler)

add_library(planning_lattice_trajectory_generation_module INTERFACE)

target_link_libraries(planning_lattice_trajectory_generation_module INTERFACE
    planning_lattice_trajectory1d
    planning_end_condition_sampler)

install(TARGETS planning_lattice_trajectory1d
                planning_end_condition_sampler
                planning_lattice_trajectory_generation_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
