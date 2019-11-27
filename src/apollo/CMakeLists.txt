cmake_minimum_required(VERSION 3.5.1)
project(apollo)

find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

set(CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

add_subdirectory(deps/googletest EXCLUDE_FROM_ALL)

option(ENABLE_CUDA "enable cuda for planning" OFF)

find_package(PROTOBUF REQUIRED)
find_package(gflags REQUIRED)
find_package(qpOASES REQUIRED)
find_package(osqp REQUIRED)
find_package(GLOG REQUIRED)
find_package(curlpp REQUIRED)
find_package(TINYXML2 REQUIRED)
find_package(PROJ4 REQUIRED)
find_package(IPOPT REQUIRED)
find_package(ADOLC REQUIRED)
find_package(Eigen3 REQUIRED)

if(ENABLE_CUDA)
  find_package(CUDA REQUIRED)
  add_definitions(-DUSE_GPU)
  include_directories(${CUDA_INCLUDE_DIRS})
else()
  set(CUDA_LIBRARIES "")
  set(CUDA_INCLUDE_DIRS "")
endif(ENABLE_CUDA)


set(CMAKE_INSTALL_PREFIX /apollo)

include_directories(
  include
  ${gtest_SOURCE_DIR}/include/
  ${gmock_SOURCE_DIR}/include/
  ${gtest_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR})

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
add_subdirectory(third_party/tf2)

install(EXPORT apollo-export
  FILE apollo-export.cmake
  NAMESPACE apollo::
  DESTINATION share/apollo/cmake)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  apolloConfigVersion.cmake
  VERSION 5.0.0
  COMPATIBILITY AnyNewerVersion)

configure_package_config_file(
  cmake/apolloConfig.cmake.in
  apolloConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_PREFIX}/share/apollo/cmake)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/apolloConfig.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/apolloConfigVersion.cmake
  DESTINATION share/apollo/cmake)

install(DIRECTORY cmake
        DESTINATION share/apollo/cmake)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules
        DESTINATION .
        FILES_MATCHING PATTERN "*.pb.txt"
        PATTERN ".svn" EXCLUDE
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules
        DESTINATION .
        FILES_MATCHING PATTERN "*.txt"
        PATTERN ".svn" EXCLUDE
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules
        DESTINATION .
        FILES_MATCHING PATTERN "*.bin"
        PATTERN ".svn" EXCLUDE
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules
        DESTINATION .
        FILES_MATCHING PATTERN "*.conf"
        PATTERN ".svn" EXCLUDE
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules
        DESTINATION .
        FILES_MATCHING PATTERN "*.h"
        PATTERN ".svn" EXCLUDE
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cyber
        DESTINATION .
        FILES_MATCHING PATTERN "*.h"
        PATTERN ".svn" EXCLUDE
  )

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cyber
        DESTINATION .
        FILES_MATCHING PATTERN "*.*.pb.txt"
        PATTERN ".svn" EXCLUDE
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cyber
        DESTINATION .
        FILES_MATCHING PATTERN "*.conf"
        PATTERN ".svn" EXCLUDE
)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/deps/googletest/googletest/include/gtest/gtest_prod.h
  DESTINATION gtest/)
