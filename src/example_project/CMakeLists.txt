cmake_minimum_required(VERSION 3.5.1)
project(example_project)

set(CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_PREFIX_PATH "/apollo")

find_package(apollo CONFIG REQUIRED)

add_executable(listener src/listener.cc)
target_link_libraries(listener apollo::cyber apollo::cyber_proto)

add_executable(talker src/talker.cc)
target_link_libraries(talker apollo::cyber apollo::cyber_proto)

