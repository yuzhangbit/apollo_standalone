cmake_minimum_required(VERSION 3.5.1)
project(map)

add_subdirectory(proto)
add_subdirectory(relative_map)
add_subdirectory(hdmap)
add_subdirectory(pnc_map)

add_library(map INTERFACE)
target_link_libraries(map INTERFACE
        map_hdmap_module
        map_pnc_map_module
        map_proto
        map_relative_map_proto
        )

install(TARGETS map
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
