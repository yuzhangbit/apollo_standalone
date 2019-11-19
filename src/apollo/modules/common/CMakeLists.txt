cmake_minimum_required(VERSION 3.5.1)
project(common)

add_subdirectory(util)
add_subdirectory(proto)
add_subdirectory(math)
add_subdirectory(configs)
add_subdirectory(time)
add_subdirectory(status)
add_subdirectory(adapters)
add_subdirectory(vehicle_state)
add_subdirectory(vehicle_model)

add_library(common INTERFACE)
target_link_libraries(common INTERFACE
        common_proto
        common_adapters_module
        common_configs_module
        common_math_module
        common_status_module
        common_time_module
        common_util_module
        common_vehicle_model_module
        common_vehicle_state_module
        )

install(TARGETS common
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
