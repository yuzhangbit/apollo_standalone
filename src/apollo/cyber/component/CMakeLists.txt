cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_component component.h)
set_target_properties(cyber_component PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_component cyber::component_base
                                      cyber::scheduler)
add_library(cyber::component ALIAS cyber_component)

add_library(cyber_component_base component_base.h)
set_target_properties(cyber_component_base PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_component_base ${gflags_LIBRARIES} #add_Gflags
                                           cyber::signal
                                           cyber::thread_pool
                                           cyber::class_loader
                                           cyber::node)
add_library(cyber::component_base ALIAS cyber_component_base)

add_library(cyber_timer_component timer_component.cc)
target_link_libraries(cyber_timer_component cyber::component_base
                                            cyber::blocker_manager
                                            cyber::history
                                            cyber::hybrid_transmitter
                                            cyber::intra_transmitter
                                            cyber::rtps_transmitter
                                            cyber::shm_transmitter)
add_library(cyber::timer_component ALIAS cyber_timer_component)


## gtest
add_executable(timer_component_test timer_component_test.cc)
target_link_libraries(timer_component_test gtest gtest_main gmock cyber::cyber)
