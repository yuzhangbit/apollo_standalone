cmake_minimum_required(VERSION 3.5.1)

set(PROTOS poi.proto
           routing.proto
           routing_config.proto
           topo_graph.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(routing_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(routing_proto
    ${PROTOBUF_LIBRARIES}
    common::proto
    map::proto)
add_library(routing::proto ALIAS routing_proto)

install(TARGETS routing_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
