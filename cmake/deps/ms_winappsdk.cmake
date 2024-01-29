# https://nuget.org/packages/Microsoft.WindowsAppSDK

set(MS_WINAPPSDK "ms_winappsdk" CACHE INTERNAL "")
set(MS_WINAPPSDK_HASH "9cc62dad5a4bd756f60a7359b7c882df9967e633d6eb568da1b2ba1fc8532ef6" CACHE INTERNAL "")
set(MS_WINAPPSDK_ID "Microsoft.WindowsAppSDK" CACHE INTERNAL "")
set(MS_WINAPPSDK_VERSION "1.4.231219000" CACHE INTERNAL "")

nuget_install(${MS_WINAPPSDK} ${MS_WINAPPSDK_ID} ${MS_WINAPPSDK_VERSION} ${MS_WINAPPSDK_HASH})

add_library(${MS_WINAPPSDK} IMPORTED GLOBAL SHARED)
add_library(deps::${MS_WINAPPSDK} ALIAS ${MS_WINAPPSDK})

set_target_properties(
    ${MS_WINAPPSDK}
    PROPERTIES
        IMPORTED_IMPLIB
            "${${MS_WINAPPSDK}_SOURCE_DIR}/lib/win10-x64/Microsoft.WindowsAppRuntime.Bootstrap.lib"
        IMPORTED_IMPLIB_DEBUG
            "${${MS_WINAPPSDK}_SOURCE_DIR}/lib/win10-x64/Microsoft.WindowsAppRuntime.Bootstrap.lib"
        IMPORTED_LOCATION
            "${${MS_WINAPPSDK}_SOURCE_DIR}/runtimes/win10-x64/native/Microsoft.WindowsAppRuntime.Bootstrap.dll"
        IMPORTED_LOCATION_DEBUG
            "${${MS_WINAPPSDK}_SOURCE_DIR}/runtimes/win10-x64/native/Microsoft.WindowsAppRuntime.Bootstrap.dll"
)

target_include_directories(${MS_WINAPPSDK} INTERFACE "${${MS_WINAPPSDK}_SOURCE_DIR}/include/")
