cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_identity common/identity.cc)
target_link_libraries(cyber_identity cyber::util
                                     ${UUID_LIBRARY})  ## fix: add UUID_LIBRARY
add_library(cyber::identity ALIAS cyber_identity)

add_library(cyber_endpoint common/endpoint.cc)
target_link_libraries(cyber_endpoint cyber::identity
                                     cyber::global_data
                                     cyber::proto)
add_library(cyber::endpoint ALIAS cyber_endpoint)

add_library(cyber_message_info message/message_info.cc)
target_link_libraries(cyber_message_info cyber::signal
                                         cyber::common
                                         cyber::raw_message
                                         cyber::identity)
add_library(cyber::message_info ALIAS cyber_message_info)

add_library(cyber_transmitter transmitter/transmitter.h)
set_target_properties(cyber_transmitter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_message_info cyber::endpoint
                                         cyber::message_info
                                         cyber::perf_event_cache)
add_library(cyber::transmitter ALIAS cyber_message_info)

add_library(cyber_hybrid_transmitter transmitter/hybrid_transmitter.h)
set_target_properties(cyber_transmitter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_hybrid_transmitter cyber::transmitter)
add_library(cyber::hybrid_transmitter ALIAS cyber_hybrid_transmitter)

add_library(cyber_intra_transmitter transmitter/intra_transmitter.h)
set_target_properties(cyber_intra_transmitter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_intra_transmitter cyber::transmitter)
add_library(cyber::intra_transmitter ALIAS cyber_intra_transmitter)

add_library(cyber_rtps_transmitter transmitter/rtps_transmitter.h)
set_target_properties(cyber_rtps_transmitter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_rtps_transmitter cyber::transmitter)
add_library(cyber::rtps_transmitter ALIAS cyber_rtps_transmitter)

add_library(cyber_shm_transmitter transmitter/shm_transmitter.h)
set_target_properties(cyber_shm_transmitter PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_shm_transmitter cyber::transmitter)
add_library(cyber::shm_transmitter ALIAS cyber_shm_transmitter)

add_library(cyber_shm_state shm/state.cc) # fix: state->shm_state
add_library(cyber::shm_state ALIAS cyber_shm_state)

add_library(cyber_shm_conf shm/shm_conf.cc)
target_link_libraries(cyber_shm_conf cyber::log)
add_library(cyber::shm_conf ALIAS cyber_shm_conf)

add_library(cyber_block shm/block.cc)
target_link_libraries(cyber_block cyber::atomic_rw_lock
                                  cyber::log)
add_library(cyber::block ALIAS cyber_block)

add_library(cyber_segment shm/segment.cc)
target_link_libraries(cyber_segment cyber::block
                                    cyber::shm_conf
                                    cyber::shm_state
                                    cyber::log
                                    cyber::util)
add_library(cyber::segment ALIAS cyber_segment)

add_library(cyber_readable_info shm/readable_info.cc)
target_link_libraries(cyber_readable_info cyber::log)
add_library(cyber::readable_info ALIAS cyber_readable_info)

add_library(cyber_notifier_base shm/notifier_base.h)
set_target_properties(cyber_notifier_base PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_notifier_base cyber::readable_info)
add_library(cyber::notifier_base ALIAS cyber_notifier_base)

add_library(cyber_multicast_notifier shm/multicast_notifier.cc)
target_link_libraries(cyber_multicast_notifier cyber::notifier_base
                                               cyber::global_data
                                               cyber::log
                                               cyber::common_macros)
add_library(cyber::multicast_notifier ALIAS cyber_multicast_notifier)

add_library(cyber_condition_notifier shm/condition_notifier.cc)
target_link_libraries(cyber_condition_notifier cyber::notifier_base
                                               cyber::global_data
                                               cyber::log
                                               cyber::util)
add_library(cyber::condition_notifier ALIAS cyber_condition_notifier)

add_library(cyber_notifier_factory shm/notifier_factory.cc)
target_link_libraries(cyber_notifier_factory cyber::condition_notifier
                                             cyber::multicast_notifier
                                             cyber::notifier_base
                                             cyber::global_data
                                             cyber::log)
add_library(cyber::notifier_factory ALIAS cyber_notifier_factory)

add_library(cyber_underlay_message rtps/underlay_message.cc)
target_link_libraries(cyber_underlay_message ${FastRTPS_LIBRARIES} ${FastCDR_LIBRARIES})
add_library(cyber::underlay_message ALIAS cyber_underlay_message)

add_library(cyber_underlay_message_type rtps/underlay_message_type.cc)
target_link_libraries(cyber_underlay_message_type cyber::underlay_message
                                                  ${FastRTPS_LIBRARIES}
                                                  ${FastCDR_LIBRARIES})
add_library(cyber::underlay_message_type ALIAS cyber_underlay_message_type)

add_library(cyber_sub_listener rtps/sub_listener.cc)
target_link_libraries(cyber_sub_listener cyber::message_info
                                         cyber::underlay_message
                                         cyber::underlay_message_type)
add_library(cyber::sub_listener ALIAS cyber_sub_listener)

add_library(cyber_participant rtps/participant.cc)
target_link_libraries(cyber_participant cyber::underlay_message
                                        cyber::underlay_message_type
                                        cyber::global_data)
add_library(cyber::participant ALIAS cyber_participant)

add_library(cyber_history_attributes message/history_attributes.h)
set_target_properties(cyber_history_attributes PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::history_attributes ALIAS cyber_history_attributes)

add_library(cyber_history message/history.h)
set_target_properties(cyber_history PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_participant cyber::history_attributes)
add_library(cyber::history ALIAS cyber_history)

add_library(cyber_qos_profile_conf qos/qos_profile_conf.cc)
target_link_libraries(cyber_qos_profile_conf cyber::history
                                             cyber::proto)
add_library(cyber::qos_profile_conf ALIAS cyber_qos_profile_conf)

add_library(cyber_attributes_filler rtps/attributes_filler.cc)
target_link_libraries(cyber_attributes_filler cyber::qos_profile_conf
                                              cyber::log
                                              ${FastRTPS_LIBRARIES}
                                              ${FastCDR_LIBRARIES})
add_library(cyber::attributes_filler ALIAS cyber_attributes_filler)

add_library(cyber_receiver receiver/receiver.h)
set_target_properties(cyber_receiver PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_receiver cyber::history
                                     cyber::endpoint
                                     cyber::message_info)
add_library(cyber::receiver ALIAS cyber_receiver)

add_library(cyber_shm_receiver receiver/shm_receiver.h)
set_target_properties(cyber_shm_receiver PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_shm_receiver cyber::readable_info
                                         cyber::receiver
                                         cyber::segment)
add_library(cyber::shm_receiver ALIAS cyber_shm_receiver)

add_library(cyber_rtps_receiver receiver/rtps_receiver.h)
set_target_properties(cyber_rtps_receiver PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_rtps_receiver cyber::receiver)
add_library(cyber::rtps_receiver ALIAS cyber_rtps_receiver)

add_library(cyber_intra_receiver receiver/intra_receiver.h)
set_target_properties(cyber_intra_receiver PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_intra_receiver cyber::receiver)
add_library(cyber::intra_receiver ALIAS cyber_intra_receiver)

add_library(cyber_hybrid_receiver receiver/hybrid_receiver.h)
set_target_properties(cyber_hybrid_receiver PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_hybrid_receiver cyber::receiver)
add_library(cyber::hybrid_receiver ALIAS cyber_hybrid_receiver)

add_library(cyber_listener_handler message/listener_handler.h)
set_target_properties(cyber_listener_handler PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::listener_handler ALIAS cyber_listener_handler)

add_library(cyber_dispatcher dispatcher/dispatcher.cc)
target_link_libraries(cyber_dispatcher cyber::listener_handler
                                       cyber::message_info
                                       cyber::proto)
add_library(cyber::dispatcher ALIAS cyber_dispatcher)

add_library(cyber_shm_dispatcher dispatcher/shm_dispatcher.cc)
target_link_libraries(cyber_shm_dispatcher cyber::dispatcher
                                           cyber::notifier_factory
                                           cyber::readable_info
                                           cyber::segment
                                           cyber::message_traits
                                           cyber::proto
                                           cyber::scheduler_factory)
add_library(cyber::shm_dispatcher ALIAS cyber_shm_dispatcher)

add_library(cyber_rtps_dispatcher dispatcher/rtps_dispatcher.cc)
target_link_libraries(cyber_rtps_dispatcher cyber::attributes_filler
                                            cyber::dispatcher
                                            cyber::participant
                                            cyber::sub_listener
                                            cyber::message_traits
                                            cyber::proto)
add_library(cyber::rtps_dispatcher ALIAS cyber_rtps_dispatcher)

add_library(cyber_intra_dispatcher dispatcher/intra_dispatcher.cc)
target_link_libraries(cyber_intra_dispatcher cyber::dispatcher
                                             cyber::message_traits
                                             cyber::proto)
add_library(cyber::intra_dispatcher ALIAS cyber_intra_dispatcher)

add_library(cyber_transport transport.cc)
target_link_libraries(cyber_transport cyber::attributes_filler
                                      cyber::history
                                      cyber::hybrid_receiver
                                      cyber::hybrid_transmitter
                                      cyber::intra_dispatcher
                                      cyber::intra_receiver
                                      cyber::intra_transmitter
                                      cyber::participant
                                      cyber::qos_profile_conf
                                      cyber::rtps_dispatcher
                                      cyber::rtps_receiver
                                      cyber::rtps_transmitter
                                      cyber::shm_dispatcher
                                      cyber::shm_receiver
                                      cyber::shm_transmitter
                                      cyber::sub_listener
                                      cyber::underlay_message
                                      cyber::underlay_message_type
                                      cyber::role
                                      cyber::task
                                      ${FastRTPS_LIBRARIES}
                                      ${FastCDR_LIBRARIES})
add_library(cyber::transport ALIAS cyber_transport)

## gtest
add_executable(transport_test transport_test.cc)
target_link_libraries(transport_test gtest gtest_main gmock cyber::cyber_core
                                                            cyber::proto)

add_executable(common_test common/common_test.cc)
target_link_libraries(common_test gtest gtest_main gmock cyber::cyber_core)

add_executable(dispatcher_test dispatcher/dispatcher_test.cc)
target_link_libraries(dispatcher_test gtest gtest_main gmock cyber::cyber_core
                                                             cyber::proto)
add_executable(intra_dispatcher_test dispatcher/intra_dispatcher_test.cc)
target_link_libraries(intra_dispatcher_test gtest gtest_main gmock cyber::cyber_core
                                                                   cyber::proto)

add_executable(rtps_dispatcher_test dispatcher/rtps_dispatcher_test.cc)
target_link_libraries(rtps_dispatcher_test gtest gtest_main gmock cyber::cyber_core
                                                                  cyber::proto)

add_executable(shm_dispatcher_test dispatcher/shm_dispatcher_test.cc)
target_link_libraries(shm_dispatcher_test gtest gtest_main gmock cyber::cyber_core
                                                                 cyber::proto)

add_executable(message_test message/message_test.cc)
target_link_libraries(message_test gtest gtest_main gmock cyber::cyber_core)

add_executable(rtps_test rtps/rtps_test.cc)
target_link_libraries(rtps_test gtest gtest_main gmock cyber::cyber_core)

add_executable(hybrid_transceiver_test transceiver/hybrid_transceiver_test.cc)
target_link_libraries(hybrid_transceiver_test gtest gtest_main gmock cyber::cyber_core
                                                                     cyber::proto)

add_executable(intra_transceiver_test transceiver/intra_transceiver_test.cc)
target_link_libraries(intra_transceiver_test gtest gtest_main gmock cyber::cyber_core
                                                                    cyber::proto)

add_executable(rtps_transceiver_test transceiver/rtps_transceiver_test.cc)
target_link_libraries(rtps_transceiver_test gtest gtest_main gmock cyber::cyber_core
                                                                   cyber::proto)

add_executable(shm_transceiver_test transceiver/shm_transceiver_test.cc)
target_link_libraries(shm_transceiver_test gtest gtest_main gmock cyber::cyber_core
                                                                  cyber::proto)
install(TARGETS cyber_identity
                cyber_endpoint
                cyber_message_info
                cyber_transmitter
                cyber_hybrid_transmitter
                cyber_intra_transmitter
                cyber_rtps_transmitter
                cyber_shm_transmitter
                cyber_shm_state
                cyber_shm_conf
                cyber_block
                cyber_segment
                cyber_readable_info
                cyber_notifier_base
                cyber_multicast_notifier
                cyber_condition_notifier
                cyber_notifier_factory
                cyber_underlay_message
                cyber_underlay_message_type
                cyber_sub_listener
                cyber_participant
                cyber_history_attributes
                cyber_history
                cyber_qos_profile_conf
                cyber_attributes_filler
                cyber_receiver
                cyber_shm_receiver
                cyber_rtps_receiver
                cyber_intra_receiver
                cyber_hybrid_receiver
                cyber_listener_handler
                cyber_dispatcher
                cyber_shm_dispatcher
                cyber_rtps_dispatcher
                cyber_intra_dispatcher
                cyber_transport
    transport_test
                common_test
                dispatcher_test
                intra_dispatcher_test
                rtps_dispatcher_test
                shm_dispatcher_test
                message_test
                rtps_test
                hybrid_transceiver_test
                intra_transceiver_test
                rtps_transceiver_test
                shm_transceiver_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
