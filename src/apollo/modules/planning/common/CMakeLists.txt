cmake_minimum_required(VERSION 3.5.1)

find_package(Boost COMPONENTS thread REQUIRED)


add_library(planning_indexed_list indexed_list.h)
set_target_properties(planning_indexed_list PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(planning_indexed_list
        common::map_util
        Boost::thread
)
add_library(planning::indexed_list ALIAS planning_indexed_list)


add_library(planning_indexed_queue indexed_queue.h)
set_target_properties(planning_indexed_queue PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(planning_indexed_queue
        common::map_util)
add_library(planning::indexed_queue ALIAS planning_indexed_queue)

add_library(planning_obstacle obstacle.cc)
target_link_libraries(planning_obstacle
        planning::indexed_list
        common::vehicle_config_helper
        common::map_util
        planning::st_boundary
        planning::reference_line
        planning::proto)
add_library(planning::obstacle ALIAS planning_obstacle)


add_library(planning_obstacle_blocking_analyzer obstacle_blocking_analyzer.cc)
target_link_libraries(planning_obstacle_blocking_analyzer
        planning::frame
        common::vehicle_config_helper
        planning::reference_line)
add_library(planning::obstacle_blocking_analyzer ALIAS planning_obstacle_blocking_analyzer)


add_library(planning_gflags planning_gflags.cc)
target_link_libraries(planning_gflags ${gflags_LIBRARIES})
add_library(planning::planning_gflags ALIAS planning_gflags)


add_library(planning_planning_context planning_context.cc)
target_link_libraries(planning_planning_context
        planning::planning_gflags
        cyber::common
        map::pnc_map_path
        planning::path_data
        planning::proto)
add_library(planning::planning_context ALIAS planning_planning_context)

add_library(planning_path_boundary path_boundary.cc)
add_library(planning::path_boundary ALIAS planning_path_boundary)


add_library(planning_path_decision path_decision.cc)
target_link_libraries(planning_path_decision
        planning::obstacle
        planning::reference_line)
add_library(planning::path_decision ALIAS planning_path_decision)


add_library(planning_reference_line_info reference_line_info.cc)
target_link_libraries(planning_reference_line_info
        planning::ego_info
        planning::path_boundary
        planning::path_decision
        planning::planning_gflags
        planning::st_graph_data
        cyber::common
        common::proto
        common::vehicle_state_provider
        map::pnc_map
        map::proto
        planning::path_data
        planning::speed_data
        planning::discretized_trajectory
        planning::publishable_trajectory
        planning::proto
        planning::reference_line)
add_library(planning::reference_line_info ALIAS planning_reference_line_info)

add_library(planning_speed_profile_generator speed_profile_generator.cc)
target_link_libraries(planning_speed_profile_generator
        planning::frame
        planning::reference_line_info
        common::proto
        planning::speed_data
        planning::curve1d
        planning::polynomial_curve1d
        planning::quartic_polynomial_curve1d
        planning::quintic_polynomial_curve1d
        planning::piecewise_jerk_speed_problem
        planning::proto)
add_library(planning::speed_profile_generator ALIAS planning_speed_profile_generator)


add_library(planning_local_view local_view.h)
set_target_properties(planning_local_view PROPERTIES LINKER_LANGUAGE CXX)

target_link_libraries(planning_local_view
        localization::proto
        map::relative_map_proto
        perception::proto
        planning::proto
        prediction::proto)
add_library(planning::local_view ALIAS planning_local_view)




add_library(planning_frame frame.cc
                           frame_manager.cc)
target_link_libraries(planning_frame
        planning::indexed_queue
        planning::local_view
        planning::obstacle
        planning::open_space_info
        planning::reference_line_info
        cyber::common
        common::configs_proto
        common::vehicle_state_provider
        map::hdmap_util
        map::pnc_map
        planning::discretized_trajectory
        planning::publishable_trajectory
        planning::util_lib
        planning::reference_line_provider
        planning::proto)
add_library(planning::frame ALIAS planning_frame)



add_library(planning_speed_limit speed_limit.cc)
target_link_libraries(planning_speed_limit
        common::math
        planning::proto)
add_library(planning::speed_limit ALIAS planning_speed_limit)

add_library(planning_ego_info ego_info.cc)
target_link_libraries(planning_ego_info
        planning::obstacle
        cyber::common
        common::vehicle_config_helper
        common::configs_proto
        common::math
        common::vehicle_state_proto
        planning::reference_line)
add_library(planning::ego_info ALIAS planning_ego_info)


add_library(planning_trajectory_stitcher trajectory_stitcher.cc)
target_link_libraries(planning_trajectory_stitcher
        cyber::common
        common::proto
        common::vehicle_model
        planning::publishable_trajectory
        planning::planning_gflags
        planning::reference_line)
add_library(planning::trajectory_stitcher ALIAS planning_trajectory_stitcher)

add_library(planning_open_space_info open_space_info.cc)
target_link_libraries(planning_open_space_info
        cyber::common
        common::vehicle_config_helper
        common::vehicle_state_proto
        map::hdmap_util
        map::pnc_map
        planning::indexed_queue
        planning::obstacle
        planning::discretized_trajectory
        planning::publishable_trajectory
        planning::planning_gflags
        planning::reference_line)
add_library(planning::open_space_info ALIAS planning_open_space_info)


add_library(planning_st_graph_data st_graph_data.cc)
target_link_libraries(planning_st_graph_data
        planning::planning_gflags
        planning::speed_limit
        planning::st_boundary)
add_library(planning::st_graph_data ALIAS planning_st_graph_data)



add_subdirectory(path)
add_subdirectory(speed)
add_subdirectory(trajectory)
add_subdirectory(trajectory1d)
add_subdirectory(util)

add_executable(indexed_list_test indexed_list_test.cc)
target_link_libraries(indexed_list_test
        planning::indexed_list
        common::util
        gtest
        gtest_main)


add_executable(indexed_queue_test indexed_queue_test.cc)
target_link_libraries(indexed_queue_test
        planning::indexed_queue
        common::util
        gtest
        gtest_main)


add_executable(obstacle_test obstacle_test.cc)
target_link_libraries(obstacle_test
        planning::obstacle
        perception::proto
        common::util
        gtest
        gtest_main)

add_executable(reference_line_info_test reference_line_info_test.cc)
target_link_libraries(reference_line_info_test
        planning::reference_line_info
        gtest
        gtest_main)

add_executable(speed_profile_generator_test speed_profile_generator_test.cc)
target_link_libraries(speed_profile_generator_test
        planning::speed_profile_generator
        gtest
        gtest_main)

add_executable(frame_test frame_test.cc)
target_link_libraries(frame_test
        planning::frame
        common::util
        map::hdmap_util
        planning::proto
        gtest
        gtest_main)

add_executable(speed_limit_test speed_limit_test.cc)
target_link_libraries(speed_limit_test
        planning::speed_limit
        gtest
        gtest_main)

add_executable(ego_info_test ego_info_test.cc)
target_link_libraries(ego_info_test
        planning::ego_info
        planning::frame
        gtest
        gtest_main)

add_executable(open_space_info_test open_space_info_test.cc)
target_link_libraries(open_space_info_test
        planning::open_space_info
        gtest
        gtest_main)

add_executable(st_graph_data_test st_graph_data_test.cc)
target_link_libraries(st_graph_data_test
        planning::st_graph_data
        cyber::common
        common::time
        common::util
        gtest
        gtest_main)

add_library(planning_common_module INTERFACE)
target_link_libraries(planning_common_module INTERFACE
        planning_gflags
        planning_planning_context
        planning_path_boundary
        planning_path_decision
        planning_reference_line_info
        planning_speed_profile_generator
        planning_local_view
        planning_frame
        planning_speed_limit
        planning_ego_info
        planning_trajectory_stitcher
        planning_open_space_info
        planning_st_graph_data
        planning_indexed_list
        planning_indexed_queue
        planning_obstacle
        planning_obstacle_blocking_analyzer
        planning_common_path_module
        planning_common_speed_module
        planning_common_trajectory_module
        planning_common_trajectory1d_module
        planning_common_util_module)

install(TARGETS planning_gflags
                planning_planning_context
                planning_path_boundary
                planning_path_decision
                planning_reference_line_info
                planning_speed_profile_generator
                planning_local_view
                planning_frame
                planning_speed_limit
                planning_ego_info
                planning_trajectory_stitcher
                planning_open_space_info
                planning_st_graph_data
                planning_indexed_list
                planning_indexed_queue
                planning_obstacle
                planning_obstacle_blocking_analyzer
                planning_common_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
install(TARGETS indexed_list_test
                indexed_queue_test
                obstacle_test
                reference_line_info_test
                speed_profile_generator_test
                frame_test
                speed_limit_test
                ego_info_test
                open_space_info_test
                st_graph_data_test
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
