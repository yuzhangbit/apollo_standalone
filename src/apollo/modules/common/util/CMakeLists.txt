cmake_minimum_required(VERSION 3.5.1)

add_library(common_string_util string_util.cc)
target_link_libraries(common_string_util ${PROTOBUF_LIBRARIES})
add_library(common::string_util ALIAS common_string_util)


add_executable(common_string_util_test string_util_test.cc)
target_link_libraries(common_string_util_test gtest
                                              gtest_main
                                              common::string_util)

install(TARGETS common_string_util
                common_string_util_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )