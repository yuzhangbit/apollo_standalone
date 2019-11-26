cmake_minimum_required(VERSION 3.5.1)

add_library(localization_localization_common localization_gflags.cc)
target_link_libraries(localization_localization_common ${gflags_LIBRARIES})
add_library(localization::localization_common ALIAS localization_localization_common)

add_library(localization_common_module INTERFACE)
target_link_libraries(localization_common_module INTERFACE
        localization_localization_common)

install(TARGETS localization_localization_common
                localization_common_module
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
