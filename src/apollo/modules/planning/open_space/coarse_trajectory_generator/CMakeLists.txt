cmake_minimum_required(VERSION 3.5.1)

add_library(planning_node3d node3d.cc)
target_link_libraries(planning_node3d
    cyber::common
    common::math
    planning::obstacle
    planning::collision_checker
    planning::proto)
add_library(planning::node3d ALIAS planning_node3d)

add_library(planning_reeds_shepp_path reeds_shepp_path.cc)
target_link_libraries(planning_reeds_shepp_path
    cyber::common
    common::vehicle_config_helper
    common::math
    planning::planning_gflags
    planning::node3d
    planning::proto
    adolc::adolc)
add_library(planning::reeds_shepp_path ALIAS planning_reeds_shepp_path)

add_library(planning_grid_search grid_search.cc)
target_link_libraries(planning_grid_search
    cyber::common
    common::math
    planning::proto)
add_library(planning::grid_search ALIAS planning_grid_search)

add_library(planning_open_space_utils INTERFACE)
target_link_libraries(planning_open_space_utils
    INTERFACE
    planning::grid_search
    planning::node3d
    planning::reeds_shepp_path)
add_library(planning::open_space_utils ALIAS planning_open_space_utils)


add_library(planning_hybrid_a_star hybrid_a_star.cc)
target_link_libraries(planning_hybrid_a_star
    cyber::common
    common::vehicle_config_helper
    planning::open_space_utils
    planning::obstacle
    planning::planning_gflags
    planning::piecewise_jerk_speed_problem
    planning::proto)
add_library(planning::hybrid_a_star ALIAS planning_hybrid_a_star)


add_executable(node3d_test node3d_test.cc)
target_link_libraries(node3d_test
    planning::open_space_utils
    cyber::common
    gtest
    gtest_main)

add_executable(hybrid_a_star_test hybrid_a_star_test.cc)
target_link_libraries(hybrid_a_star_test
    planning::hybrid_a_star
    gtest
    gtest_main)

add_library(planning_open_space_coarse_trajectory_generator_module INTERFACE)
target_link_libraries(planning_open_space_coarse_trajectory_generator_module
    INTERFACE planning_node3d
              planning_reeds_shepp_path
              planning_grid_search
              planning_open_space_utils
              planning_hybrid_a_star)

install(TARGETS planning_node3d
                planning_reeds_shepp_path
                planning_grid_search
                planning_hybrid_a_star
                planning_open_space_utils
                planning_open_space_coarse_trajectory_generator_module
      EXPORT  apollo-export
      LIBRARY DESTINATION lib
      ARCHIVE DESTINATION lib
      RUNTIME DESTINATION bin
      INCLUDES DESTINATION .
      )

install(TARGETS node3d_test
                hybrid_a_star_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
