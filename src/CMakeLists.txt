# @help: https://cmake.org/cmake/help/latest

add_subdirectory(./cli/)

if(UNIX)
    add_subdirectory(./gui-unix/)
endif()

if(WIN32)
    add_subdirectory(./gui-windows/)
endif()
