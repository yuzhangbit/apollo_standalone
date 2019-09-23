cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_node node.cc)
target_link_libraries(cyber_node cyber::node_channel_impl
                                 cyber::node_service_impl)
add_library(cyber::node ALIAS cyber_node)

add_library(cyber_node_channel_impl node_channel_impl.h)
set_target_properties(cyber_node_channel_impl PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_node_channel_impl cyber::reader
                                              cyber::writer
                                              cyber::intra_reader
                                              cyber::intra_writer
                                              cyber::global_data
                                              cyber::message_traits
                                              cyber::proto)
add_library(cyber::node_channel_impl ALIAS cyber_node_channel_impl)

add_library(cyber_node_service_impl node_service_impl.h)
set_target_properties(cyber_node_service_impl PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_node_service_impl cyber::reader
                                              cyber::writer
                                              cyber::global_data
                                              cyber::service
                                              cyber::client
                                              cyber::topology_manager)
add_library(cyber::node_service_impl ALIAS cyber_node_service_impl)

add_library(cyber_reader_base reader_base.h)
set_target_properties(cyber_reader_base PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_reader_base cyber::perf_event_cache
                                        cyber::transport)
add_library(cyber::reader_base ALIAS cyber_reader_base)

add_library(cyber_reader reader.h)
set_target_properties(cyber_reader PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_reader cyber::reader_base
                                   cyber::blocker
                                   cyber::global_data
                                   cyber::routine_factory
                                   cyber::proto
                                   cyber::scheduler
                                   cyber::topology_manager
                                   cyber::time
                                   cyber::transport)
add_library(cyber::reader ALIAS cyber_reader)

add_library(cyber_writer_base writer_base.h)
set_target_properties(cyber_writer_base PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_writer_base cyber::common_macros
                                        cyber::util
                                        cyber::proto)
add_library(cyber::writer_base ALIAS cyber_writer_base)

add_library(cyber_writer writer.h)
set_target_properties(cyber_writer PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_writer cyber::writer_base
                                   cyber::log
                                   cyber::proto
                                   cyber::topology_manager
                                   cyber::transport)
add_library(cyber::writer ALIAS cyber_writer)

## gtest
add_executable(writer_reader_test writer_reader_test.cc)
target_link_libraries(writer_reader_test gtest gtest_main gmock cyber::cyber
                                                                cyber::proto)

add_executable(node_test node_test.cc)
target_link_libraries(node_test gtest gtest_main gmock cyber::cyber
                                                       cyber::proto)


install(TARGETS cyber_node
                cyber_node_channel_impl
                cyber_node_service_impl
                cyber_reader_base
                cyber_reader
                cyber_writer_base
                cyber_writer
    writer_reader_test
                node_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
