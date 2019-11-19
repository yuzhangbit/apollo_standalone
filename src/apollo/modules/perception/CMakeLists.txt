cmake_minimum_required(VERSION 3.5.1)
add_subdirectory(proto)

add_library(perception INTERFACE)
target_link_libraries(perception INTERFACE
        perception_proto
        perception_lidar_fusion_proto
        )

install(TARGETS perception
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
