###############################################################################
#
# CMake script for finding the GFlags library.
#
# https://gflags.github.io/gflags/
#
# Redistribution and use is allowed according to the terms of the 3-clause BSD
# license.
#
# Input variables:
#
# - Gflags_FIND_REQUIRED: throws an error if gflags is not found but it is required
#
# Output variables:
#
# - gflags_FOUND: Boolean that indicates if the package was found
# - gflags_LIBRARIES: Package libraries
# - gflags_INCLUDE_DIRS: Absolute path to package headers
#
# Example usage:
#
#   find_package(Gflags REQUIRED)
#
#   include_directories(
#     ${Gflags_INCLUDE_DIRS}
#   )
#
#   add_executable(main src/main.cpp)
#   target_link_libraries(main
#     ${Gflags_LIBRARIES}
#   )
###############################################################################


find_path(gflags_INCLUDE_PATH gflags/gflags.h)

find_library(gflags_LIBRARY NAMES gflags libgflags)

if(gflags_INCLUDE_PATH AND gflags_LIBRARY)
  set(gflags_FOUND TRUE)
endif(gflags_INCLUDE_PATH AND gflags_LIBRARY)

if(gflags_FOUND)
  message(STATUS "Found gflags-lib:" ${gflags_LIBRARY})
  message(STATUS "Found gflags-header:" ${gflags_INCLUDE_PATH})

  # Output variables
  set(gflags_INCLUDE_DIRS ${gflags_INCLUDE_PATH})
  set(gflags_LIBRARIES ${gflags_LIBRARY})
else(gflags_FOUND)
  if(gflags_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find gflags library.")
  endif(gflags_FIND_REQUIRED)
endif(gflags_FOUND)
