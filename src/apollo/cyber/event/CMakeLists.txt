cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_perf_event perf_event.h)
set_target_properties(cyber_perf_event PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_perf_event cyber::global_data)
add_library(cyber::perf_event ALIAS cyber_perf_event)

add_library(cyber_perf_event_cache perf_event_cache.cc)
target_link_libraries(cyber_perf_event_cache cyber::perf_event
                                             cyber::state
                                             cyber::bounded_queue
                                             cyber::global_data
                                             cyber::log
                                             cyber::common_macros
                                             cyber::time)
add_library(cyber::perf_event_cache ALIAS cyber_perf_event_cache)

install(TARGETS cyber_perf_event
                cyber_perf_event_cache
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
