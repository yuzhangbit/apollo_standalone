cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_poll_data poll_data.h)
set_target_properties(cyber_poll_data PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::poll_data ALIAS cyber_poll_data)

add_library(cyber_poller poller.cc)
target_link_libraries(cyber_poller cyber::poll_data
                                   cyber::atomic_rw_lock
                                   cyber::log
                                   cyber::common_macros
                                   cyber::scheduler_factory
                                   cyber::time)
add_library(cyber::poller ALIAS cyber_poller)

add_library(cyber_poll_handler poll_handler.cc)
target_link_libraries(cyber_poll_handler cyber::poll_data
                                         cyber::poller
                                         cyber::log
                                         cyber::croutine)
add_library(cyber::poll_handler ALIAS cyber_poll_handler)

add_library(cyber_session session.cc)
target_link_libraries(cyber_session cyber::poll_handler
                                    cyber::log)
add_library(cyber::session ALIAS cyber_session)

add_library(cyber_io INTERFACE)
target_link_libraries(cyber_io INTERFACE
        cyber_poll_data
        cyber_poller
        cyber_poll_handler
        cyber_session)
add_library(cyber::io ALIAS cyber_io)


## gtest
add_executable(poller_test poller_test.cc)
target_link_libraries(poller_test gtest gtest_main gmock cyber::poller
                                                         cyber::cyber_core)

add_executable(tcp_echo_client example/tcp_echo_client.cc)
target_link_libraries(tcp_echo_client cyber::cyber_core)

add_executable(tcp_echo_server example/tcp_echo_server.cc)
target_link_libraries(tcp_echo_server cyber::cyber_core)

add_executable(udp_echo_client example/udp_echo_client.cc)
target_link_libraries(udp_echo_client cyber::cyber_core)

add_executable(udp_echo_server example/udp_echo_server.cc)
target_link_libraries(udp_echo_server cyber::cyber_core)


install(TARGETS cyber_poll_data
                cyber_poller
                cyber_poll_handler
                cyber_session
                cyber_io
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS poller_test
                tcp_echo_client
                tcp_echo_server
                udp_echo_client
                udp_echo_server
        RUNTIME DESTINATION bin
        )
