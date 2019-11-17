cmake_minimum_required(VERSION 3.5.1)

find_package(osqp REQUIRED)
include_directories(${osqp_INCLUDE_DIRS})


add_library(planning_cos_theta_ipopt_interface cos_theta_ipopt_interface.cc)
target_link_libraries(planning_cos_theta_ipopt_interface cyber::common
                                                         ${ADOLC_LIBRARIES}
                                                         ${IPOPT_LIBRARIES})
add_library(planning::cos_theta_ipopt_interface ALIAS planning_cos_theta_ipopt_interface)


add_library(planning_fem_pos_deviation_ipopt_interface fem_pos_deviation_ipopt_interface.cc)
target_link_libraries(planning_fem_pos_deviation_ipopt_interface cyber::common
                                                                 ${ADOLC_LIBRARIES}
                                                                 ${IPOPT_LIBRARIES})
add_library(planning::fem_pos_deviation_ipopt_interface ALIAS planning_fem_pos_deviation_ipopt_interface)


add_library(planning_fem_pos_deviation_osqp_interface fem_pos_deviation_osqp_interface.cc)
target_link_libraries(planning_fem_pos_deviation_osqp_interface cyber::common
                                                                ${osqp_LIBRARIES})
add_library(planning::fem_pos_deviation_osqp_interface ALIAS planning_fem_pos_deviation_osqp_interface)

add_library(planning_cos_theta_smoother cos_theta_smoother.cc)
target_link_libraries(planning_cos_theta_smoother cyber::common
                                                  planning::cos_theta_ipopt_interface
                                                  planning::proto
                                                  ${IPOPT_LIBRARIES})
add_library(planning::cos_theta_smoother ALIAS planning_cos_theta_smoother)


add_library(planning_fem_pos_deviation_smoother fem_pos_deviation_smoother.cc)
target_link_libraries(planning_fem_pos_deviation_smoother cyber::common
                                                          planning::fem_pos_deviation_ipopt_interface
                                                          planning::fem_pos_deviation_osqp_interface
                                                          planning::proto
                                                          ${IPOPT_LIBRARIES})
add_library(planning::fem_pos_deviation_smoother ALIAS planning_fem_pos_deviation_smoother)

add_library(planning_math_discretized_points_smoothing_module INTERFACE)
target_link_libraries(planning_math_discretized_points_smoothing_module
  INTERFACE  planning_cos_theta_ipopt_interface
             planning_fem_pos_deviation_ipopt_interface
             planning_fem_pos_deviation_osqp_interface
             planning_cos_theta_smoother
             planning_fem_pos_deviation_smoother)

install(TARGETS planning_cos_theta_ipopt_interface
                planning_fem_pos_deviation_ipopt_interface
                planning_fem_pos_deviation_osqp_interface
                planning_cos_theta_smoother
                planning_fem_pos_deviation_smoother
                planning_math_discretized_points_smoothing_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
