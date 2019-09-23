cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_cache_buffer cache_buffer.h)
set_target_properties(cyber_cache_buffer PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::cache_buffer ALIAS cyber_cache_buffer)

add_library(cyber_data_dispatcher data_dispatcher.h)
set_target_properties(cyber_data_dispatcher PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_data_dispatcher cyber::channel_buffer)
add_library(cyber::data_dispatcher ALIAS cyber_data_dispatcher)

add_library(cyber_data_visitor data_visitor.h)
set_target_properties(cyber_data_visitor PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::data_visitor ALIAS cyber_data_visitor)

add_library(cyber_data_visitor_base data_visitor_base.h)
set_target_properties(cyber_data_visitor_base PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::data_visitor_base ALIAS cyber_data_visitor_base)

add_library(cyber_data_notifier data_notifier.h)
set_target_properties(cyber_data_notifier PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_data_notifier cyber::cache_buffer)
add_library(cyber::data_notifier ALIAS cyber_data_notifier)

add_library(cyber_channel_buffer channel_buffer.h)
set_target_properties(cyber_channel_buffer PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_channel_buffer cyber::data_notifier
                                           cyber::proto)
add_library(cyber::channel_buffer ALIAS cyber_channel_buffer)

add_library(cyber_data_fusion fusion/data_fusion.h)
set_target_properties(cyber_data_fusion PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::data_fusion ALIAS cyber_data_fusion)

add_library(cyber_all_latest fusion/all_latest.h)
set_target_properties(cyber_all_latest PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_channel_buffer cyber::channel_buffer
                                           cyber::data_fusion)
add_library(cyber::all_latest ALIAS cyber_all_latest)

add_library(cyber_data fusion/all_latest.h)
set_target_properties(cyber_data PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_data cyber::cache_buffer
                                 cyber::channel_buffer
                                 cyber::data_dispatcher
                                 cyber::data_fusion
                                 cyber::data_notifier
                                 cyber::data_visitor
                                 cyber::data_visitor_base)
add_library(cyber::data ALIAS cyber_data)

## gtest
add_executable(cache_buffer_test cache_buffer_test.cc)
target_link_libraries(cache_buffer_test gtest gtest_main gmock cyber::cache_buffer)

add_executable(data_visitor_test data_visitor_test.cc)
target_link_libraries(data_visitor_test gtest gtest_main gmock cyber::cyber)

add_executable(data_dispatcher_test data_dispatcher_test.cc)
target_link_libraries(data_dispatcher_test gtest gtest_main gmock cyber::cyber)

add_executable(channel_buffer_test channel_buffer_test.cc)
target_link_libraries(channel_buffer_test gtest gtest_main gmock cyber::cyber)

add_executable(all_latest_test fusion/all_latest_test.cc)
target_link_libraries(all_latest_test gtest gtest_main gmock cyber::cyber)

install(TARGETS cyber_cache_buffer
                cyber_data_dispatcher
                cyber_data_visitor
                cyber_data_visitor_base
                cyber_data_notifier
                cyber_channel_buffer
                cyber_data_fusion
                cyber_all_latest
                cyber_data
    cache_buffer_test
                data_visitor_test
                data_dispatcher_test
                channel_buffer_test
                all_latest_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
