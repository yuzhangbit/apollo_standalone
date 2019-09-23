cmake_minimum_required(VERSION 3.5.1)

add_library(cyber_class_loader class_loader.cc
                               utility/class_factory.cc
                               utility/class_loader_utility.cc)
add_library(cyber::class_loader ALIAS cyber_class_loader)
target_link_libraries(cyber_class_loader PocoFoundation #todo: find_package
                                         cyber::log
                                         cyber::init
                                         )

add_library(cyber_class_loader_manager class_loader_manager.cc)
add_library(cyber::class_loader_manager ALIAS cyber_class_loader_manager)
target_link_libraries(cyber_class_loader cyber::class_loader)


install(TARGETS cyber_class_loader
                cyber_class_loader_manager
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )
