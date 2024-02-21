# @help: https://cmake.org/cmake/help/latest

if(NOT WIN32)
    return()
endif()

include(./ms_win_rt.cmake)
include(./ms_win_sdk_contracts.cmake)
include(./ms_winappsdk.cmake)

# gersemi: off
execute_process(
    COMMAND "${CPM_PACKAGE_${MS_WIN_RT}_SOURCE_DIR}/bin/cppwinrt"

    # winrt::Microsoft (Windows App SDK)
    -input "${CPM_PACKAGE_${MS_WINAPPSDK}_SOURCE_DIR}/lib/uap10.0/"
    -input "${CPM_PACKAGE_${MS_WINAPPSDK}_SOURCE_DIR}/lib/uap10.0.18362/"

    # winrt::Windows (UWP)
    -input "${CPM_PACKAGE_${MS_WIN_SDK_CONTRACTS}_SOURCE_DIR}/ref/netstandard2.0/"

    -output "${CMAKE_BINARY_DIR}/include/"

    COMMAND_ECHO STDERR
)

# gersemi: on
