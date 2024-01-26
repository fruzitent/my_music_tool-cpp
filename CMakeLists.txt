# @help: https://cmake.org/cmake/help/latest

cmake_minimum_required(VERSION 3.28)

configure_file(.clangd.in ${CMAKE_SOURCE_DIR}/.clangd @ONLY)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

project(
    my_music_tool-cpp
    VERSION 0.1.0
    DESCRIPTION "my_music_tool-cpp"
    HOMEPAGE_URL "git+https://github.com/fruzitent/my_music_tool-cpp.git"
    LANGUAGES CXX
)
