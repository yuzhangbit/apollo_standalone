cmake_minimum_required(VERSION 3.5.1)

set(PROTOS chart.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(dreamview_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(dreamview_proto ${PROTOBUF_LIBRARIES})
add_library(dreamview::proto ALIAS dreamview_proto)

install(TARGETS dreamview_proto
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
