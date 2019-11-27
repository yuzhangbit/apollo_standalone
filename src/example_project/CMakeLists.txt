cmake_minimum_required(VERSION 3.5.1)
project(example_project)

set(CMAKE_CXX_STANDARD 11)

set(Python_ADDITIONAL_VERSIONS 3)
find_package(PythonLibs 3 REQUIRED)

list(APPEND CMAKE_PREFIX_PATH "/apollo")
find_package(apollo 5.0.0 CONFIG REQUIRED)

include_directories(include)

add_executable(listener src/listener.cc)
target_link_libraries(listener apollo::cyber)

add_executable(talker src/talker.cc)
target_link_libraries(talker apollo::cyber)

add_executable(open_space_palnner_demo src/open_space_demo.cpp)
target_include_directories(open_space_palnner_demo
  PUBLIC
  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(open_space_palnner_demo
  apollo::planning
  ${PYTHON_LIBRARIES}
  )
