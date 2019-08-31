cmake_minimum_required(VERSION 3.5.1)

add_library(routing_routing_gflags routing_gflags.cc)
target_link_libraries(routing_routing_gflags ${gflags_LIBRARIES})
add_library(routing::routing_gflags ALIAS routing_routing_gflags)


install(TARGETS routing_routing_gflags
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
