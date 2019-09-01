find_path(osqp_INCLUDE_PATH osqp/include/osqp.h)

# find_library(osqp_LIBRARY libosqp.a)
find_library(osqp_LIBRARY  libosqp.so)
if(osqp_INCLUDE_PATH AND osqp_LIBRARY)
  set(osqp_FOUND TRUE)
endif(osqp_INCLUDE_PATH AND osqp_LIBRARY)

if(osqp_FOUND)
  message(STATUS "Found osqp:" ${osqp_LIBRARY})
  # Output variables
  set(osqp_INCLUDE_DIRS ${osqp_INCLUDE_PATH})
  set(osqp_LIBRARIES ${osqp_LIBRARY})
else(osqp_FOUND)
  if(osqp_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find osqp library.")
  endif(osqp_FIND_REQUIRED)
endif(osqp_FOUND)
