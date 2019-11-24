# FindPROJ4.cmake
#
# Finds the proj4 library
#
# This will define the following variables
#
#    PROJ4_FOUND
#    PROJ4_INCLUDE_DIRS
#    PROJ4_LIBRARIES
#m

find_package(PkgConfig)
pkg_check_modules(PC_PROJ4 QUIET PROJ4)

find_path(PROJ4_INCLUDE_DIR
    NAMES proj_api.h
    PATHS ${PC_PROJ4_INCLUDE_DIRS}
)
    
find_library(PROJ4_LIBRARY
    NAMES libproj.so
	PATHS ${PC_PROJ4_LIBRARY_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PROJ4
    REQUIRED_VARS PROJ4_INCLUDE_DIR PROJ4_LIBRARY
    FOUND_VAR PROJ4_FOUND
)

if(PROJ4_FOUND)
    set(PROJ4_INCLUDE_DIRS ${PROJ4_INCLUDE_DIR})
    set(PROJ4_LIBRARIES ${PROJ4_LIBRARY})
endif()

mark_as_advanced(PROJ4_INCLUDE_DIRS PROJ4_LIBRARIES)
