cmake_minimum_required(VERSION 3.5.1)

add_subdirectory(proto)

add_executable(cyber_example_talker talker.cc)
target_link_libraries(cyber_example_talker cyber::cyber
                                           cyber::examples_proto)

add_executable(cyber_example_listener listener.cc)
target_link_libraries(cyber_example_listener cyber::cyber
                                             cyber::examples_proto)

#todo paramserver

add_executable(cyber_example_service service.cc)
target_link_libraries(cyber_example_service cyber::cyber
                                            cyber::examples_proto)

# add_executable(cyber_record record.cc)
# target_link_libraries(cyber_record cyber::cyber
#                                    cyber::proto)

install(TARGETS cyber_example_talker
                cyber_example_listener
                cyber_example_service
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
