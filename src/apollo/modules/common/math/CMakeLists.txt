cmake_minimum_required(VERSION 3.5.1)

add_library(common_math dummy.cc)
target_link_libraries(common_math common::angle
                                  common::cartesian_frenet_conversion
                                  common::curve_fitting
                                  common::euler_angles_zxy
                                  common::factorial
                                  common::geometry
                                  common::integral
                                  common::kalman_filter
                                  common::linear_interpolation
                                  common::lqr
                                  common::mpc
                                  common::quaternion
                                  common::search
                                  common::sin_table)
add_library(common::math ALIAS common_math)

add_library(common_geometry aabox2d.cc
                            box2d.cc
                            line_segment2d.cc
                            math_utils.cc
                            math_utils.h
                            polygon2d.cc
                            vec2d.cc)
target_link_libraries(common_geometry cyber::common
                                      common::string_util
                                      common::proto
                                      ${osqp_LIBRARIES})
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
add_library(common::kalman_filter ALIAS common_kalman_filter)

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

add_library(common_search search.cc)
add_library(common::search ALIAS common_search)

add_library(common_integral integral.cc)
target_link_libraries(common_integral cyber::common)
add_library(common::integral ALIAS common_integral)

add_library(common_lqr linear_quadratic_regulator.cc)
target_link_libraries(common_lqr cyber::common)
add_library(common::lqr ALIAS common_lqr)

add_library(common_mpc mpc_solver.cc)
target_link_libraries(common_mpc cyber::common
                                 common::qp_solver
                                 common::active_set_qp_solver)
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

add_executable(angle_test angle_test.cc)
target_link_libraries(angle_test gtest
                                 gtest_main
                                 common::angle)

add_executable(mpc_test mpc_solver_test.cc)
target_link_libraries(mpc_test gtest
                               gtest_main
                               common::qp_solver
                               common::active_set_qp_solver
                               common::mpc)

add_executable(math_utils_test math_utils_test.cc)
target_link_libraries(math_utils_test gtest
                                      gtest_main
                                      common::geometry
                                      ${osqp_LIBRARIES})

add_executable(linear_interpolation_test linear_interpolation_test.cc)
target_link_libraries(linear_interpolation_test gtest
                                                gtest_main
                                                common::linear_interpolation)

add_executable(search_test search_test.cc)
target_link_libraries(search_test gtest gtest_main
common::search)

add_executable(integral_test integral_test.cc)
target_link_libraries(integral_test gtest gtest_main
common::integral)

add_executable(vec2d_test vec2d_test.cc)
target_link_libraries(vec2d_test gtest gtest_main
common::geometry)

add_executable(quaternion_test quaternion_test.cc)
target_link_libraries(quaternion_test gtest gtest_main
common::quaternion)

add_executable(euler_angles_zxy_test euler_angles_zxy_test.cc)
target_link_libraries(euler_angles_zxy_test gtest gtest_main
common::euler_angles_zxy)

add_executable(aabox2d_test aabox2d_test.cc)
target_link_libraries(aabox2d_test gtest gtest_main
common::geometry)

add_executable(aaboxkdtree2d_test aaboxkdtree2d_test.cc)
target_link_libraries(aaboxkdtree2d_test gtest gtest_main
common::geometry)

add_executable(box2d_test box2d_test.cc)
target_link_libraries(box2d_test gtest gtest_main
common::geometry)

add_executable(polygon2d_test polygon2d_test.cc)
target_link_libraries(polygon2d_test gtest gtest_main
common::geometry)

add_executable(line_segment2d_test line_segment2d_test.cc)
target_link_libraries(line_segment2d_test gtest gtest_main
common::geometry)

add_executable(kalman_filter_test kalman_filter_test.cc)
target_link_libraries(kalman_filter_test gtest gtest_main
common::kalman_filter)

add_executable(cartesian_frenet_conversion_test cartesian_frenet_conversion_test.cc)
target_link_libraries(cartesian_frenet_conversion_test gtest gtest_main
common::cartesian_frenet_conversion)

add_library(common_math_module INTERFACE)
target_link_libraries(common_math_module INTERFACE
        common_angle
        common_geometry
        common_sin_table
        common_euler_angles_zxy
        common_quaternion
        common_curve_fitting
        common_matrix_operations
        common_kalman_filter
        common_extended_kalman_filter
        common_factorial
        common_path_matcher
        common_linear_interpolation
        common_nonlinear_interpolation
        common_search
        common_integral
        common_lqr
        common_mpc
        common_cartesian_frenet_conversion
        common_hermite_spline
        common_math
        )

install(TARGETS common_geometry
                common_angle
                common_sin_table
                common_euler_angles_zxy
                common_quaternion
                common_curve_fitting
                common_matrix_operations
                common_kalman_filter
                common_extended_kalman_filter
                common_factorial
                common_path_matcher
                common_linear_interpolation
                common_nonlinear_interpolation
                common_search
                common_integral
                common_lqr
                common_mpc
                common_cartesian_frenet_conversion
                common_hermite_spline
                mpc_test
                angle_test
                math_utils_test
                linear_interpolation_test
                search_test
                integral_test
                vec2d_test
                quaternion_test
                euler_angles_zxy_test
                aabox2d_test
                aaboxkdtree2d_test
                box2d_test
                polygon2d_test
                line_segment2d_test
                kalman_filter_test
                common_math
                common_math_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)

install(TARGETS mpc_test
                angle_test
                math_utils_test
                linear_interpolation_test
                search_test
                integral_test
                vec2d_test
                quaternion_test
                euler_angles_zxy_test
                aabox2d_test
                aaboxkdtree2d_test
                box2d_test
                polygon2d_test
                line_segment2d_test
                kalman_filter_test
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
