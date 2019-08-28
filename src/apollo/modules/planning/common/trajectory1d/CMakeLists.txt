cmake_minimum_required(VERSION 3.5.1)

add_library(planning_standing_still_trajectory1d standing_still_trajectory1d.cc)
target_link_libraries(planning_standing_still_trajectory1d
    planning::curve1d)
add_library(planning::standing_still_trajectory1d ALIAS planning_standing_still_trajectory1d)


add_library(planning_piecewise_acceleration_trajectory1d piecewise_acceleration_trajectory1d.cc)
target_link_libraries(planning_piecewise_acceleration_trajectory1d
    common::linear_interpolation
    planning::planning_gflags
    planning::curve1d)
add_library(planning::piecewise_acceleration_trajectory1d ALIAS planning_piecewise_acceleration_trajectory1d)


add_library(planning_constant_deceleration_trajectory1d constant_deceleration_trajectory1d.cc)
target_link_libraries(planning_constant_deceleration_trajectory1d
    cyber::common
    planning::planning_gflags
    planning::curve1d)
add_library(planning::constant_deceleration_trajectory1d ALIAS planning_constant_deceleration_trajectory1d)


add_library(planning_piecewise_trajectory1d piecewise_trajectory1d.cc)
target_link_libraries(planning_piecewise_trajectory1d
    cyber::common
    planning::planning_gflags
    common::linear_interpolation
    planning::curve1d)
add_library(planning::piecewise_trajectory1d ALIAS planning_piecewise_trajectory1d)


add_library(planning_constant_jerk_trajectory1d constant_jerk_trajectory1d.cc)
target_link_libraries(planning_constant_jerk_trajectory1d
    cyber::common
    planning::planning_gflags
    planning::curve1d)
add_library(planning::constant_jerk_trajectory1d ALIAS planning_constant_jerk_trajectory1d)


add_library(planning_piecewise_jerk_trajectory1d piecewise_jerk_trajectory1d.cc)
target_link_libraries(planning_piecewise_jerk_trajectory1d
    planning::constant_jerk_trajectory1d)
add_library(planning::piecewise_jerk_trajectory1d ALIAS planning_piecewise_jerk_trajectory1d)



install(TARGETS planning_standing_still_trajectory1d
                planning_piecewise_acceleration_trajectory1d
                planning_constant_deceleration_trajectory1d
                planning_piecewise_trajectory1d
                planning_constant_jerk_trajectory1d
                planning_piecewise_jerk_trajectory1d
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
