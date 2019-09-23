cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_protobuf_factory protobuf_factory.cc)
target_link_libraries(cyber_protobuf_factory cyber::log
                                             cyber::common_macros
                                             cyber::proto)
add_library(cyber::protobuf_factory ALIAS cyber_protobuf_factory)

add_library(cyber_protobuf_traits protobuf_traits.h)
set_target_properties(cyber_protobuf_traits PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_protobuf_traits cyber::protobuf_factory)
add_library(cyber::protobuf_traits ALIAS cyber_protobuf_traits)

add_library(cyber_raw_message raw_message.h)
set_target_properties(cyber_raw_message PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_raw_message cyber::protobuf_factory)
add_library(cyber::raw_message ALIAS cyber_raw_message)

add_library(cyber_raw_message_traits raw_message_traits.h)
set_target_properties(cyber_raw_message_traits PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_raw_message_traits cyber::protobuf_factory
                                               cyber::raw_message)
add_library(cyber::raw_message_traits ALIAS cyber_raw_message_traits)

add_library(cyber_py_message py_message.h)
set_target_properties(cyber_py_message PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_py_message cyber::protobuf_factory)
add_library(cyber::py_message ALIAS cyber_py_message)

add_library(cyber_py_message_traits py_message_traits.h)
set_target_properties(cyber_py_message_traits PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_py_message_traits cyber::protobuf_factory
                                              cyber::py_message)
add_library(cyber::py_message_traits ALIAS cyber_py_message_traits)

add_library(cyber_intra_message intra_message.cc)
add_library(cyber::intra_message ALIAS cyber_intra_message)

add_library(cyber_message_header message_header.h)
set_target_properties(cyber_message_header PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::message_header ALIAS cyber_message_header)

add_library(cyber_message_traits message_traits.h)
set_target_properties(cyber_message_traits PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_message_traits cyber::intra_message
                                           cyber::message_header
                                           cyber::protobuf_traits
                                           cyber::py_message_traits
                                           cyber::raw_message_traits
                                           cyber::base_macros)
add_library(cyber::message_traits ALIAS cyber_message_traits)


## gtest
add_executable(message_header_test message_header_test.cc)
target_link_libraries(message_header_test gtest gtest_main gmock cyber::cyber) #todo cyber

## todo: fix
# add_executable(raw_message_test raw_message_test.cc)
# target_link_libraries(raw_message_test gtest gtest_main gmock cyber::cyber) #todo cyber

# add_executable(protobuf_factory_test raw_message_test.cc)
# target_link_libraries(raw_message_test gtest gtest_main gmock cyber::proto
#                                                               cyber::cyber) #todo cyber


install(TARGETS cyber_protobuf_factory
                cyber_protobuf_traits
                cyber_raw_message
                cyber_raw_message_traits
                cyber_py_message
                cyber_py_message_traits
                cyber_intra_message
                cyber_message_header
                cyber_message_traits
    message_header_test
                # raw_message_test
                # protobuf_factory_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
