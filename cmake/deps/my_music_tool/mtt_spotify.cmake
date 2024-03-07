set(MMT_SPOTIFY "mmt_spotify" CACHE INTERNAL "")
set(target ${MMT_SPOTIFY})

set(CPM_PACKAGE_${target}_SOURCE_DIR "${CMAKE_SOURCE_DIR}/out/artifact/${target}" CACHE INTERNAL "")

add_library(${target} SHARED IMPORTED GLOBAL)
add_library(deps::${target} ALIAS ${target})

target_sources(${target} INTERFACE "${CPM_PACKAGE_${target}_SOURCE_DIR}/include/my_music_tool/spotify.cpp")

if(BUILD_SHARED_LIBS)
    set(LIBSPOTIFY_DEBUG "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/debug/libspotify${CMAKE_SHARED_LIBRARY_SUFFIX}")
    set(LIBSPOTIFY_RELEASE "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/release/libspotify${CMAKE_SHARED_LIBRARY_SUFFIX}")
else()
    set(LIBSPOTIFY_DEBUG "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/debug/libspotify${CMAKE_STATIC_LIBRARY_SUFFIX}")
    set(LIBSPOTIFY_RELEASE "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/release/libspotify${CMAKE_STATIC_LIBRARY_SUFFIX}")
endif()

set_target_properties(
    ${target}
    PROPERTIES
        IMPORTED_LOCATION_DEBUG
            ${LIBSPOTIFY_DEBUG}
        IMPORTED_LOCATION_RELEASE
            ${LIBSPOTIFY_RELEASE}
)

target_include_directories(${target} INTERFACE "${CPM_PACKAGE_${target}_SOURCE_DIR}/include/")
