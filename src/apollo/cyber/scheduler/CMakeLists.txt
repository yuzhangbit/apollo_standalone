cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_processor_context processor_context.cc)
target_link_libraries(cyber_processor_context cyber::croutine
                                              cyber::data)
add_library(cyber::processor_context ALIAS cyber_processor_context)

add_library(cyber_processor processor.cc)
target_link_libraries(cyber_processor cyber::processor_context
                                      cyber::data)
add_library(cyber::processor ALIAS cyber_processor)

add_library(cyber_mutex_wrapper common/mutex_wrapper.h)
set_target_properties(cyber_mutex_wrapper PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::mutex_wrapper ALIAS cyber_mutex_wrapper)

add_library(cyber_cv_wrapper common/cv_wrapper.h)
set_target_properties(cyber_cv_wrapper PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::cv_wrapper ALIAS cyber_cv_wrapper)

add_library(cyber_classic_context policy/classic_context.cc)
target_link_libraries(cyber_classic_context cyber::croutine
                                            cyber::proto
                                            cyber::cv_wrapper
                                            cyber::mutex_wrapper
                                            cyber::processor)
add_library(cyber::classic_context ALIAS cyber_classic_context)

add_library(cyber_choreography_context policy/choreography_context.cc)
target_link_libraries(cyber_choreography_context cyber::croutine
                                                 cyber::proto
                                                 cyber::processor)
add_library(cyber::choreography_context ALIAS cyber_choreography_context)

add_library(cyber_scheduler_classic policy/scheduler_classic.cc)
target_link_libraries(cyber_scheduler_classic cyber::scheduler
                                              cyber::classic_context)
add_library(cyber::scheduler_classic ALIAS cyber_scheduler_classic)

add_library(cyber_scheduler_choreography policy/scheduler_choreography.cc)
target_link_libraries(cyber_scheduler_choreography cyber::scheduler
                                                   cyber::choreography_context
                                                   cyber::classic_context)
add_library(cyber::scheduler_choreography ALIAS cyber_scheduler_choreography)

add_library(cyber_scheduler_factory scheduler_factory.cc)
target_link_libraries(cyber_scheduler_factory cyber::proto
                                              cyber::scheduler_choreography
                                              cyber::scheduler_classic)
add_library(cyber::scheduler_factory ALIAS cyber_scheduler_factory)

add_library(cyber_scheduler scheduler.cc)
target_link_libraries(cyber_scheduler cyber::croutine
                                      cyber::mutex_wrapper
                                      cyber::processor)
add_library(cyber::scheduler ALIAS cyber_scheduler)

## gtest
add_executable(scheduler_test scheduler_test.cc)
target_link_libraries(scheduler_test gtest gtest_main gmock cyber::cyber
                                                            cyber::scheduler_factory)

add_executable(scheduler_classic_test scheduler_classic_test.cc)
target_link_libraries(scheduler_classic_test gtest gtest_main gmock cyber::cyber
                                                                    cyber::scheduler_factory)

add_executable(scheduler_choreo_test scheduler_choreo_test.cc)
target_link_libraries(scheduler_choreo_test gtest gtest_main gmock cyber::cyber
                                                                   cyber::scheduler_factory)

add_library(cyber_scheduler_module INTERFACE)
target_link_libraries(cyber_scheduler_module INTERFACE
                      cyber_processor
                      cyber_processor_context
                      cyber_scheduler
                      cyber_mutex_wrapper
                      cyber_cv_wrapper
                      cyber_scheduler_factory
                      cyber_scheduler_classic
                      cyber_scheduler_choreography
                      cyber_choreography_context
                      cyber_classic_context)


install(TARGETS cyber_scheduler_module
                cyber_processor
                cyber_processor_context
                cyber_scheduler
                cyber_mutex_wrapper
                cyber_cv_wrapper
                cyber_scheduler_factory
                cyber_scheduler_classic
                cyber_scheduler_choreography
                cyber_choreography_context
                cyber_classic_context
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS scheduler_test
                scheduler_classic_test
                scheduler_choreo_test
      LIBRARY DESTINATION lib
      ARCHIVE DESTINATION lib
      RUNTIME DESTINATION bin
      INCLUDES DESTINATION .
  )
