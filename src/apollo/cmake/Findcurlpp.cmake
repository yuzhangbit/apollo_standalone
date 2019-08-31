#~ finds curlpp

find_package(CURL REQUIRED)

set(store_cfls ${CMAKE_FIND_LIBRARY_SUFFIXES})
set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")
set(CURLPP_FIND_NAMES curlpp libcurlpp)
set(CURLPP_INCLUDE_PREFIX "curlpp/")
#~ set(CURLPP_INCLUDE_SEARCHES "Easy.hpp" "cURLpp.hpp" "Info.hpp" "Infos.hpp" "Option.hpp" "Options.hpp" "Form.hpp")
set(CURLPP_INCLUDE_SEARCHES "cURLpp.hpp")


find_path(CURLPP_INCLUDE_DIR NAMES ${CURLPP_INCLUDE_SEARCHES} PATH_SUFFIXES ${CURLPP_INCLUDE_PREFIX})
find_library(CURLPP_LIBRARY NAMES ${CURLPP_FIND_NAMES} PATHS "/usr/local/lib")

set(curlpp_LIBRARIES ${CURL_LIBRARIES} ${CURLPP_LIBRARY})
set(curlpp_INCLUDE_DIRS ${CURL_INCLUDE_DIRS} ${CURLPP_INCLUDE_DIR})

if (curlpp_LIBRARIES AND curlpp_INCLUDE_DIRS)
set(curlpp_FOUND TRUE)
endif(curlpp_LIBRARIES AND curlpp_INCLUDE_DIRS)

include(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args(curlpp DEFAULT_MSG curlpp_LIBRARIES curlpp_INCLUDE_DIRS)

mark_as_advanced(curlpp_LIBRARIES curlpp_INCLUDE_DIRS)
set(CMAKE_FIND_LIBRARY_SUFFIXES "${store_cfls}")