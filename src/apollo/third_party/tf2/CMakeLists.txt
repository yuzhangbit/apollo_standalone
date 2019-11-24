cmake_minimum_required(VERSION 3.5.1)

find_package(Boost REQUIRED COMPONENTS system thread)
include_directories(include)

add_library(3rdparty_tf2 STATIC src/cache.cpp
                                src/buffer_core.cpp
                                src/static_cache.cpp
                                src/time.cpp)
target_link_libraries(3rdparty_tf2 ${Boost_LIBRARIES})
add_library(3rdparty::tf2 ALIAS 3rdparty_tf2)


install(TARGETS 3rdparty_tf2
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
