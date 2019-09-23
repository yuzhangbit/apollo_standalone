cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_task_manager task_manager.cc)
target_link_libraries(cyber_task_manager cyber::scheduler_factory)
add_library(cyber::task_manager ALIAS cyber_task_manager)

add_library(cyber_task task.h)
set_target_properties(cyber_task PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_task cyber::task_manager)
add_library(cyber::task ALIAS cyber_task)


# gtest
add_executable(task_test task_test.cc)
target_link_libraries(task_test gtest gtest_main gmock cyber::cyber_core)


install(TARGETS cyber_task_manager
                cyber_task
    task_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
