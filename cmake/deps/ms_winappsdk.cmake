# https://cmake.org/cmake/help/latest/module/FetchContent.html
include(FetchContent)

set(MS_WINAPPSDK "ms_winappsdk" CACHE INTERNAL "")
set(target ${MS_WINAPPSDK})

set(${target}_HASH "SHA256=9CC62DAD5A4BD756F60A7359B7C882DF9967E633D6EB568DA1B2BA1FC8532EF6" CACHE INTERNAL "")
set(${target}_VERSION "1.4.231219000" CACHE INTERNAL "")

# https://github.com/microsoft/WindowsAppSDK
fetchcontent_declare(
    ${target}
    URL
        "https://nuget.org/api/v2/package/Microsoft.WindowsAppSDK/${${target}_VERSION}"
    URL_HASH ${${target}_HASH}
)
fetchcontent_makeavailable(${target})

set(${target}_BINARY_DIR ${${target}_BINARY_DIR} CACHE INTERNAL "")
set(${target}_SOURCE_DIR ${${target}_SOURCE_DIR} CACHE INTERNAL "")

add_library(${target} IMPORTED GLOBAL SHARED)
add_library(deps::${target} ALIAS ${target})

set_target_properties(
    ${target}
    PROPERTIES
        IMPORTED_IMPLIB
            "${${target}_SOURCE_DIR}/lib/win10-x64/Microsoft.WindowsAppRuntime.Bootstrap.lib"
        IMPORTED_IMPLIB_DEBUG
            "${${target}_SOURCE_DIR}/lib/win10-x64/Microsoft.WindowsAppRuntime.Bootstrap.lib"
        IMPORTED_LOCATION
            "${${target}_SOURCE_DIR}/runtimes/win10-x64/native/Microsoft.WindowsAppRuntime.Bootstrap.dll"
        IMPORTED_LOCATION_DEBUG
            "${${target}_SOURCE_DIR}/runtimes/win10-x64/native/Microsoft.WindowsAppRuntime.Bootstrap.dll"
)

target_include_directories(${target} INTERFACE "${${target}_SOURCE_DIR}/include/")
