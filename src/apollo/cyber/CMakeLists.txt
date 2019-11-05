cmake_minimum_required(VERSION 3.5.1)

project(cyber)

ENABLE_LANGUAGE(ASM)

find_package(UUID REQUIRED)
find_package(FastRTPS REQUIRED)
include_directories(${FastRTPS_INCLUDE_DIR}
                    ${FastCDR_INCLUDE_DIR}
                    ${GLOG_INCLUDE_DIRS}
                    ${gflags_INCLUDE_DIRS}
                    ${PROTOBUF_INCLUDE_DIRS}
                    ${UUID_INCLUDE_DIR})

add_subdirectory(base)
add_subdirectory(blocker)
add_subdirectory(class_loader)
add_subdirectory(common)
add_subdirectory(component)
add_subdirectory(croutine)
add_subdirectory(data)
add_subdirectory(event)
add_subdirectory(examples)
add_subdirectory(logger)
add_subdirectory(proto)
add_subdirectory(message)
add_subdirectory(node)
add_subdirectory(scheduler)
add_subdirectory(service)
add_subdirectory(service_discovery)
add_subdirectory(time)
add_subdirectory(timer)
add_subdirectory(task)
add_subdirectory(transport)

add_library(cyber_binary binary.h)
set_target_properties(cyber_binary PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::binary ALIAS cyber_binary)

add_library(cyber_state state.cc)
target_link_libraries(cyber_state cyber::common)
add_library(cyber::state ALIAS cyber_state)

add_library(cyber_init init.cc)
target_link_libraries(cyber_init cyber::state
                                 cyber::async_logger
                                 cyber::node
                                 cyber::timing_wheel)
add_library(cyber::init ALIAS cyber_init)

add_library(cyber_core cyber.cc)
target_include_directories(cyber_core
  PUBLIC
    ${FastRTPS_INCLUDE_DIR}
    ${FastCDR_INCLUDE_DIR}
    ${UUID_INCLUDE_DIR})
target_link_libraries(cyber_core ${GLOG_LIBRARIES}
                                 ${gflags_LIBRARIES}
                                 ${PROTOBUF_LIBRARIES}
                                 ${UUID_LIBRARY}
                                 ${FastRTPS_LIBRARIES}
                                 cyber::binary
                                 cyber::init
                                 cyber::state
                                 cyber::base
                                 cyber::blocker_manager
                                 cyber::class_loader
                                 cyber::class_loader_manager
                                 cyber::common
                                 cyber::component
                                 cyber::timer_component
                                 cyber::croutine
                                 cyber::data
                                 cyber::perf_event_cache
                                 #cyber::io
                                 cyber::logger
                                 cyber::async_logger
                                 cyber::message_traits
                                 cyber::protobuf_traits
                                 cyber::py_message_traits
                                 cyber::raw_message_traits
                                 cyber::node
                                 #cyber::parameter_client
                                 #cyber::parameter_server
                                 cyber::proto
                                 # cyber::record
                                 cyber::scheduler
                                 cyber::scheduler_factory
                                 cyber::service
                                 cyber::client
                                 cyber::topology_manager
                                 cyber::task
                                 cyber::time
                                 cyber::duration
                                 cyber::rate
                                 cyber::timer
                                 cyber::transport
                                 cyber::participant
                                 cyber::sub_listener
                                 3rdparty::tf2)
add_library(cyber::cyber_core ALIAS cyber_core)

add_library(cyber cyber.cc)
target_link_libraries(cyber cyber::cyber_core)
add_library(cyber::cyber ALIAS cyber)

add_executable(mainboard mainboard/mainboard.cc
                         mainboard/module_argument.cc
                         mainboard/module_controller.cc)
target_link_libraries(mainboard pthread cyber::proto
                                        cyber::cyber_core)

install(TARGETS cyber_binary
                cyber_state
                cyber_init
                cyber_core
                cyber
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
  )

install(TARGETS mainboard
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
  )

