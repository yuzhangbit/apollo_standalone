        cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_base atomic_hash_map.h
                       atomic_rw_lock.h
                       bounded_queue.h
                       concurrent_object_pool.h
                       for_each.h
                       macros.h
                       object_pool.h
                       reentrant_rw_lock.h
                       rw_lock_guard.h
                       signal.h
                       thread_pool.h
                       thread_safe_queue.h
                       unbounded_queue.h
                       wait_strategy.h)

set_target_properties(cyber_base PROPERTIES LINKER_LANGUAGE CXX)


add_library(cyber::base ALIAS cyber_base)

add_executable(signal_test signal_test.cc)
target_link_libraries(signal_test gtest gtest_main cyber::base)

add_executable(atomic_hash_map_test atomic_hash_map_test.cc)
target_link_libraries(atomic_hash_map_test gtest gtest_main cyber::base)

add_executable(atomic_rw_lock_test atomic_rw_lock_test.cc)
target_link_libraries(atomic_rw_lock_test gtest gtest_main cyber::base)

add_executable(bounded_queue_test bounded_queue_test.cc)
target_link_libraries(bounded_queue_test gtest gtest_main cyber::base)

add_executable(for_each_test for_each_test.cc)
target_link_libraries(for_each_test gtest gtest_main cyber::base)

add_executable(object_pool_test object_pool_test.cc)
target_link_libraries(object_pool_test gtest gtest_main atomic cyber::base)




install(TARGETS cyber_base signal_test
                atomic_hash_map_test
                atomic_rw_lock_test
                bounded_queue_test
                for_each_test
                object_pool_test
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
