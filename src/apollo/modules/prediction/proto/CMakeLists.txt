cmake_minimum_required(VERSION 3.5.1)

set(PROTOS prediction_obstacle.proto
           feature.proto
           scenario.proto
           lane_graph.proto
           prediction_point.proto
           )

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(prediciton_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(prediciton_proto
        ${PROTOBUF_LIBRARIES}
        common::proto
        map::proto
        perception::proto)
add_library(prediciton::proto ALIAS prediciton_proto)

install(TARGETS prediciton_proto
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
