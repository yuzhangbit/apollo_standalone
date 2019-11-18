cmake_minimum_required(VERSION 3.5.1)

add_library(adapter_gflags adapter_gflags.cc)
target_link_libraries(adapter_gflags ${gflags_LIBRARIES})
add_library(common::adapter_gflags ALIAS adapter_gflags)

add_library(common_adapters_module INTERFACE)
target_link_libraries(common_adapters_module INTERFACE
    adapter_gflags)

install(TARGETS adapter_gflags
                common_adapters_module
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
