cmake_minimum_required(VERSION 3.5.1)
project(common)

find_package(Eigen3 QUIET)
if(NOT EIGEN3_FOUND)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(EIGEN3 REQUIRED eigen3)
  set(EIGEN3_INCLUDE_DIR ${EIGEN3_INCLUDE_DIRS})
endif()

include_directories(${EIGEN3_INCLUDE_DIR})
add_subdirectory(util) #done
add_subdirectory(proto) #done
add_subdirectory(math) #done
add_subdirectory(configs) #done
add_subdirectory(time) #done
add_subdirectory(status) #done
add_subdirectory(adapters) #done

