set(GET_CPM_HASH "SHA256=E8BBED248755AF46A0CF7BB35084C2D991DBE5FBB615674F6640BA664C72A70F" CACHE INTERNAL "")
set(GET_CPM_VERSION "v0.38.7" CACHE INTERNAL "")

# https://github.com/cpm-cmake/CPM.cmake.git
file(
    DOWNLOAD
        https://github.com/cpm-cmake/CPM.cmake/releases/download/${GET_CPM_VERSION}/get_cpm.cmake
        ${CMAKE_BINARY_DIR}/cmake/get_cpm.cmake
    EXPECTED_HASH ${GET_CPM_HASH}
)

set(FETCHCONTENT_QUIET OFF)
set(CPM_SOURCE_CACHE "${CMAKE_SOURCE_DIR}/.cache/")

include(${CMAKE_BINARY_DIR}/cmake/get_cpm.cmake)
