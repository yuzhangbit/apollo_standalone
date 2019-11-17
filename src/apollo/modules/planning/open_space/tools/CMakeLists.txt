cmake_minimum_required(VERSION 3.5.1)

add_executable(hybrid_a_star_wrapper hybrid_a_star_wrapper.cc)
target_link_libraries(hybrid_a_star_wrapper
    planning::hybrid_a_star)

add_library(distance_approach_problem_wrapper distance_approach_problem_wrapper.cc)
target_link_libraries(distance_approach_problem_wrapper
    planning::hybrid_a_star
    planning::distance_approach_problem
    planning::dual_variable_warm_start_problem
    ${OpenMP_CXX_FLAGS})


add_library(open_space_roi_wrapper open_space_roi_wrapper.cc)
target_link_libraries(open_space_roi_wrapper
    cyber::common
    common::math
    map::pnc_map
    planning::planning_gflags
    planning::proto)

add_library(planning_open_space_tools_module INTERFACE)
target_link_libraries(planning_open_space_tools_module
    INTERFACE distance_approach_problem_wrapper
              open_space_roi_wrapper)

install(TARGETS distance_approach_problem_wrapper
                open_space_roi_wrapper
                planning_open_space_tools_module
    export apollo-export
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)

install(TARGETS hybrid_a_star_wrapper
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)
