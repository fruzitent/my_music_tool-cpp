set(MS_WINAPPSDK "ms_winappsdk" CACHE INTERNAL "")
set(target ${MS_WINAPPSDK})

# https://github.com/microsoft/WindowsAppSDK.git
cpmaddpackage(
    NAME ${target}
    VERSION 1.4.231219000
    URL
        "https://nuget.org/api/v2/package/Microsoft.WindowsAppSDK/1.4.231219000"
        URL_HASH
        "SHA256=9CC62DAD5A4BD756F60A7359B7C882DF9967E633D6EB568DA1B2BA1FC8532EF6"
    DOWNLOAD_ONLY ON
)

add_library(${target} SHARED IMPORTED GLOBAL)
add_library(deps::${target} ALIAS ${target})

target_sources(
    ${target}
    INTERFACE
        FILE_SET HEADERS
        BASE_DIRS
            "${CPM_PACKAGE_${target}_SOURCE_DIR}/include/"
)

set_target_properties(
    ${target}
    PROPERTIES
        IMPORTED_IMPLIB
            "${CPM_PACKAGE_${target}_SOURCE_DIR}/lib/win10-x64/Microsoft.WindowsAppRuntime.Bootstrap${CMAKE_STATIC_LIBRARY_SUFFIX}"
        IMPORTED_LOCATION
            "${CPM_PACKAGE_${target}_SOURCE_DIR}/runtimes/win10-x64/native/Microsoft.WindowsAppRuntime.Bootstrap${CMAKE_SHARED_LIBRARY_SUFFIX}"
)
