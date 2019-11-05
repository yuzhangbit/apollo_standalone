cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_client client.h)
set_target_properties(cyber_client PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_client cyber::client_base)
add_library(cyber::client ALIAS cyber_client)

add_library(cyber_client_base client_base.h)
set_target_properties(cyber_client_base PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::client_base ALIAS cyber_client_base)

add_library(cyber_service_base service_base.h)
set_target_properties(cyber_service_base PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::service_base ALIAS cyber_service_base)

add_library(cyber_service service.h)
set_target_properties(cyber_service PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_service cyber::service_base
                                    cyber::scheduler)
add_library(cyber::service ALIAS cyber_service)


install(TARGETS cyber_client
                cyber_client_base
                cyber_service_base
                cyber_service
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
