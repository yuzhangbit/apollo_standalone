cmake_minimum_required(VERSION 3.5.1)


add_subdirectory(proto)
add_library(common_vehicle_model vehicle_model.cc)
target_link_libraries(common_vehicle_model
    cyber::common
    common::config_gflags
    common::vehicle_config_helper
    common::vehicle_model_config_proto
    common::vehicle_state_proto)
add_library(common::vehicle_model ALIAS common_vehicle_model)


add_library(common_vehicle_model_module INTERFACE)
target_link_libraries(common_vehicle_model_module INTERFACE
        common_vehicle_model
        )

install(TARGETS common_vehicle_model
                common_vehicle_model_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
