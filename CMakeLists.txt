# @help: https://cmake.org/cmake/help/latest

cmake_minimum_required(VERSION 3.28)

# https://cmake.org/cmake/help/latest/module/CMakePrintHelpers.html
include(CMakePrintHelpers)

# https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "Generates compile_commands.json")
cmake_print_variables(CMAKE_EXPORT_COMPILE_COMMANDS)

project(
    my_music_tool-cpp
    VERSION 0.1.0
    DESCRIPTION "my_music_tool-cpp"
    HOMEPAGE_URL "git+https://github.com/fruzitent/my_music_tool-cpp.git"
    LANGUAGES
        C
        CXX
)

add_subdirectory(./configured_files/)
