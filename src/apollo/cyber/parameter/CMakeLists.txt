cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_parameter_service_names parameter_service_names.h)
set_target_properties(cyber_parameter_service_names PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::parameter_service_names ALIAS cyber_parameter_service_names)

add_library(cyber_parameter parameter.cc)
target_link_libraries(cyber_parameter cyber::protobuf_factory
                                      cyber::proto)
add_library(cyber::parameter ALIAS cyber_parameter)

add_library(cyber_parameter_client parameter_client.cc)
target_link_libraries(cyber_parameter_client cyber::parameter
                                             cyber::parameter_service_names
                                             cyber::node
                                             cyber::client
                                             ${FastRTPS_LIBRARIES}
                                             ${FastCDR_LIBRARIES}
                                             )
add_library(cyber::parameter_client ALIAS cyber_parameter_client)

add_library(cyber_parameter_server parameter_server.cc)
target_link_libraries(cyber_parameter_server cyber::parameter
                                             cyber::parameter_service_names
                                             cyber::node
                                             cyber::service
                                             ${FastRTPS_LIBRARIES}
                                             ${FastCDR_LIBRARIES}
                                             )
add_library(cyber::parameter_server ALIAS cyber_parameter_server)

add_library(cyber_parameter_module INTERFACE)
target_link_libraries(cyber_parameter_module INTERFACE
        cyber_parameter_service_names
        cyber_parameter
        cyber_parameter_client
        cyber_parameter_server
        )

## gtest
add_executable(parameter_test parameter_test.cc)
target_link_libraries(parameter_test gtest gtest_main gmock
                                     cyber::cyber)

add_executable(parameter_client_test parameter_client_test.cc)
target_link_libraries(parameter_client_test gtest gtest_main gmock
                                            cyber::cyber)

add_executable(parameter_server_test parameter_server_test.cc)
target_link_libraries(parameter_server_test gtest gtest_main gmock
                                            cyber::cyber)

install(TARGETS cyber_parameter_service_names
                cyber_parameter
                cyber_parameter_client
                cyber_parameter_server
                cyber_parameter_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS parameter_test
                parameter_client_test
                parameter_server_test
        RUNTIME DESTINATION bin
        )
