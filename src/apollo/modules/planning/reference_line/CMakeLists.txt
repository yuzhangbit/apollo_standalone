cmake_minimum_required(VERSION 3.5.1)

add_library(planning_reference_line reference_line.cc
                                    reference_point.cc)
target_link_libraries(planning_reference_line cyber::common
                                              common::math
                                              common::proto
                                              common::map_util
                                              common::string_util
                                              map::pnc_map_path
                                              planning::planning_gflags
                                              planning::proto)
add_library(planning::reference_line ALIAS planning_reference_line)



add_library(planning_reference_line_smoother reference_line_smoother.h)
set_target_properties(planning_reference_line_smoother PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(planning_reference_line planning::proto)
add_library(planning::reference_line_smoother ALIAS planning_reference_line_smoother)


add_library(planning_qp_spline_reference_line_smoother qp_spline_reference_line_smoother.cc)
target_link_libraries(planning_qp_spline_reference_line_smoother planning::proto
                                              planning::reference_line
                                              planning::reference_line_smoother
                                              planning::curve_math
                                              planning::active_set_spline_2d_solver
                                              planning::osqp_spline_2d_solver)
add_library(planning::qp_spline_reference_line_smoother ALIAS planning_qp_spline_reference_line_smoother)


add_library(planning_spiral_reference_line_smoother spiral_reference_line_smoother.cc
                                                    spiral_problem_interface.cc)
target_link_libraries(planning_spiral_reference_line_smoother
        planning::proto
        planning::reference_line
        planning::reference_line_smoother
        common::math
        planning::planning_gflags
        planning::quintic_spiral_path
        planning::spline_2d_solver
        planning::proto
        ${IPOPT_LIBRARIES})
add_library(planning::spiral_reference_line_smoother ALIAS planning_spiral_reference_line_smoother)



add_library(planning_discrete_points_reference_line_smoother discrete_points_reference_line_smoother.cc)
target_link_libraries(planning_discrete_points_reference_line_smoother planning::proto
                                                                       planning::reference_line
                                                                       planning::reference_line_smoother
                                                                       common::math
                                                                       map::hdmap
                                                                       map::hdmap_util
                                                                       planning::planning_gflags
                                                                       planning::discrete_points_math
                                                                       planning::cos_theta_smoother
                                                                       planning::fem_pos_deviation_smoother
                                                                       planning::proto)
add_library(planning::discrete_points_reference_line_smoother ALIAS planning_discrete_points_reference_line_smoother)


add_library(planning_reference_line_provider reference_line_provider.cc)
target_link_libraries(planning_reference_line_provider planning::proto
                                                       planning::discrete_points_reference_line_smoother
                                                       planning::qp_spline_reference_line_smoother
                                                       common::vehicle_config_helper
                                                       common::factory
                                                       map::pnc_map
                                                       planning::reference_line
                                                       planning::spiral_reference_line_smoother
                                                       planning::indexed_queue
                                                       planning::planning_context)
add_library(planning::reference_line_provider ALIAS planning_reference_line_provider)

add_library(planning_smoother_util smoother_util.cc)
target_link_libraries(planning_smoother_util planning::discrete_points_reference_line_smoother
                                             planning::qp_spline_reference_line_smoother
                                             planning::reference_line
                                             planning::spiral_reference_line_smoother
                                             planning::proto)
add_library(planning::smoother_util ALIAS planning_smoother_util)

add_library(planning_spiral_smoother_util spiral_smoother_util.cc)
target_link_libraries(planning_spiral_smoother_util planning::spiral_reference_line_smoother
                                                    planning::proto)
add_library(planning::spiral_smoother_util ALIAS planning_spiral_smoother_util)



add_executable(spiral_reference_line_smoother_test spiral_reference_line_smoother_test.cc)
target_link_libraries(spiral_reference_line_smoother_test planning::spiral_reference_line_smoother
                                                          gtest
                                                          gtest_main)

add_executable(qp_spline_reference_line_smoother_test qp_spline_reference_line_smoother_test.cc)
target_link_libraries(qp_spline_reference_line_smoother_test planning::qp_spline_reference_line_smoother
                                                             gtest
                                                             gtest_main)

add_executable(discrete_points_reference_line_smoother_test discrete_points_reference_line_smoother_test.cc)
target_link_libraries(discrete_points_reference_line_smoother_test planning::discrete_points_reference_line_smoother
                                                                   gtest
                                                                   gtest_main)

install(TARGETS planning_reference_line
                planning_reference_line_smoother
                planning_qp_spline_reference_line_smoother
                planning_spiral_reference_line_smoother
                planning_discrete_points_reference_line_smoother
                spiral_reference_line_smoother_test
                qp_spline_reference_line_smoother_test
                discrete_points_reference_line_smoother_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
