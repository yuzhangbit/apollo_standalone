cmake_minimum_required(VERSION 3.5.1)
project(common)

find_package(Eigen3 QUIET)
if(NOT EIGEN3_FOUND)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(EIGEN3 REQUIRED eigen3)
  set(EIGEN3_INCLUDE_DIR ${EIGEN3_INCLUDE_DIRS})
endif()

include_directories(${EIGEN3_INCLUDE_DIR})
add_subdirectory(util) #partial
add_subdirectory(proto)
add_subdirectory(math) #done

