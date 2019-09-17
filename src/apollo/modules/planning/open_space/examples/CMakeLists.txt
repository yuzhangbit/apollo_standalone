cmake_minimum_required(VERSION 3.5.1)

find_package(PythonLibs 2.7 REQUIRED)
#find_package(OpenCV 3 REQUIRED)

add_executable(open_space_palnner_demo
  example.cpp)
target_link_libraries(open_space_palnner_demo
  planning::hybrid_a_star
  planning::dual_variable_warm_start_problem
  planning::distance_approach_problem
  ${PYTHON_LIBRARIES}
#  ${OpenCV_LIBRARIES}
  )

install(TARGETS open_space_palnner_demo
  RUNTIME DESTINATION bin/example
  INCLUDES DESTINATION .
  )