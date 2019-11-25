cmake_minimum_required(VERSION 3.5.1)

set(PROTOS chassis.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(canbus_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(canbus_proto
        ${PROTOBUF_LIBRARIES}
        common::proto
        common::configs_proto)
add_library(canbus::proto ALIAS canbus_proto)

install(TARGETS canbus_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
