cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_duration duration.cc)
target_link_libraries(cyber_duration cyber::common)
add_library(cyber::duration ALIAS cyber_duration)

add_library(cyber_rate rate.cc)
target_link_libraries(cyber_rate cyber::common
                                 cyber::duration
                                 cyber::time)
add_library(cyber::rate ALIAS cyber_rate)


add_executable(duration_test duration_test.cc)
target_link_libraries(duration_test gtest gtest_main cyber::duration)

add_executable(time_test time_test.cc)
target_link_libraries(time_test gtest
                                gtest_main
                                cyber::time
                                cyber::common)

add_library(cyber_time time.cc)
target_link_libraries(cyber_time cyber::duration)
add_library(cyber::time ALIAS cyber_time)


install(TARGETS cyber_duration
                cyber_time
                cyber_rate
                duration_test
                time_test
                cyber_duration
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
