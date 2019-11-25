cmake_minimum_required(VERSION 3.5.1)

add_library(common_time timer.cc)
target_link_libraries(common_time cyber::time
                                  common::config_gflags)
add_library(common::time ALIAS common_time)

add_executable(common_time_test time_test.cc)
target_link_libraries(common_time_test common::time gtest gtest_main)

add_executable(common_timer_test timer_test.cc)
target_link_libraries(common_timer_test common::time gtest gtest_main)

add_library(common_time_module INTERFACE)
target_link_libraries(common_time_module INTERFACE
        common_time
        )

install(TARGETS common_time
                common_time_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)

install(TARGETS common_time_test
                common_timer_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
