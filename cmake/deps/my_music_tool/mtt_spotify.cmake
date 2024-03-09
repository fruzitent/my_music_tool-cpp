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
    set(TARGET_NAME "${CMAKE_SHARED_LIBRARY_PREFIX}spotify${CMAKE_SHARED_LIBRARY_SUFFIX}")
    set(TARGET_LOCATION_DEBUG "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/debug/${TARGET_NAME}")
    set(TARGET_LOCATION_RELEASE "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/release/${TARGET_NAME}")
    set(TARGET_IMPLIB_DEBUG "${TARGET_LOCATION_DEBUG}${CMAKE_STATIC_LIBRARY_SUFFIX}")
    set(TARGET_IMPLIB_RELEASE "${TARGET_LOCATION_RELEASE}${CMAKE_STATIC_LIBRARY_SUFFIX}")
else()
    set(TARGET_NAME "${CMAKE_STATIC_LIBRARY_PREFIX}spotify${CMAKE_STATIC_LIBRARY_SUFFIX}")
    set(TARGET_LOCATION_DEBUG "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/debug/${TARGET_NAME}")
    set(TARGET_LOCATION_RELEASE "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/release/${TARGET_NAME}")
    set(TARGET_IMPLIB_DEBUG "${TARGET_LOCATION_DEBUG}")
    set(TARGET_IMPLIB_RELEASE "${TARGET_LOCATION_RELEASE}")
endif()

set_target_properties(
    ${target}
    PROPERTIES
        IMPORTED_IMPLIB_DEBUG
            ${TARGET_IMPLIB_DEBUG}
        IMPORTED_IMPLIB_RELEASE
            ${TARGET_IMPLIB_RELEASE}
        IMPORTED_LOCATION_DEBUG
            ${TARGET_LOCATION_DEBUG}
        IMPORTED_LOCATION_RELEASE
            ${TARGET_LOCATION_RELEASE}
        IMPORTED_NO_SONAME
            ON
)

install(IMPORTED_RUNTIME_ARTIFACTS ${target})
