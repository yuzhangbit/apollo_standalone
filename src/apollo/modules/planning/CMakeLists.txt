cmake_minimum_required(VERSION 3.5.1)
project(planning)

add_subdirectory(proto)
add_subdirectory(math)
add_subdirectory(common)
add_subdirectory(reference_line)
add_subdirectory(constraint_checker)
add_subdirectory(lattice/behavior)
add_subdirectory(lattice/trajectory_generation)
add_subdirectory(open_space/coarse_trajectory_generator)
add_subdirectory(open_space/trajectory_smoother)
add_subdirectory(open_space/tools)

add_library(planning INTERFACE)
target_link_libraries(planning INTERFACE
    planning_proto
    planning_common_module
    planning_reference_line_module
    planning_constraint_checker_module
    planning_lattice_behavior_module
    planning_lattice_trajecotory_generation_module
    planning_open_space_trajectory_smoother_module
    planning_open_space_tools_module)

install(TARGETS planning
    EXPORT  apollo-export
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION .
)