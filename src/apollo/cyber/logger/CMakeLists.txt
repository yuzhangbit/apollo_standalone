cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_logger_util logger_util.cc)
target_link_libraries(cyber_logger_util cyber::global_data)
add_library(cyber::logger_util ALIAS cyber_logger_util)

add_library(cyber_log_file_object log_file_object.cc)
target_link_libraries(cyber_log_file_object cyber::binary
                                            cyber::log
                                            cyber::logger_util)
add_library(cyber::log_file_object ALIAS cyber_log_file_object)

add_library(cyber_async_logger async_logger.cc)
target_link_libraries(cyber_async_logger cyber::base_macros
                                         cyber::common
                                         cyber::log_file_object)
add_library(cyber::async_logger ALIAS cyber_async_logger)

add_library(cyber_logger logger.cc)
target_link_libraries(cyber_logger cyber::base_macros
                                   cyber::common
                                   cyber::log_file_object)
add_library(cyber::logger ALIAS cyber_logger)

## gtest
add_executable(logger_test logger_test.cc)
target_link_libraries(logger_test gtest gtest_main gmock cyber::cyber) #todo

add_library(cyber_logger_module INTERFACE)
target_link_libraries(cyber_logger_module INTERFACE
                      cyber_logger_util
                      cyber_log_file_object
                      cyber_async_logger
                      cyber_logger)


install(TARGETS cyber_logger_module
                cyber_logger_util
                cyber_log_file_object
                cyber_async_logger
                cyber_logger
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
install(TARGETS logger_test
        RUNTIME DESTINATION bin
  )