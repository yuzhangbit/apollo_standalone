cmake_minimum_required(VERSION 3.5.1)

add_library(common_util util.cc)
target_link_libraries(common_util common::color
                                  common::disjoint_set
                                  common::http_client
                                  common::json_util
                                  common::lru_cache
                                  common::message_util
                                  common::points_downsampler
                                  common::string_tokenizer
                                  common::string_util
                                  common::math
                                  common::proto
                                  common::time)
add_library(common::util ALIAS common_util)

add_library(common_string_util string_util.cc)
target_link_libraries(common_string_util ${PROTOBUF_LIBRARIES})
add_library(common::string_util ALIAS common_string_util)


add_executable(common_string_util_test string_util_test.cc)
target_link_libraries(common_string_util_test gtest
                                              gtest_main
                                              common::string_util)


add_library(common_string_tokenizer string_tokenizer.cc)
target_link_libraries(common_string_tokenizer ${PROTOBUF_LIBRARIES})
add_library(common::string_tokenizer ALIAS common_string_tokenizer)

add_library(common_disjoint_set disjoint_set.h)
set_target_properties(common_disjoint_set PROPERTIES LINKER_LANGUAGE CXX)
add_library(common::disjoint_set ALIAS common_disjoint_set)

add_library(common_lru_cache lru_cache.h)
set_target_properties(common_lru_cache PROPERTIES LINKER_LANGUAGE CXX)
add_library(common::lru_cache ALIAS common_lru_cache)


add_library(common_color color.h)
set_target_properties(common_color PROPERTIES LINKER_LANGUAGE CXX)
add_library(common::color ALIAS common_color)

add_library(common_message_util message_util.h)
set_target_properties(common_message_util PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_message_util ${PROTOBUF_LIBRARIES}
                                          common::string_util
                                          common::time)
add_library(common::message_util ALIAS common_message_util)

add_library(common_map_util map_util.h)
set_target_properties(common_map_util PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_map_util ${PROTOBUF_LIBRARIES})
add_library(common::map_util ALIAS common_map_util)


add_library(common_factory factory.h)
set_target_properties(common_factory PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_factory cyber::common)
add_library(common::factory ALIAS common_factory)

add_library(common_points_downsampler points_downsampler.h)
set_target_properties(common_points_downsampler PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(common_points_downsampler cyber::common
                                                common::geometry)
add_library(common::points_downsampler ALIAS common_points_downsampler)

add_library(common_json_util json_util.cc)
target_link_libraries(common_json_util cyber::common
                                       3rdparty::json
                                       ${PROTOBUF_LIBRARIES})
add_library(common::json_util ALIAS common_json_util)



add_executable(common_message_util_test message_util_test.cc)
target_link_libraries(common_message_util_test gtest
                                               gtest_main
                                               common::util_proto
                                               common::message_util
                                               common::proto)
add_subdirectory(testdata)

add_library(http_client http_client.cc)
target_link_libraries(http_client cyber::common
                                  common::string_util
                                  common::status
                                  3rdparty::json
                                  ${curlpp_LIBRARIES}
                                  ${PROTOBUF_LIBRARIES})
add_library(common::http_client ALIAS http_client)

add_executable(common_string_tokenizer_test string_tokenizer_test.cc)
target_link_libraries(common_string_tokenizer_test gtest
                                                   gtest_main
                                                   common::string_tokenizer)


add_executable(factory_test factory_test.cc)
target_link_libraries(factory_test gtest gtest_main gmock common::factory)


add_executable(lru_cache_test lru_cache_test.cc)
target_link_libraries(lru_cache_test gtest gtest_main common::lru_cache)


add_executable(points_downsampler_test points_downsampler_test.cc)
target_link_libraries(points_downsampler_test gtest gtest_main common::points_downsampler)

add_executable(json_util_test json_util_test.cc)
target_link_libraries(json_util_test gtest
                                     gtest_main
                                     common::json_util
                                     common::proto)

add_executable(disjoint_set_test disjoint_set_test.cc)
target_link_libraries(disjoint_set_test gtest
                                        gtest_main
                                        common::disjoint_set
                                        cyber::common)

add_library(common_util_module INTERFACE)
target_link_libraries(common_util_module INTERFACE
        common_string_util
        common_string_util_test
        common_string_tokenizer
        common_disjoint_set
        common_lru_cache
        common_color
        common_message_util
        common_map_util
        common_factory
        common_points_downsampler
        common_json_util
        http_client
        common_util
        )

install(TARGETS common_string_util
                common_string_util_test
                common_string_tokenizer
                common_disjoint_set
                common_lru_cache
                common_color
                common_message_util
                common_map_util
                common_factory
                common_points_downsampler
                common_json_util
                http_client
                common_util
                common_util_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS common_message_util_test
                common_string_tokenizer_test
                factory_test
                lru_cache_test
                points_downsampler_test
                json_util_test
                disjoint_set_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
