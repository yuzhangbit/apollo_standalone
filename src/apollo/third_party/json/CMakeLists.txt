cmake_minimum_required(VERSION 3.5.1)

add_library(3rdparty_json json.hpp)
set_target_properties(3rdparty_json PROPERTIES LINKER_LANGUAGE CXX)
add_library(3rdparty::json ALIAS 3rdparty_json)
