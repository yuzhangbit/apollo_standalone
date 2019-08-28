cmake_minimum_required(VERSION 3.5.1)
add_subdirectory(adapter)

add_library(map_hdmap hdmap.cc
                      hdmap_common.cc
                      hdmap_impl.cc)

target_link_libraries(map_hdmap common::config_gflags
                                common::math
                                common::util
                                map::opendrive_adapter
                                map::proto
                                map::relative_map_proto
                                ${GLOG_LIBRARIES})

add_library(map::hdmap ALIAS map_hdmap)

add_library(map_hdmap_util hdmap_util.cc)
target_link_libraries(map_hdmap_util map::hdmap
                                     cyber::common
                                     common::util
                                     map::relative_map_proto)
add_library(map::hdmap_util ALIAS map_hdmap_util)

add_executable(hdmap_map_test hdmap_common_test.cc
                              hdmap_impl_test.cc)
target_link_libraries(hdmap_map_test gtest
                                     gtest_main
                                     common::util
                                     map::hdmap)

install(TARGETS map_hdmap
                map_hdmap_util
                hdmap_map_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
