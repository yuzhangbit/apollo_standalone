cmake_minimum_required(VERSION 3.5.1)

set(PROTOS vehicle_config.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(common_configs_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(common_configs_proto
        ${PROTOBUF_LIBRARIES}
        common::proto)
add_library(common::configs_proto ALIAS common_configs_proto)

add_library(common_configs_proto_module INTERFACE)
target_link_libraries(common_configs_proto_module INTERFACE
        common_configs_proto
        )

install(TARGETS common_configs_proto
                common_configs_proto_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
