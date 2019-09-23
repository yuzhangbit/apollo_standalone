cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_timer_task timer_task.h)
set_target_properties(cyber_timer_task PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::timer_task ALIAS cyber_timer_task)

add_library(cyber_timer_bucket timer_bucket.h)
set_target_properties(cyber_timer_bucket PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_timer_bucket cyber::timer_task)
add_library(cyber::timer_bucket ALIAS cyber_timer_bucket)

add_library(cyber_timing_wheel timing_wheel.cc)
target_link_libraries(cyber_timing_wheel cyber::timer_bucket
                                         cyber::task
                                         cyber::time
                                         cyber::duration
                                         cyber::rate)
add_library(cyber::timing_wheel ALIAS cyber_timing_wheel)

add_library(cyber_timer timer.cc)
target_link_libraries(cyber_timer cyber::timing_wheel
                                  cyber::global_data)
add_library(cyber::timer ALIAS cyber_timer)


## gtest
add_executable(timer_test timer_test.cc)
target_link_libraries(timer_test gtest gtest_main gmock cyber::cyber_core)


install(TARGETS cyber_timer_task
                cyber_timer_bucket
                cyber_timing_wheel
                cyber_timer
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
