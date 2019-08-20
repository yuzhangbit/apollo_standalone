cmake_minimum_required(VERSION 3.5.1)

add_library(common_geometry aabox2d.cc
                            box2d.cc
                            line_segment2d.cc
                            math_utils.cc
                            math_utils.h
                            polygon2d.cc
                            vec2d.cc)
target_link_libraries(common_geometry cyber::common
                                      common::string_util
                                      common::proto)
add_library(common::geometry ALIAS common_geometry)

add_library(common_sin_table sin_table.cc)
add_library(common::sin_table ALIAS common_sin_table)

add_library(common_angle angle.cc)
target_link_libraries(common_angle common::sin_table)
add_library(common::angle ALIAS common_angle)

add_library(common_euler_angles_zxy euler_angles_zxy.h)
set_target_properties(common_euler_angles_zxy PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_euler_angles_zxy common::geometry)
add_library(common::euler_angles_zxy ALIAS common_euler_angles_zxy)

add_library(common_quaternion quaternion.h)
set_target_properties(common_quaternion PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_quaternion common::geometry
                                        common::euler_angles_zxy
                                        common::proto)
add_library(common::quaternion ALIAS common_quaternion)

add_library(common_curve_fitting curve_fitting.h)
set_target_properties(common_curve_fitting PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_curve_fitting common::matrix_operations)
add_library(common::curve_fitting ALIAS common_curve_fitting)

add_library(common_matrix_operations matrix_operations.cc)
target_link_libraries(common_matrix_operations cyber::common)
add_library(common::matrix_operations ALIAS common_matrix_operations)

add_library(common_kalman_filter kalman_filter.h)
set_target_properties(common_kalman_filter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_kalman_filter cyber::common
                                           common::matrix_operations)
add_library(common::matrix_operations ALIAS common_matrix_operations)

add_library(common_extended_kalman_filter extended_kalman_filter.h)
set_target_properties(common_extended_kalman_filter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_extended_kalman_filter cyber::common
                                                    common::matrix_operations)
add_library(common::extended_kalman_filter ALIAS common_extended_kalman_filter)

add_library(common_factorial factorial.h)
set_target_properties(common_factorial PROPERTIES LINKER_LANGUAGE CXX)
add_library(common::factorial ALIAS common_factorial)

add_library(common_path_matcher path_matcher.cc)
target_link_libraries(common_path_matcher common::proto
                                          common::linear_interpolation)
add_library(common::path_matcher ALIAS common_path_matcher)


add_library(common_linear_interpolation linear_interpolation.cc)
target_link_libraries(common_linear_interpolation common::geometry
                                                  common::proto)
add_library(common::linear_interpolation ALIAS common_linear_interpolation)


add_library(common_nonlinear_interpolation nonlinear_interpolation.cc)
target_link_libraries(common_nonlinear_interpolation common::geometry
                                                     common::hermite_spline
                                                     common::integral
                                                     common::proto)
add_library(common::nonlinear_interpolation ALIAS common_nonlinear_interpolation)

add_library(common_search search.h)
set_target_properties(common_search PROPERTIES LINKER_LANGUAGE CXX)
add_library(common::search ALIAS common_search)

add_library(common_integral integral.cc)
target_link_libraries(common_integral cyber::common)
add_library(common::integral ALIAS common_integral)

add_library(common_lqr linear_quadratic_regulator.cc)
target_link_libraries(common_lqr cyber::common)
add_library(common::lqr ALIAS common_lqr)

add_library(common_mpc mpc_solver.cc)
target_link_libraries(common_mpc cyber::common
                                 common::qp_solver)
add_library(common::mpc ALIAS common_mpc)


add_library(common_cartesian_frenet_conversion cartesian_frenet_conversion.cc)
target_link_libraries(common_cartesian_frenet_conversion cyber::common
                                                         common::geometry)
add_library(common::cartesian_frenet_conversion ALIAS common_cartesian_frenet_conversion)

add_library(common_hermite_spline hermite_spline.h)
set_target_properties(common_hermite_spline PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_hermite_spline cyber::common)
add_library(common::hermite_spline ALIAS common_hermite_spline)

add_subdirectory(qp_solver)