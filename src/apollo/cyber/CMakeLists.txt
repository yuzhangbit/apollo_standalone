cmake_minimum_required(VERSION 3.5.1)

project(cyber)

add_library(cyber_binary binary.h)
set_target_properties(cyber_binary PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::binary ALIAS cyber_binary)

add_subdirectory(base)
add_subdirectory(common)
add_subdirectory(proto)
add_executable(cyber_test cyber_test.cc)
target_link_libraries(cyber_test gtest gtest_main)
