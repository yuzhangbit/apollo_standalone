cmake_minimum_required(VERSION 3.5.1)

add_library(map_opendrive_adapter coordinate_convert_tool.cc
                                  opendrive_adapter.cc
                                  proto_organizer.cc
                                  xml_parser/header_xml_parser.cc
                                  xml_parser/junctions_xml_parser.cc
                                  xml_parser/lanes_xml_parser.cc
                                  xml_parser/objects_xml_parser.cc
                                  xml_parser/roads_xml_parser.cc
                                  xml_parser/signals_xml_parser.cc
                                  xml_parser/util_xml_parser.cc)

target_link_libraries(map_opendrive_adapter common::math
                                            common::status
                                            common::util
                                            map::proto
                                            cyber::common
                                            ${TINYXML2_LIBRARIES}
                                            ${PROJ4_LIBRARIES})

add_library(map::opendrive_adapter ALIAS map_opendrive_adapter)


install(TARGETS map_opendrive_adapter
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

