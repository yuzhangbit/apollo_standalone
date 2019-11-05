cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_role role/role.cc)
target_link_libraries(cyber_role cyber::binary
                                 cyber::log
                                 cyber::types
                                 cyber::proto)
add_library(cyber::role ALIAS cyber_role)

add_library(cyber_graph container/graph.cc)
target_link_libraries(cyber_graph cyber::atomic_rw_lock)
add_library(cyber::graph ALIAS cyber_graph)

add_library(cyber_subscriber_listener communication/subscriber_listener.cc)
target_link_libraries(cyber_subscriber_listener cyber::log
                                                cyber::underlay_message
                                                cyber::underlay_message_type
                                                ${FastRTPS_LIBRARIES}
                                                ${FastCDR_LIBRARIES})
add_library(cyber::subscriber_listener ALIAS cyber_subscriber_listener)

add_library(cyber_manager specific_manager/manager.cc)
target_link_libraries(cyber_manager cyber::subscriber_listener
                                    cyber::state
                                    cyber::signal
                                    cyber::message_traits
                                    cyber::protobuf_factory
                                    cyber::proto
                                    cyber::time
                                    cyber::attributes_filler
                                    cyber::qos_profile_conf
                                    cyber::underlay_message_type)
add_library(cyber::manager ALIAS cyber_manager)

add_library(cyber_warehouse_base container/warehouse_base.h)
set_target_properties(cyber_warehouse_base PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_warehouse_base cyber::role)
add_library(cyber::warehouse_base ALIAS cyber_warehouse_base)

add_library(cyber_multi_value_warehouse container/multi_value_warehouse.cc)
target_link_libraries(cyber_multi_value_warehouse cyber::warehouse_base
                                                  cyber::atomic_rw_lock)
add_library(cyber::multi_value_warehouse ALIAS cyber_multi_value_warehouse)

add_library(cyber_single_value_warehouse container/single_value_warehouse.cc)
target_link_libraries(cyber_single_value_warehouse cyber::warehouse_base
                                                   cyber::atomic_rw_lock)
add_library(cyber::single_value_warehouse ALIAS cyber_single_value_warehouse)

add_library(cyber_channel_manager specific_manager/channel_manager.cc)
target_link_libraries(cyber_channel_manager cyber::graph
                                            cyber::manager
                                            cyber::multi_value_warehouse
                                            cyber::single_value_warehouse)
add_library(cyber::channel_manager ALIAS cyber_channel_manager)

add_library(cyber_node_manager specific_manager/node_manager.cc)
target_link_libraries(cyber_node_manager cyber::manager
                                         cyber::multi_value_warehouse
                                         cyber::single_value_warehouse)
add_library(cyber::node_manager ALIAS cyber_node_manager)

add_library(cyber_participant_listner communication/participant_listener.cc)
target_link_libraries(cyber_participant_listner cyber::log
                                                ${FastRTPS_LIBRARIES}
                                                ${FastCDR_LIBRARIES})
add_library(cyber::participant_listner ALIAS cyber_participant_listner)

add_library(cyber_serivce_manager specific_manager/service_manager.cc)
target_link_libraries(cyber_serivce_manager cyber::manager
                                            cyber::multi_value_warehouse
                                            cyber::single_value_warehouse)
add_library(cyber::serivce_manager ALIAS cyber_serivce_manager)

add_library(cyber_topology_manager topology_manager.cc)
target_link_libraries(cyber_topology_manager cyber::channel_manager
                                             cyber::node_manager
                                             cyber::participant_listner
                                             cyber::serivce_manager
                                             cyber::participant)
add_library(cyber::topology_manager ALIAS cyber_topology_manager)


## gtest
add_executable(topology_manager_test topology_manager_test.cc)
target_link_libraries(topology_manager_test gtest gtest_main gmock cyber::cyber)

add_executable(role_test role/role_test.cc)
target_link_libraries(role_test gtest gtest_main gmock cyber::cyber)

install(TARGETS cyber_role
                cyber_graph
                cyber_subscriber_listener
                cyber_manager
                cyber_warehouse_base
                cyber_multi_value_warehouse
                cyber_single_value_warehouse
                cyber_channel_manager
                cyber_node_manager
                cyber_participant_listner
                cyber_serivce_manager
                cyber_topology_manager
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS topology_manager_test
                role_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
  )
