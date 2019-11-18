cmake_minimum_required(VERSION 3.5.1)

set(PROTOS vehicle_model_config.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(common_vehicle_model_config_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(common_vehicle_model_config_proto
        ${PROTOBUF_LIBRARIES})
add_library(common::vehicle_model_config_proto ALIAS common_vehicle_model_config_proto)

add_library(common_vehicle_model_config_proto_module INTERFACE)
target_link_libraries(common_vehicle_model_config_proto_module INTERFACE
        common_vehicle_model_config_proto
        )

install(TARGETS common_vehicle_model_config_proto
                common_vehicle_model_config_proto_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
