cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_section file/section.h)
set_target_properties(cyber_section PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::section ALIAS cyber_section)

add_library(cyber_record_base record_base.h)
set_target_properties(cyber_record_base PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_record_base cyber::proto)
add_library(cyber::record_base ALIAS cyber_record_base)

add_library(cyber_record_message record_message.h)
set_target_properties(cyber_record_message PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::record_message ALIAS cyber_record_message)


add_library(cyber_record_file_base file/record_file_base.cc)
target_link_libraries(cyber_record_file_base cyber::log
                                   cyber::proto)
add_library(cyber::record_file_base ALIAS cyber_record_file_base)

add_library(cyber_record_file_reader file/record_file_reader.cc)
target_link_libraries(cyber_record_file_reader cyber::record_file_base
                                               cyber::section
                                               cyber::file
                                               cyber::time)
add_library(cyber::record_file_reader ALIAS cyber_record_file_reader)

add_library(cyber_record_file_writer file/record_file_writer.cc)
target_link_libraries(cyber_record_file_writer cyber::record_file_base
                                               cyber::section
                                               cyber::file
                                               cyber::time)
add_library(cyber::record_file_writer ALIAS cyber_record_file_writer)


add_library(cyber_header_builder header_builder.cc)
target_link_libraries(cyber_header_builder cyber::proto)
add_library(cyber::header_builder ALIAS cyber_header_builder)

add_library(cyber_record_reader record_reader.cc)
target_link_libraries(cyber_record_reader cyber::record_base
                                          cyber::record_file_reader
                                          cyber::record_message)
add_library(cyber::record_reader ALIAS cyber_record_reader)

add_library(cyber_record_viewer record_viewer.cc)
target_link_libraries(cyber_record_viewer cyber::record_message
                                          cyber::record_reader)
add_library(cyber::record_viewer ALIAS cyber_record_viewer)

add_library(cyber_record_writer record_writer.cc)
target_link_libraries(cyber_record_writer cyber::header_builder
                                          cyber::record_base
                                          cyber::record_file_writer
                                          cyber::raw_message
                                          cyber::proto)
add_library(cyber::record_writer ALIAS cyber_record_writer)


add_library(cyber_record_module INTERFACE)
target_link_libraries(cyber_record_module INTERFACE
        cyber_record_reader
        cyber_record_viewer
        cyber_record_writer
        )
add_library(cyber::record ALIAS cyber_record_module)


## gtest
add_executable(record_file_test file/record_file_test.cc)
target_link_libraries(record_file_test gtest gtest_main gmock cyber::proto
                                       cyber::cyber)

add_executable(record_reader_test record_reader_test.cc)
target_link_libraries(record_reader_test gtest gtest_main gmock
                                         cyber::cyber
                                         cyber::proto)

add_executable(record_viewer_test record_viewer_test.cc)
target_link_libraries(record_viewer_test gtest gtest_main gmock
                                         cyber::cyber
                                         cyber::proto)


install(TARGETS cyber_section
                cyber_record_base
                cyber_record_message
                cyber_record_file_base
                cyber_record_file_reader
                cyber_record_file_writer
                cyber_header_builder
                cyber_record_reader
                cyber_record_viewer
                cyber_record_writer
                cyber_record_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS record_file_test
                record_reader_test
                record_viewer_test
        RUNTIME DESTINATION bin
        )
