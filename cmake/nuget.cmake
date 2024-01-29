include_guard()

# https://cmake.org/cmake/help/latest/module/FetchContent.html
include(FetchContent)

function(nuget_install target_name pkg_id pkg_version pkg_hash)
    set(content ${target_name}_nupkg)
    set(url https://nuget.org/api/v2/package/${pkg_id}/${pkg_version})

    fetchcontent_declare(${content} URL ${url} URL_HASH SHA256=${pkg_hash})
    fetchcontent_makeavailable(${content})

    set(${target_name}_BINARY_DIR ${${content}_BINARY_DIR} CACHE INTERNAL "")
    set(${target_name}_SOURCE_DIR ${${content}_SOURCE_DIR} CACHE INTERNAL "")
endfunction()
