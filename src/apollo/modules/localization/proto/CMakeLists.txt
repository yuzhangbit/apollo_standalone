cmake_minimum_required(VERSION 3.5.1)

set(PROTOS pose.proto
           localization_status.proto
           localization.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(localization_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(localization_proto
        ${PROTOBUF_LIBRARIES}
        common::proto)
add_library(localization::proto ALIAS localization_proto)

install(TARGETS localization_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
