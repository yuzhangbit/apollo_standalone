cmake_minimum_required(VERSION 3.5.1)
project(common)

add_subdirectory(util) #done
add_subdirectory(proto) #done
add_subdirectory(math) #done
add_subdirectory(configs) #done
add_subdirectory(time) #done
add_subdirectory(status) #done
add_subdirectory(adapters) #done
add_subdirectory(vehicle_state) #done
add_subdirectory(vehicle_model) #done

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
