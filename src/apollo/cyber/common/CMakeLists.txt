cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_common INTERFACE)
target_link_libraries(cyber_common INTERFACE
    cyber::environment
    cyber::file
    cyber::global_data
    cyber::log
    cyber::common_macros
    cyber::time_conversion
    cyber::types
    cyber::util)
add_library(cyber::common ALIAS cyber_common)


add_library(cyber_file file.cc)
set_target_properties(cyber_file PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_file cyber::log
                                 ${GLOG_LIBRARIES})
add_library(cyber::file ALIAS cyber_file)

add_library(cyber_log log.h)
set_target_properties(cyber_log PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_log cyber::binary
                                ${GLOG_LIBRARIES})
add_library(cyber::log ALIAS cyber_log)

add_library(cyber_environment environment.h)
set_target_properties(cyber_environment PROPERTIES LINKER_LANGUAGE CXX)

target_link_libraries(cyber_environment cyber::log)
add_library(cyber::environment ALIAS cyber_environment)

add_library(cyber_global_data global_data.cc)
target_link_libraries(cyber_global_data cyber::base
                                        cyber::file
                                        cyber::common_macros
                                        cyber::util
                                        cyber::proto)
add_library(cyber::global_data ALIAS cyber_global_data)

add_library(cyber_common_macros macros.h)
set_target_properties(cyber_common_macros PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_common_macros cyber::base_macros)
add_library(cyber::common_macros ALIAS cyber_common_macros)

add_library(cyber_time_conversion time_conversion.h)
set_target_properties(cyber_time_conversion PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::time_conversion ALIAS cyber_time_conversion)

add_library(cyber_types types.h)
set_target_properties(cyber_types PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::types ALIAS cyber_types)


add_library(cyber_util util.h)
set_target_properties(cyber_util PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::util ALIAS cyber_util)


## gtest
add_executable(file_test file_test.cc)
target_link_libraries(file_test gtest gtest_main gmock cyber::proto cyber::common)
add_executable(log_test log_test.cc)
target_link_libraries(log_test gtest gtest_main cyber::log)
add_executable(macros_test macros_test.cc)
target_link_libraries(macros_test gtest gtest_main cyber::base cyber::common cyber::proto)

add_library(cyber_common_module INTERFACE)
target_link_libraries(cyber_common_module INTERFACE
											cyber_common
											cyber_file
											cyber_log
											cyber_environment
											cyber_global_data
											cyber_common_macros
											cyber_time_conversion
											cyber_types
											cyber_util)


install(TARGETS cyber_common_module
								cyber_common
                cyber_file
                cyber_log
                cyber_environment
                cyber_global_data
                cyber_common_macros
                cyber_time_conversion
                cyber_types
                cyber_util
				EXPORT apollo-export
				LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS file_test
								log_test
								macros_test
				RUNTIME DESTINATION bin
	)
