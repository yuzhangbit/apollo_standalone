cmake_minimum_required(VERSION 3.5.1)

add_library(planning_curve1d curve1d.h)
set_target_properties(planning_curve1d PROPERTIES LINKER_LANGUAGE CXX)
add_library(planning::curve1d ALIAS planning_curve1d)

add_library(planning_polynomial_curve1d polynomial_curve1d.h)
set_target_properties(planning_polynomial_curve1d PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(planning_polynomial_curve1d planning::curve1d)
add_library(planning::polynomial_curve1d ALIAS planning_polynomial_curve1d)


add_library(planning_quartic_polynomial_curve1d quartic_polynomial_curve1d.cc)
target_link_libraries(planning_quartic_polynomial_curve1d planning::polynomial_curve1d
                                                          cyber::common
                                                          common::string_util)
add_library(planning::quartic_polynomial_curve1d ALIAS planning_quartic_polynomial_curve1d)


add_library(planning_quintic_polynomial_curve1d quintic_polynomial_curve1d.cc)
target_link_libraries(planning_quintic_polynomial_curve1d planning::polynomial_curve1d
                                                          cyber::common
                                                          common::string_util)
add_library(planning::quintic_polynomial_curve1d ALIAS planning_quintic_polynomial_curve1d)

add_library(planning_cubic_polynomial_curve1d cubic_polynomial_curve1d.cc)
target_link_libraries(planning_cubic_polynomial_curve1d planning::polynomial_curve1d
                                                        planning::quartic_polynomial_curve1d
                                                        cyber::common
                                                        common::string_util)
add_library(planning::cubic_polynomial_curve1d ALIAS planning_cubic_polynomial_curve1d)


add_library(planning_quintic_spiral_path quintic_spiral_path.cc)
target_link_libraries(planning_quintic_spiral_path planning::quintic_polynomial_curve1d
                                                        planning::quartic_polynomial_curve1d
                                                        common::math
                                                        common::string_util)
add_library(planning::quintic_spiral_path ALIAS planning_quintic_spiral_path)

add_library(planning_piecewise_quintic_spiral_path piecewise_quintic_spiral_path.cc)
target_link_libraries(planning_piecewise_quintic_spiral_path planning::quintic_spiral_path
                                                        cyber::common
                                                        common::math
                                                        common::string_util)
add_library(planning::piecewise_quintic_spiral_path ALIAS planning_piecewise_quintic_spiral_path)


add_executable(quartic_polynomial_curve1d_test quartic_polynomial_curve1d_test.cc)
target_link_libraries(quartic_polynomial_curve1d_test planning::cubic_polynomial_curve1d
                                                      planning::quartic_polynomial_curve1d
                                                      planning::quintic_polynomial_curve1d
                                                      cyber::common
                                                      gtest
                                                      gtest_main)

add_executable(cubic_polynomial_curve1d_test cubic_polynomial_curve1d_test.cc)
target_link_libraries(cubic_polynomial_curve1d_test planning::cubic_polynomial_curve1d
                                                    planning::quartic_polynomial_curve1d
                                                    cyber::common
                                                    gtest
                                                    gtest_main)

add_executable(quintic_polynomial_curve1d_test quintic_polynomial_curve1d_test.cc)
target_link_libraries(quintic_polynomial_curve1d_test planning::quartic_polynomial_curve1d
                                                      planning::quintic_polynomial_curve1d
                                                      cyber::common
                                                      gtest
                                                      gtest_main)

add_library(planning_math_curve1d_module INTERFACE)
target_link_libraries(planning_math_curve1d_module INTERFACE
    planning_piecewise_quintic_spiral_path
    planning_quintic_spiral_path
    planning_cubic_polynomial_curve1d
    planning_quintic_polynomial_curve1d
    planning_quartic_polynomial_curve1d)

install(TARGETS planning_piecewise_quintic_spiral_path
                planning_quintic_spiral_path
                planning_cubic_polynomial_curve1d
                planning_quintic_polynomial_curve1d
                planning_quartic_polynomial_curve1d
                planning_math_curve1d_module
        EXPORT  apollo-export
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)

install(TARGETS quartic_polynomial_curve1d_test
                cubic_polynomial_curve1d_test
                quintic_polynomial_curve1d_test
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)