cmake_minimum_required(VERSION 3.5.1)

add_library(planning_affine_constraint affine_constraint.cc)
target_link_libraries(planning_affine_constraint planning::polynomial_xd)
add_library(planning::affine_constraint ALIAS planning_affine_constraint)

add_library(planning_spline_1d_seg spline_1d_seg.cc)
target_link_libraries(planning_spline_1d_seg planning::polynomial_xd)
add_library(planning::spline_1d_seg ALIAS planning_spline_1d_seg)

add_library(planning_spline_1d_kernel spline_1d_kernel.cc)
target_link_libraries(planning_spline_1d_kernel planning::affine_constraint
                                                planning::spline_1d
                                                planning::spline_seg_kernel)
add_library(planning::spline_1d_kernel ALIAS planning_spline_1d_kernel)

add_library(planning_spline_1d spline_1d.cc)
target_link_libraries(planning_spline_1d planning::polynomial_xd
                                         planning::spline_1d_seg
                                         planning::affine_constraint)
add_library(planning::spline_1d ALIAS planning_spline_1d)


add_library(planning_spline_1d_constraint spline_1d_constraint.cc)
target_link_libraries(planning_spline_1d_constraint cyber::common
                                                    planning::spline_1d_seg
                                                    planning::affine_constraint)
add_library(planning::spline_1d_constraint ALIAS planning_spline_1d_constraint)


add_library(planning_spline_seg_kernel spline_seg_kernel.cc)
target_link_libraries(planning_spline_seg_kernel cyber::common)
add_library(planning::spline_seg_kernel ALIAS planning_spline_seg_kernel)

add_library(planning_spline_1d_solver spline_1d_solver.cc)
target_link_libraries(planning_spline_1d_solver common::qp_solver
                                                common::active_set_qp_solver
                                                planning::spline_1d
                                                planning::spline_1d_constraint
                                                planning::spline_1d_kernel
                                                planning::planning_gflags
                                                planning::proto)
add_library(planning::spline_1d_solver ALIAS planning_spline_1d_solver)


add_library(planning_active_set_spline_1d_solver active_set_spline_1d_solver.cc)
target_link_libraries(planning_active_set_spline_1d_solver planning::spline_1d_solver
                                                           common::time)
add_library(planning::active_set_spline_1d_solver ALIAS planning_active_set_spline_1d_solver)


add_library(planning_spline_2d_seg spline_2d_seg.cc)
target_link_libraries(planning_spline_2d_seg planning::polynomial_xd)
add_library(planning::spline_2d_seg ALIAS planning_spline_2d_seg)



add_library(planning_spline_2d spline_2d.cc)
target_link_libraries(planning_spline_2d planning::spline_2d_seg
                                         planning::polynomial_xd)
add_library(planning::spline_2d ALIAS planning_spline_2d)


add_library(planning_spline_2d_constraint spline_2d_constraint.cc)
target_link_libraries(planning_spline_2d_constraint planning::affine_constraint
                                                    planning::spline_2d
                                                    common::angle
                                                    common::math)
add_library(planning::spline_2d_constraint ALIAS planning_spline_2d_constraint)

add_library(planning_spline_2d_kernel spline_2d_kernel.cc)
target_link_libraries(planning_spline_2d_kernel planning::spline_2d
                                                planning::spline_seg_kernel
                                                common::math)
add_library(planning::spline_2d_kernel ALIAS planning_spline_2d_kernel)



add_library(planning_spline_2d_solver active_set_spline_2d_solver.h
                                      osqp_spline_2d_solver.h
                                      spline_2d_solver.h)
set_target_properties(planning_spline_2d_solver PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(planning_spline_2d_solver planning::spline_2d
                                                planning::spline_2d_kernel
                                                planning::spline_2d_constraint
                                                common::math
                                                common::matrix_operations
                                                common::qp_solver
                                                common::active_set_qp_solver
                                                common::time
                                                planning::planning_gflags
                                                ${osqp_LIBRARIES})
add_library(planning::spline_2d_solver ALIAS planning_spline_2d_solver)


add_library(planning_active_set_spline_2d_solver active_set_spline_2d_solver.cc)
target_link_libraries(planning_active_set_spline_2d_solver planning::spline_2d_solver)
add_library(planning::active_set_spline_2d_solver ALIAS planning_active_set_spline_2d_solver)


add_library(planning_osqp_spline_2d_solver osqp_spline_2d_solver.cc)
target_link_libraries(planning_osqp_spline_2d_solver planning::spline_2d_solver
                                                     common::matrix_operations
                                                     ${osqp_LIBRARIES})
add_library(planning::osqp_spline_2d_solver ALIAS planning_osqp_spline_2d_solver)


add_library(planning_piecewise_linear_constraint piecewise_linear_constraint.cc)
target_link_libraries(planning_piecewise_linear_constraint cyber::common)
add_library(planning::piecewise_linear_constraint ALIAS planning_piecewise_linear_constraint)

add_library(planning_piecewise_linear_kernel piecewise_linear_kernel.cc)
target_link_libraries(planning_piecewise_linear_kernel cyber::common)
add_library(planning::piecewise_linear_kernel ALIAS planning_piecewise_linear_kernel)


add_library(planning_piecewise_linear_generator piecewise_linear_generator.cc)
target_link_libraries(planning_piecewise_linear_generator planning::piecewise_linear_constraint
                                                          planning::piecewise_linear_kernel
                                                          common::qp_solver
                                                          common::active_set_qp_solver)
add_library(planning::piecewise_linear_generator ALIAS planning_piecewise_linear_generator)

add_executable(active_set_spline_2d_solver_test spline_2d_solver_test.cc)
target_link_libraries(active_set_spline_2d_solver_test planning::active_set_spline_2d_solver
                                                       planning::curve_math
                                                       gtest
                                                       gtest_main)

add_executable(osqp_spline_2d_solver_test osqp_spline_2d_solver_test.cc)
target_link_libraries(osqp_spline_2d_solver_test planning::osqp_spline_2d_solver
                                                 planning::curve_math
                                                 gtest
                                                 gtest_main)


install(TARGETS planning_affine_constraint
                planning_spline_1d_seg
                planning_spline_1d
                planning_spline_1d_constraint
                planning_spline_2d_seg
                planning_spline_2d
                planning_spline_2d_constraint
                planning_spline_2d_kernel
                planning_spline_2d_solver
                planning_active_set_spline_2d_solver
                planning_osqp_spline_2d_solver
                planning_piecewise_linear_constraint
                planning_piecewise_linear_generator
                planning_piecewise_linear_kernel
                active_set_spline_2d_solver_test
                osqp_spline_2d_solver_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
