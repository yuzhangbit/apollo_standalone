cmake_minimum_required(VERSION 3.5.1)

add_library(map_pnc_map_path path.cc)
target_link_libraries(map_pnc_map_path common::math
                                       map::hdmap
                                       map::hdmap_util
                                       map::proto
                                       routing::proto)
add_library(map::pnc_map_path ALIAS map_pnc_map_path)



add_library(map_route_segments route_segments.cc)
target_link_libraries(map_route_segments common::proto
                                       map::hdmap
                                       map::pnc_map_path
                                       routing::routing_gflags)
add_library(map::route_segments ALIAS map_route_segments)


add_library(map_pnc_map pnc_map.cc)
target_link_libraries(map_pnc_map map::route_segments
                                  map::hdmap
                                  map::pnc_map_path
                                  common::proto
                                  planning::planning_gflags
                                  routing::routing_gflags)
add_library(map::pnc_map ALIAS map_pnc_map)


install(TARGETS map_pnc_map_path
                map_route_segments
                map_pnc_map
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
