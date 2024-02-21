set(RAYSAN_RAYLIB "raysan_raylib" CACHE INTERNAL "")
set(target ${RAYSAN_RAYLIB})

set(GLFW_BUILD_WAYLAND ON)
set(GLFW_BUILD_X11 OFF)

# https://github.com/raysan5/raylib.git
cpmaddpackage(
    NAME ${target}
    URL
        "https://github.com/raysan5/raylib/archive/refs/tags/5.0.tar.gz"
        URL_HASH
        "SHA256=98F049B9EA2A9C40A14E4E543EEEA1A7EC3090EBDCD329C4CA2CF98BC9793482"
    DOWNLOAD_ONLY OFF
)

add_library(${target} INTERFACE)
add_library(deps::${target} ALIAS ${target})

target_link_libraries(${target} INTERFACE raylib)
