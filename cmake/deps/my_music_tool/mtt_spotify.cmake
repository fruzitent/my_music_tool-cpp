set(MMT_SPOTIFY "mmt_spotify" CACHE INTERNAL "")
set(target ${MMT_SPOTIFY})

set(CPM_PACKAGE_${target}_SOURCE_DIR "${CMAKE_SOURCE_DIR}/out/artifact/${target}" CACHE INTERNAL "")

add_library(${target} SHARED IMPORTED GLOBAL)
add_library(deps::${target} ALIAS ${target})

if(WIN32)
    target_link_libraries(
        ${target}
        INTERFACE
            "ntdll"
            "userenv"
            "WindowsApp"
    )
endif()

target_sources(
    ${target}
    INTERFACE
        FILE_SET HEADERS
        BASE_DIRS
            "${CPM_PACKAGE_${target}_SOURCE_DIR}/include/"
)

target_sources(${target} INTERFACE "${CPM_PACKAGE_${target}_SOURCE_DIR}/include/my_music_tool/spotify.cpp")

if(BUILD_SHARED_LIBS)
    set(TARGET_LOCATION "${CMAKE_SHARED_LIBRARY_PREFIX}spotify${CMAKE_SHARED_LIBRARY_SUFFIX}")
else()
    set(TARGET_LOCATION "${CMAKE_STATIC_LIBRARY_PREFIX}spotify${CMAKE_STATIC_LIBRARY_SUFFIX}")
endif()

if(BUILD_SHARED_LIBS)
    set(TARGET_IMPLIB "${CMAKE_STATIC_LIBRARY_SUFFIX}")
endif()

set_target_properties(
    ${target}
    PROPERTIES
        IMPORTED_IMPLIB
            "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}/${TARGET_LOCATION}${TARGET_IMPLIB}"
        IMPORTED_LOCATION
            "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/${CMAKE_SYSTEM_PROCESSOR}-${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}/${TARGET_LOCATION}"
        IMPORTED_NO_SONAME
            ON
)

install(IMPORTED_RUNTIME_ARTIFACTS ${target})
