cmake_minimum_required(VERSION 3.5.1)

set(PROTOS navigation.proto
           relative_map_config.proto
           navigator_config.proto
           )

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(map_relative_map_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(map_relative_map_proto
        ${PROTOBUF_LIBRARIES}
        common::proto
        localization::proto
        map::proto
        perception::proto)
add_library(map::relative_map_proto ALIAS map_relative_map_proto)

install(TARGETS map_relative_map_proto
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
