cmake_minimum_required(VERSION 3.5.1)
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()
project(apollo)

set(CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

add_subdirectory(deps/googletest EXCLUDE_FROM_ALL)

find_package(PROTOBUF REQUIRED)
find_package(gflags REQUIRED)
find_package(qpOASES REQUIRED)
find_package(osqp REQUIRED)
find_package(GLOG REQUIRED)
find_package(curlpp REQUIRED)
find_package(TinyXML2 REQUIRED)
find_package(PROJ4 REQUIRED)
find_package(IPOPT REQUIRED)
find_package(ADOLC REQUIRED)
find_package(Eigen3 QUIET)

if(NOT EIGEN3_FOUND)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(EIGEN3 REQUIRED eigen3)
  set(EIGEN3_INCLUDE_DIR ${EIGEN3_INCLUDE_DIRS})
endif()
include_directories(include
                    ${gtest_SOURCE_DIR}/include/
                    ${gmock_SOURCE_DIR}/include/
                    ${gtest_SOURCE_DIR}
                    ${CMAKE_CURRENT_SOURCE_DIR}
                    ${qpOASES_INCLUDE_DIRS}
                    ${osqp_INCLUDE_DIRS}
                    ${TINYXML2_INCLUDE_DIRS}
                    ${IPOPT_INCLUDE_DIRS}
                    ${PROJ4_INCLUDE_DIRS}
                    ${ADOLC_INCLUDE_DIRS}
                    ${EIGEN3_INCLUDE_DIR})

add_executable(utest utest.cc)
target_link_libraries(utest gtest gtest_main)

add_subdirectory(cyber)
add_subdirectory(modules/common)
add_subdirectory(modules/localization)
add_subdirectory(modules/canbus)
add_subdirectory(modules/map)
add_subdirectory(modules/perception)
add_subdirectory(modules/prediction)
add_subdirectory(modules/routing)
add_subdirectory(modules/planning)
add_subdirectory(modules/dreamview)
add_subdirectory(third_party/json)
