cmake_minimum_required(VERSION 3.5.1)

add_library(common_config_gflags config_gflags.cc)
target_link_libraries(common_config_gflags ${gflags_LIBRARIES})
add_library(common::config_gflags ALIAS common_config_gflags)

add_subdirectory(proto)

add_library(common_vehicle_config_helper vehicle_config_helper.cc)
target_link_libraries(common_vehicle_config_helper common::config_gflags
                                                   cyber::common
                                                   common::configs_proto
                                                   common::util
                                                   ${GLOG_LIBRARIES})
add_library(common::vehicle_config_helper ALIAS common_vehicle_config_helper)


add_executable(vehicle_config_helper_test vehicle_config_helper_test.cc)
target_link_libraries(vehicle_config_helper_test gtest gtest_main common::vehicle_config_helper)

add_library(common_configs_module INTERFACE)
target_link_libraries(common_configs_module INTERFACE
        common_config_gflags
        common_vehicle_config_helper
        )

install(TARGETS common_config_gflags
                common_vehicle_config_helper
                common_configs_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

install(TARGETS vehicle_config_helper_test
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)
