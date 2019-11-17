cmake_minimum_required(VERSION 3.5.1)

add_library(planning_curve_math curve_math.cc)
add_library(planning::curve_math ALIAS planning_curve_math)

add_library(planning_discrete_points_math discrete_points_math.cc)
target_link_libraries(planning_discrete_points_math cyber::common)
add_library(planning::discrete_points_math ALIAS planning_discrete_points_math)


add_library(planning_polynomial_xd polynomial_xd.cc)
target_link_libraries(planning_polynomial_xd cyber::common)
add_library(planning::polynomial_xd ALIAS planning_polynomial_xd)


add_executable(curve_math_test curve_math_test.cc)
target_link_libraries(curve_math_test gtest
                                      gtest_main
                                      planning::curve_math)

add_subdirectory(curve1d)
add_subdirectory(discretized_points_smoothing)
add_subdirectory(piecewise_jerk)
add_subdirectory(smoothing_spline)

add_library(planning_math_module INTERFACE)
target_link_libraries(planning_math_module INTERFACE
    planning_curve_math
    planning_discrete_points_math
    planning_polynomial_xd
    planning_math_curve1d_module
    planning_math_discretized_points_smoothing_module
    planning_math_piecewise_jerk_module
    planning_math_smoothing_spline_module
)

install(TARGETS planning_curve_math
                planning_discrete_points_math
                planning_polynomial_xd
                planning_math_module
    EXPORT apollo-export
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)

install(TARGETS curve_math_test
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)