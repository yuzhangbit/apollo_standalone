cmake_minimum_required(VERSION 3.5.1)

add_library(common_string_util string_util.cc)
target_link_libraries(common_string_util ${PROTOBUF_LIBRARIES})
add_library(common::string_util ALIAS common_string_util)
