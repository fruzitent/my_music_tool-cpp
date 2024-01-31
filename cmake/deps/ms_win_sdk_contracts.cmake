# https://cmake.org/cmake/help/latest/module/FetchContent.html
include(FetchContent)

set(MS_WIN_SDK_CONTRACTS "ms_win_sdk_contracts" CACHE INTERNAL "")
set(target ${MS_WIN_SDK_CONTRACTS})

set(${target}_HASH "SHA256=DBEBA07806DACDB38A8F6E4677E2B06C52D79AEAB58E0F5B38191BD41314E416" CACHE INTERNAL "")
set(${target}_VERSION "10.0.22621.2428" CACHE INTERNAL "")

# https://nuget.org/packages/Microsoft.Windows.SDK.Contracts
fetchcontent_declare(
    ${target}
    URL
        "https://nuget.org/api/v2/package/Microsoft.Windows.SDK.Contracts/${${target}_VERSION}"
    URL_HASH ${${target}_HASH}
)
fetchcontent_makeavailable(${target})

set(${target}_BINARY_DIR ${${target}_BINARY_DIR} CACHE INTERNAL "")
set(${target}_SOURCE_DIR ${${target}_SOURCE_DIR} CACHE INTERNAL "")

add_library(${target} INTERFACE)
add_library(deps::${target} ALIAS ${target})
