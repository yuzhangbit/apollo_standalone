# # TinyXML2_FOUND
# # TinyXML2_INCLUDE_DIRS
# # TinyXML2_LIBRARIES

# # try to find the CMake config file for TinyXML2 first
# find_package(TinyXML2 CONFIG QUIET)
# if(TinyXML2_FOUND)
#   message(STATUS "Found TinyXML2 via Config file: ${TinyXML2_DIR}")
#   if(NOT TINYXML2_LIBRARY)
#     # in this case, we're probably using TinyXML2 version 5.0.0 or greater
#     # in which case tinyxml2 is an exported target and we should use that
#     if(TARGET tinyxml2)
#       set(TINYXML2_LIBRARY tinyxml2)
#     elseif(TARGET tinyxml2::tinyxml2)
#       set(TINYXML2_LIBRARY tinyxml2::tinyxml2)
#     endif()
#   endif()
# else()
#   find_path(TINYXML2_INCLUDE_DIR NAMES tinyxml2.h)

#   find_library(TINYXML2_LIBRARY tinyxml2)

#   include(FindPackageHandleStandardArgs)
#   find_package_handle_standard_args(TinyXML2 DEFAULT_MSG TINYXML2_LIBRARY TINYXML2_INCLUDE_DIR)

#   mark_as_advanced(TINYXML2_INCLUDE_DIR TINYXML2_LIBRARY)
# endif()

# # Set mixed case INCLUDE_DIRS and LIBRARY variables from upper case ones.
# if(NOT TinyXML2_INCLUDE_DIRS)
#   set(TinyXML2_INCLUDE_DIRS ${TINYXML2_INCLUDE_DIR})
# endif()
# if(NOT TinyXML2_LIBRARIES)
#   set(TinyXML2_LIBRARIES ${TINYXML2_LIBRARY})
# endif()




# find_package(PkgConfig)

# pkg_check_modules(PC_TINYXML2 REQUIRED tinyxml2>=7.1.0)

# set(TINYXML2_DEFINITIONS ${PC_TINYXML2_CFLAGS_OTHER})
# set(TINYXML2_INCLUDE_DIRS ${PC_TINYXML2_INCLUDE_DIRS})
# set(TINYXML2_LIBRARIES ${PC_TINYXML2_LIBRARIES})
# set(TINYXML2_VERSION ${PC_TINYXML2_VERSION})
# include(FindPackageHandleStandardArgs)
# # if all listed variables are TRUE
# find_package_handle_standard_args(TINYXML2 DEFAULT_MSG
#     TINYXML2_LIBRARIES TINYXML2_INCLUDE_DIRS)
# mark_as_advanced(TINYXML2_INCLUDE_DIRS TINYXML2_LIBRARIES)

# if(${TINYXML2_FOUND})
#   message(STATUS "Found TINYXML2 version: " ${TINYXML2_VERSION} " installed in: " ${PC_TINYXML2_PREFIX})
#   message(STATUS "Found TINYXML2 libraries: " ${TINYXML2_LIBRARIES})
# else()
#   message(SEND_ERROR "Could not find TINYXML2")
# endif()



find_path(TINYXML2_INCLUDE_PATH tinyxml2/tinyxml2.h)
find_path(TINYXML2_INCLUDE_PATH tinyxml2.h)

find_library(TINYXML2_LIBRARY libtinyxml2.so)

if(TINYXML2_INCLUDE_PATH AND TINYXML2_LIBRARY)
  set(TINYXML2_FOUND TRUE)
endif(TINYXML2_INCLUDE_PATH AND TINYXML2_LIBRARY)

if(TINYXML2_FOUND)
  message(STATUS "Found tinyxml2:" ${TINYXML2_LIBRARY})
  # Output variables
  set(TINYXML2_INCLUDE_DIRS ${TINYXML2_INCLUDE_DIR})
  set(TINYXML2_LIBRARIES ${TINYXML2_LIBRARY})
else(TINYXML2_FOUND)
  if(TINYXML2_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find TINYXML2 library.")
  endif(TINYXML2_FIND_REQUIRED)
endif(TINYXML2_FOUND)
