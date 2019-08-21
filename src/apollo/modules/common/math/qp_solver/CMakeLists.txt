cmake_minimum_required(VERSION 3.5.1)

add_library(common_qp_solver_gflags qp_solver_gflags.cc)
target_link_libraries(common_qp_solver_gflags ${gflags_LIBRARIES}
                                              ${GLOG_LIBRARIES})
add_library(common::qp_solver_gflags ALIAS common_qp_solver_gflags)

add_library(common_qp_solver qp_solver.cc)
add_library(common::qp_solver ALIAS common_qp_solver)

add_library(common_active_set_qp_solver active_set_qp_solver.cc)
target_link_libraries(common_active_set_qp_solver cyber::common
                                                  common::qp_solver
                                                  common::qp_solver_gflags
                                                  ${qpOASES_LIBRARIES})
add_library(common::active_set_qp_solver ALIAS common_active_set_qp_solver)


add_executable(active_set_qp_solver_test active_set_qp_solver_test.cc)
target_link_libraries(active_set_qp_solver_test common::active_set_qp_solver
                                                gtest
                                                gtest_main)

install(TARGETS active_set_qp_solver_test
                common_active_set_qp_solver
                common_qp_solver
                common_qp_solver_gflags
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)