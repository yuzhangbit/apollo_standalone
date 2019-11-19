cmake_minimum_required(VERSION 3.5.1)
project(routing)

add_subdirectory(proto)
add_subdirectory(common)

add_library(routing INTERFACE)
target_link_libraries(routing INTERFACE
        routing_common_module
        routing_proto
        )

install(TARGETS routing
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
