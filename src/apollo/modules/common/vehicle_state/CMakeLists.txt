cmake_minimum_required(VERSION 3.5.1)

add_subdirectory(proto)

add_library(common_vehicle_state_provider vehicle_state_provider.cc)
target_link_libraries(common_vehicle_state_provider cyber::common
                                                    common::config_gflags
                                                    common::math
                                                    common::status
                                                    common::vehicle_state_proto
                                                    localization::localization_common)

add_library(common::vehicle_state_provider ALIAS common_vehicle_state_provider)
install(TARGETS common_vehicle_state_provider
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION bin
INCLUDES DESTINATION .
)