cmake_minimum_required(VERSION 3.5.1)

add_library(common_status status.h)
set_target_properties(common_status PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_status ${PROTOBUF_LIBRARIES} common::proto)
add_library(common::status ALIAS common_status)

add_executable(status_test status_test.cc)
target_link_libraries(status_test common::status gtest gtest_main)

add_library(common_status_module INTERFACE)
target_link_libraries(common_status_module INTERFACE
        common_status
        )

install(TARGETS common_status
                common_status_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS status_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
