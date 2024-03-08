# @help: https://cmake.org/cmake/help/latest

add_executable(${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME} PUBLIC deps::${RAYSAN_RAYLIB})

target_sources(${PROJECT_NAME} PUBLIC "main.cpp")

install(TARGETS ${PROJECT_NAME})
