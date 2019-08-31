cmake_minimum_required(VERSION 3.5.1)

set(PROTOS choreography_conf.proto
           classic_conf.proto
           component_conf.proto
           cyber_conf.proto
           dag_conf.proto
           parameter.proto
           perception.proto
           proto_desc.proto
           qos_profile.proto
           record.proto
           role_attributes.proto
           run_mode_conf.proto
           scheduler_conf.proto
           topology_change.proto
           transport_conf.proto
           unit_test.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(cyber_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(cyber_proto ${PROTOBUF_LIBRARIES})
add_library(cyber::proto ALIAS cyber_proto)


install(TARGETS cyber_proto
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

