cmake_minimum_required(VERSION 3.5.1)

project(apollo)

set(CMAKE_CXX_STANDARD 11)

add_subdirectory(deps/googletest EXCLUDE_FROM_ALL)
include_directories(include
                    ${gtest_SOURCE_DIR}/include/
                    ${gtest_SOURCE_DIR})


add_executable(utest utest.cc)
target_link_libraries(utest gtest gtest_main)