cmake_minimum_required(VERSION 3.5.1)

add_library(adapter_gflags adapter_gflags.cc)
target_link_libraries(adapter_gflags ${gflags_LIBRARIES})
add_library(common::adapter_gflags ALIAS adapter_gflags)