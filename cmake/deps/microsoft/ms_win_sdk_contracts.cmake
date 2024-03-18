set(MS_WIN_SDK_CONTRACTS "ms_win_sdk_contracts" CACHE INTERNAL "")
set(target ${MS_WIN_SDK_CONTRACTS})

# https://nuget.org/packages/Microsoft.Windows.SDK.Contracts
cpmaddpackage(
    NAME ${target}
    VERSION 10.0.22621.2428
    URL
        "https://nuget.org/api/v2/package/Microsoft.Windows.SDK.Contracts/10.0.22621.2428"
        URL_HASH
        "SHA256=DBEBA07806DACDB38A8F6E4677E2B06C52D79AEAB58E0F5B38191BD41314E416"
    DOWNLOAD_ONLY ON
)

add_library(${target} INTERFACE)
add_library(deps::${target} ALIAS ${target})
