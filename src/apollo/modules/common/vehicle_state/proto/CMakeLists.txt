cmake_minimum_required(VERSION 3.5.1)

set(PROTOS vehicle_state.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(common_vehicle_state_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(common_vehicle_state_proto
        ${PROTOBUF_LIBRARIES}
        localization::proto
        canbus::proto)
add_library(common::vehicle_state_proto ALIAS common_vehicle_state_proto)

install(TARGETS common_vehicle_state_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
