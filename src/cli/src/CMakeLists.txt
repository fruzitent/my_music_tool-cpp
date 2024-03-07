# @help: https://cmake.org/cmake/help/latest

add_executable(${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME} PUBLIC deps::${MMT_SPOTIFY})

target_sources(${PROJECT_NAME} PUBLIC "main.cpp")
