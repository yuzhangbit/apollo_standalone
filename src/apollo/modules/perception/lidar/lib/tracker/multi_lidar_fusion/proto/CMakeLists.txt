project(perception-lidar-lib-multi-lidar-fusion-proto)

FILE(GLOB PROTO_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.proto")

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HEADERS ${PROTO_FILES})

add_library(${PROJECT_NAME} ${PROTO_SRCS})
target_link_libraries(${PROJECT_NAME} protobuf)

add_library(perception_lidar_fusion_proto INTERFACE)
target_link_libraries(perception_lidar_fusion_proto INTERFACE
        ${PROJECT_NAME}
        )

install(TARGETS ${PROJECT_NAME}
                perception_lidar_fusion_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)
