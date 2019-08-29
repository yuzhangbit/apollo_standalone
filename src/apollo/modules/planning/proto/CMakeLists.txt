cmake_minimum_required(VERSION 3.5.1)

set(PROTOS cos_theta_smoother_config.proto
           decider_config.proto
           decision.proto
           dp_st_speed_config.proto
           fem_pos_deviation_smoother_config.proto
           lane_change_decider_config.proto           lattice_sampling_config.proto
           lattice_structure.proto
           navi_obstacle_decider_config.proto
           navi_path_decider_config.proto
           navi_speed_decider_config.proto
           open_space_fallback_decider_config.proto
           open_space_pre_stop_decider_config.proto
           open_space_roi_decider_config.proto
           open_space_trajectory_partition_config.proto
           open_space_trajectory_provider_config.proto
           pad_msg.proto
           path_assessment_decider_config.proto
           path_bounds_decider_config.proto
           path_decider_info.proto
           path_lane_borrow_decider_config.proto
           piecewise_jerk_path_config.proto
           piecewise_jerk_speed_config.proto
           planner_open_space_config.proto
           planning_config.proto
           planning_internal.proto
           planning_stats.proto
           planning_status.proto
           planning.proto
           proceed_with_caution_speed_config.proto
           qp_problem.proto
           reference_line_smoother_config.proto
           rule_based_stop_decider_config.proto
           sl_boundary.proto
           speed_bounds_decider_config.proto
           spiral_curve_config.proto
           traffic_rule_config.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(planning_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(planning_proto ${PROTOBUF_LIBRARIES}
                                     canbus::proto
                                     common::proto
                                     localization::proto
                                     perception::proto
                                     prediction::proto
                                     routing::proto
                                     dreamview::proto
                                     map::relative_map_proto
                                     )
add_library(planning::proto ALIAS planning_proto)

install(TARGETS planning_proto
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
