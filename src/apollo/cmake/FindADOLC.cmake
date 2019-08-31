# Find ADOLC
#
# This sets the following variables:
# ADOLC_FOUND
# ADOLC_INCLUDE_DIRS
# ADOLC_LIBRARIES
# ADOLC_DEFINITIONS
# ADOLC_VERSION

find_path(adolc_INCLUDE_PATH adolc/adolc.h)

find_library(adolc_LIBRARY libadolc.so PATHS /usr/local/lib64)
set(adolc_LIBRARY "/usr/local/lib64/libadolc.so")
if(adolc_INCLUDE_PATH AND adolc_LIBRARY)
  set(ADOLC_FOUND TRUE)
endif(adolc_INCLUDE_PATH AND adolc_LIBRARY)

if(ADOLC_FOUND)
  message(STATUS "Found adolc:" ${adolc_LIBRARY})
  # Output variables
  set(ADOLC_INCLUDE_DIRS ${adolc_INCLUDE_PATH})
  set(ADOLC_LIBRARIES ${adolc_LIBRARY})
else(ADOLC_FOUND)
  if(ADOLC_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find adolc library.")
  endif(ADOLC_FIND_REQUIRED)
endif(ADOLC_FOUND)
