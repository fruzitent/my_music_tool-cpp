# https://cmake.org/cmake/help/latest/module/FetchContent.html
include(FetchContent)

set(MS_WIN_RT "ms_win_rt" CACHE INTERNAL "")
set(target ${MS_WIN_RT})

set(${target}_HASH "SHA256=4677321A12BEF84EFE46E8F3145352F1091EFFA562C8B0A46799B2F7DE13779B" CACHE INTERNAL "")
set(${target}_VERSION "2.0.240111.5" CACHE INTERNAL "")

# https://github.com/Microsoft/cppwinrt
fetchcontent_declare(
    ${target}
    URL
        "https://nuget.org/api/v2/package/Microsoft.Windows.CppWinRT/${${target}_VERSION}"
    URL_HASH ${${target}_HASH}
)
fetchcontent_makeavailable(${target})

set(${target}_BINARY_DIR ${${target}_BINARY_DIR} CACHE INTERNAL "")
set(${target}_SOURCE_DIR ${${target}_SOURCE_DIR} CACHE INTERNAL "")

add_library(${target} INTERFACE)
add_library(deps::${target} ALIAS ${target})

# set(CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE "x64")
# set(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION "10.0.19041.0")
# set(CMAKE_WINDOWS_KITS_10_DIR "C:/Program Files (x86)/Windows Kits/10")
# target_include_directories(${target} INTERFACE "${CMAKE_WINDOWS_KITS_10_DIR}/Lib/${CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION}/um/${CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE}/")
target_link_libraries(${target} INTERFACE "WindowsApp")
