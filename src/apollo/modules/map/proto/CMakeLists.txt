cmake_minimum_required(VERSION 3.5.1)

set(PROTOS map.proto
           map_clear_area.proto
           map_crosswalk.proto
           map_geometry.proto
           map_id.proto
           map_junction.proto
           map_lane.proto
           map_overlap.proto
           map_parking_space.proto
           map_pnc_junction.proto
           map_road.proto
           map_signal.proto
           map_speed_bump.proto
           map_speed_control.proto
           map_stop_sign.proto
           map_yield_sign.proto
           )

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(map_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(map_proto
        ${PROTOBUF_LIBRARIES}
        common::proto)
add_library(map::proto ALIAS map_proto)

install(TARGETS map_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
