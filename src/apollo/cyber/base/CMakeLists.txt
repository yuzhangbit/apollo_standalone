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


add_library(cyber_base_macros macros.h)
set_target_properties(cyber_base_macros PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::base_macros ALIAS cyber_base_macros)

add_library(cyber_wait_strategy wait_strategy.h)
set_target_properties(cyber_wait_strategy PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::wait_strategy ALIAS cyber_wait_strategy)

add_library(cyber_bounded_queue bounded_queue.h)
set_target_properties(cyber_bounded_queue PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_bounded_queue cyber::base_macros
                                          cyber::wait_strategy)
add_library(cyber::bounded_queue ALIAS cyber_bounded_queue)

add_library(cyber_atomic_hash_map atomic_hash_map.h)
set_target_properties(cyber_atomic_hash_map PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::atomic_hash_map ALIAS cyber_atomic_hash_map)

add_library(cyber_for_each for_each.h)
set_target_properties(cyber_for_each PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_for_each cyber::base_macros)
add_library(cyber::for_each ALIAS cyber_for_each)

add_library(cyber_concurrent_object_pool concurrent_object_pool.h)
set_target_properties(cyber_concurrent_object_pool PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_concurrent_object_pool cyber::for_each)
add_library(cyber::concurrent_object_pool ALIAS cyber_concurrent_object_pool)

add_library(cyber_signal signal.h)
set_target_properties(cyber_signal PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::signal ALIAS cyber_signal)

add_library(cyber_rw_lock_guard rw_lock_guard.h)
set_target_properties(cyber_rw_lock_guard PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::rw_lock_guard ALIAS cyber_rw_lock_guard)

add_library(cyber_atomic_rw_lock atomic_rw_lock.h)
set_target_properties(cyber_atomic_rw_lock PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_atomic_rw_lock cyber::rw_lock_guard)
add_library(cyber::atomic_rw_lock ALIAS cyber_atomic_rw_lock)

add_library(cyber_object_pool object_pool.h)
set_target_properties(cyber_object_pool PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(cyber_object_pool cyber::for_each
                                        cyber::base_macros)
add_library(cyber::object_pool ALIAS cyber_object_pool)

add_library(cyber_reentrant_rw_lock reentrant_rw_lock.h)
set_target_properties(cyber_reentrant_rw_lock PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::reentrant_rw_lock ALIAS cyber_reentrant_rw_lock)

add_library(cyber_thread_pool thread_pool.h)
set_target_properties(cyber_thread_pool PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::thread_pool ALIAS cyber_thread_pool)

add_library(cyber_thread_safe_queue thread_safe_queue.h)
set_target_properties(cyber_thread_safe_queue PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::thread_safe_queue ALIAS cyber_thread_safe_queue)

add_library(cyber_unbounded_queue unbounded_queue.h)
set_target_properties(cyber_unbounded_queue PROPERTIES LINKER_LANGUAGE CXX)
add_library(cyber::unbounded_queue ALIAS cyber_unbounded_queue)

add_library(cyber_base_module INTERFACE)
target_link_libraries(cyber_base_module INTERFACE
                      cyber_base
                      cyber_atomic_hash_map
                      cyber_atomic_rw_lock
                      cyber_bounded_queue
                      cyber_concurrent_object_pool
                      cyber_for_each
                      cyber_base_macros
                      cyber_object_pool
                      cyber_reentrant_rw_lock
                      cyber_rw_lock_guard
                      cyber_signal
                      cyber_thread_pool
                      cyber_thread_safe_queue
                      cyber_unbounded_queue
                      cyber_wait_strategy)


install(TARGETS cyber_base_module
                cyber_base
                cyber_atomic_hash_map
                cyber_atomic_rw_lock
                cyber_bounded_queue
                cyber_concurrent_object_pool
                cyber_for_each
                cyber_base_macros
                cyber_object_pool
                cyber_reentrant_rw_lock
                cyber_rw_lock_guard
                cyber_signal
                cyber_thread_pool
                cyber_thread_safe_queue
                cyber_unbounded_queue
                cyber_wait_strategy
        EXPORT apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        )

install(TARGETS signal_test
                atomic_hash_map_test
                atomic_rw_lock_test
                bounded_queue_test
                for_each_test
                object_pool_test
        RUNTIME DESTINATION bin
  )
