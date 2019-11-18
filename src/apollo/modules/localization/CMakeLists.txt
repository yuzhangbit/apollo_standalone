cmake_minimum_required(VERSION 3.5.1)

add_subdirectory(proto)
add_subdirectory(common)

add_library(localization INTERFACE)
target_link_libraries(localization INTERFACE
        localization_proto
        localization_common_module
        )

install(TARGETS localization
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
