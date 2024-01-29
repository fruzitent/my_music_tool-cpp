# @help: https://cmake.org/cmake/help/latest

add_executable(${PROJECT_NAME})

add_custom_command(
    TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND
    ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:${PROJECT_NAME}> $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND_EXPAND_LISTS
)

target_include_directories(${PROJECT_NAME} PUBLIC "${CMAKE_BINARY_DIR}/include/")

target_link_libraries(
    ${PROJECT_NAME}
    PUBLIC
    "deps::${MS_WIN_RT}"
    "deps::${MS_WIN_SDK_CONTRACTS}"
    "deps::${MS_WINAPPSDK}"
)

target_precompile_headers(${PROJECT_NAME} PUBLIC "pch.hpp")

target_sources(${PROJECT_NAME} PUBLIC "main.cpp")
