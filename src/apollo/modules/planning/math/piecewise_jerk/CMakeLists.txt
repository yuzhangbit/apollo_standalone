cmake_minimum_required(VERSION 3.5.1)

add_library(planning_piecewise_jerk_problem piecewise_jerk_problem.cc)
target_link_libraries(planning_piecewise_jerk_problem cyber::common
                                                      planning::planning_gflags
                                                      ${osqp_LIBRARIES})
add_library(planning::piecewise_jerk_problem ALIAS planning_piecewise_jerk_problem)



add_library(planning_piecewise_jerk_path_problem piecewise_jerk_path_problem.cc)
target_link_libraries(planning_piecewise_jerk_path_problem
        planning::piecewise_jerk_problem)
add_library(planning::piecewise_jerk_path_problem ALIAS planning_piecewise_jerk_path_problem)


add_library(planning_piecewise_jerk_speed_problem piecewise_jerk_speed_problem.cc)
target_link_libraries(planning_piecewise_jerk_speed_problem
        planning::piecewise_jerk_problem)
add_library(planning::piecewise_jerk_speed_problem ALIAS planning_piecewise_jerk_speed_problem)



install(TARGETS planning_piecewise_jerk_problem
                planning_piecewise_jerk_path_problem
                planning_piecewise_jerk_speed_problem
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

