cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_blocker blocker.h)
set_target_properties(cyber_blocker PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::blocker ALIAS cyber_blocker)

add_library(cyber_blocker_manager blocker_manager.cc)
add_library(cyber::blocker_manager ALIAS cyber_blocker_manager)

add_library(cyber_intra_reader intra_reader.h)
add_library(cyber::intra_reader ALIAS cyber_intra_reader)
target_link_libraries(cyber_intra_reader cyber::blocker_manager)

add_library(cyber_intra_writer intra_writer.h)
add_library(cyber::intra_writer ALIAS cyber_intra_writer)
target_link_libraries(cyber_intra_writer cyber::blocker_manager)

add_executable(cyber_blocker_test blocker_test.cc)
target_link_libraries(cyber_blocker_test gtest gtest_main cyber::proto
                                                          cyber::cyber)

add_executable(cyber_blocker_manager_test blocker_manager_test.cc)
target_link_libraries(cyber_blocker_manager_test gtest gtest_main cyber::proto
                                                                  cyber::cyber)
add_library(cyber_blocker_module INTERFACE)
target_link_libraries(cyber_blocker_module INTERFACE
                      cyber_blocker
                      cyber_blocker_manager
                      cyber_intra_reader
                      cyber_intra_writer
  )

install(TARGETS cyber_blocker_module
                cyber_blocker
                cyber_blocker_manager
                cyber_intra_reader
                cyber_intra_writer
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)

install(TARGETS cyber_blocker_test
                cyber_blocker_manager_test
        RUNTIME DESTINATION bin
  )
