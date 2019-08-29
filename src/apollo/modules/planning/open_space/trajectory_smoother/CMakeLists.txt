cmake_minimum_required(VERSION 3.5.1)

add_definitions(-DUSE_GPU)
include_directories(${CUDA_INCLUDE_DIRS})

add_library(planning_dual_variable_warm_start_osqp_interface
    dual_variable_warm_start_osqp_interface.cc)
target_link_libraries(planning_dual_variable_warm_start_osqp_interface
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    osqp::osqp)
add_library(planning::dual_variable_warm_start_osqp_interface ALIAS planning_dual_variable_warm_start_osqp_interface)


add_library(planning_dual_variable_warm_start_problem
    dual_variable_warm_start_problem.cc)
target_link_libraries(planning_dual_variable_warm_start_problem
    planning::dual_variable_warm_start_ipopt_interface
    planning::dual_variable_warm_start_ipopt_qp_interface
    planning::dual_variable_warm_start_osqp_interface)
add_library(planning::dual_variable_warm_start_problem ALIAS planning_dual_variable_warm_start_problem)



add_library(planning_dual_variable_warm_start_ipopt_interface
    dual_variable_warm_start_ipopt_interface.cc)
target_link_libraries(planning_dual_variable_warm_start_ipopt_interface
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::dual_variable_warm_start_ipopt_interface ALIAS planning_dual_variable_warm_start_ipopt_interface)


add_library(planning_dual_variable_warm_start_ipopt_qp_interface
    dual_variable_warm_start_ipopt_qp_interface.cc)
target_link_libraries(planning_dual_variable_warm_start_ipopt_qp_interface
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::dual_variable_warm_start_ipopt_qp_interface ALIAS planning_dual_variable_warm_start_ipopt_qp_interface)


add_library(planning_distance_approach_problem
    distance_approach_problem.cc)
target_link_libraries(planning_distance_approach_problem
    planning::distance_approach_ipopt_cuda_interface
    planning::distance_approach_ipopt_fixed_dual_interface
    planning::distance_approach_ipopt_fixed_ts_interface
    planning::distance_approach_ipopt_interface
    planning::distance_approach_ipopt_relax_end_interface
    cyber::common
    common::util
    planning::planning_gflags
    planning::proto)
add_library(planning::distance_approach_problem ALIAS planning_distance_approach_problem)


add_library(planning_distance_approach_ipopt_fixed_ts_interface
    distance_approach_ipopt_fixed_ts_interface.cc)
target_link_libraries(planning_distance_approach_ipopt_fixed_ts_interface
    cyber::common
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::distance_approach_ipopt_fixed_ts_interface ALIAS planning_distance_approach_ipopt_fixed_ts_interface)


add_library(planning_distance_approach_ipopt_fixed_dual_interface
    distance_approach_ipopt_fixed_dual_interface.cc)
target_link_libraries(planning_distance_approach_ipopt_fixed_dual_interface
    cyber::common
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    ${OpenMP_CXX_FLAGS}
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::distance_approach_ipopt_fixed_dual_interface ALIAS planning_distance_approach_ipopt_fixed_dual_interface)


add_library(planning_distance_approach_ipopt_relax_end_interface
    distance_approach_ipopt_relax_end_interface.cc)
target_link_libraries(planning_distance_approach_ipopt_relax_end_interface
    cyber::common
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::distance_approach_ipopt_relax_end_interface ALIAS planning_distance_approach_ipopt_relax_end_interface)



add_library(planning_distance_approach_ipopt_interface
    distance_approach_ipopt_interface.cc)
target_link_libraries(planning_distance_approach_ipopt_interface
    cyber::common
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::distance_approach_ipopt_interface ALIAS planning_distance_approach_ipopt_interface)



add_library(planning_distance_approach_ipopt_cuda_interface
    distance_approach_ipopt_cuda_interface.cc)
target_link_libraries(planning_distance_approach_ipopt_cuda_interface
    cyber::common
    common::vehicle_config_helper
    common::math
    common::util
    planning::planning_gflags
    planning::proto
    planning_block
    ${ADOLC_LIBRARIES}
    ${IPOPT_LIBRARIES})
add_library(planning::distance_approach_ipopt_cuda_interface ALIAS planning_distance_approach_ipopt_cuda_interface)


add_library(planning_iterative_anchoring_smoother
    iterative_anchoring_smoother.cc)
target_link_libraries(planning_iterative_anchoring_smoother
    common::vehicle_config_helper
    common::math
    planning::speed_profile_generator
    planning::discretized_path
    planning::speed_data
    planning::discretized_trajectory
    planning::discrete_points_math
    planning::fem_pos_deviation_smoother)
add_library(planning::iterative_anchoring_smoother ALIAS planning_iterative_anchoring_smoother)


cuda_add_library(planning_block planning_block.cu)
target_link_libraries(planning_block ${CUDA_LIBRARIES})


add_executable(distance_approach_ipopt_interface_test
    distance_approach_ipopt_interface_test.cc)
target_link_libraries(distance_approach_ipopt_interface_test
    planning::distance_approach_ipopt_interface
    cyber::common
    ${OpenMP_CXX_FLAGS}
    gtest
    gtest_main)


install(TARGETS planning_block
                planning_iterative_anchoring_smoother
                planning_distance_approach_ipopt_cuda_interface
                planning_distance_approach_ipopt_interface
                planning_distance_approach_ipopt_relax_end_interface
                planning_distance_approach_ipopt_fixed_dual_interface
                planning_distance_approach_ipopt_fixed_ts_interface
                planning_distance_approach_problem
                planning_dual_variable_warm_start_ipopt_qp_interface
                planning_dual_variable_warm_start_ipopt_interface
                planning_dual_variable_warm_start_problem
                planning_dual_variable_warm_start_osqp_interface
                distance_approach_ipopt_interface_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
