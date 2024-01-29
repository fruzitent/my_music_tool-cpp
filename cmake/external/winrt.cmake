# gersemi: off

execute_process(
    COMMAND "${${MS_WIN_RT}_SOURCE_DIR}/bin/cppwinrt"

    # winrt::Microsoft (Windows App SDK)
    -input "${${MS_WINAPPSDK}_SOURCE_DIR}/lib/uap10.0/"
    -input "${${MS_WINAPPSDK}_SOURCE_DIR}/lib/uap10.0.18362/"

    # winrt::Windows (UWP)
    -input "${${MS_WIN_SDK_CONTRACTS}_SOURCE_DIR}/ref/netstandard2.0/"

    -output "${CMAKE_BINARY_DIR}/include/"
)

# gersemi: on
