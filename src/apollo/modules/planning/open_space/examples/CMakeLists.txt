cmake_minimum_required(VERSION 3.5.1)
set(Python_ADDITIONAL_VERSIONS 3)
find_package(PythonLibs 3 REQUIRED)

message("**************python include dirs: ${PYTHON_INCLUDE_DIRS}")
message("**************python library dirs: ${PYTHON_LIBRARIES}")

add_executable(open_space_palnner_demo
  open_space_demo.cpp)
target_include_directories(open_space_palnner_demo
  PUBLIC
  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(open_space_palnner_demo
  planning::hybrid_a_star
  planning::dual_variable_warm_start_problem
  planning::distance_approach_problem
  ${PYTHON_LIBRARIES}
  )

install(TARGETS open_space_palnner_demo
  RUNTIME DESTINATION example
  INCLUDES DESTINATION .
  )