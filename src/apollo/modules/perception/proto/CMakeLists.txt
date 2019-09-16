cmake_minimum_required(VERSION 3.5.1)

set(PROTOS motion_service.proto
           perception_camera.proto
           perception_lane.proto
           perception_obstacle.proto
           traffic_light_detection.proto
           )

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(perception_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(perception_proto
    ${PROTOBUF_LIBRARIES}
    common::proto
    map::proto
)
add_library(perception::proto ALIAS perception_proto)

install(TARGETS perception_proto
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
