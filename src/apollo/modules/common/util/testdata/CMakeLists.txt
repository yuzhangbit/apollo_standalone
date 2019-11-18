cmake_minimum_required(VERSION 3.5.1)

set(PROTOS simple.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(common_util_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(common_util_proto ${PROTOBUF_LIBRARIES}
                                        common::proto)
add_library(common::util_proto ALIAS common_util_proto)

add_library(common_util_proto_module INTERFACE)
target_link_libraries(common_util_proto_module INTERFACE
        common_util_proto
        )

install(TARGETS common_util_proto
                common_util_proto_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
