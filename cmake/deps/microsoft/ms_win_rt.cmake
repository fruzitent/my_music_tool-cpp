set(MS_WIN_RT "ms_win_rt" CACHE INTERNAL "")
set(target ${MS_WIN_RT})

# https://github.com/Microsoft/cppwinrt.git
cpmaddpackage(
    NAME ${target}
    VERSION 2.0.240111.5
    URL
        "https://github.com/microsoft/cppwinrt/releases/download/2.0.240111.5/Microsoft.Windows.CppWinRT.2.0.240111.5.nupkg"
        URL_HASH
        "SHA256=E0E9076B0C8D5A85212015A8ABCFA7C92FDA28EF5FD9A25BE4DE221FCE65446D"
    DOWNLOAD_ONLY ON
)

add_library(${target} INTERFACE)
add_library(deps::${target} ALIAS ${target})

# set(CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE "x64")
# set(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION "10.0.19041.0")
# set(CMAKE_WINDOWS_KITS_10_DIR "C:/Program Files (x86)/Windows Kits/10")
# target_include_directories(${target} INTERFACE "${CMAKE_WINDOWS_KITS_10_DIR}/Lib/${CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION}/um/${CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE}/")
target_link_libraries(${target} INTERFACE "WindowsApp")
