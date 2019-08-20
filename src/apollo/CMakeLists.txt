cmake_minimum_required(VERSION 3.5.1)

project(apollo)

set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_C_COMPILER /usr/bin/gcc-4.8)
#set(CMAKE_CXX_COMPILER /usr/bin/g++-4.8)


list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

add_subdirectory(deps/googletest EXCLUDE_FROM_ALL)

find_package(PROTOBUF REQUIRED)
find_package(gflags REQUIRED)
find_package(GLOG REQUIRED)

include_directories(include
                    ${gtest_SOURCE_DIR}/include/
                    ${gmock_SOURCE_DIR}/include/
                    ${gtest_SOURCE_DIR}
                    ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(utest utest.cc)
target_link_libraries(utest gtest gtest_main)


add_subdirectory(cyber)
add_subdirectory(modules/common)



