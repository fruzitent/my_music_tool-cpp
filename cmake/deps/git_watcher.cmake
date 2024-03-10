set(GIT_WATCHER "git_watcher" CACHE INTERNAL "")
set(target ${GIT_WATCHER})

cpmaddpackage(
    NAME ${target}
    URL
        "https://github.com/fruzitent/cmake-git-version-tracking/archive/bccd6201a9fab82578c2da53eff8108bfb25a10d.tar.gz"
        URL_HASH
        "SHA256=71AE0904DF22DDC38FC438E774EE875CB2F59C3CA0A076173A3844B3F543C294"
    DOWNLOAD_ONLY OFF
)

add_library(${target} INTERFACE)
add_library(deps::${target} ALIAS ${target})

target_link_libraries(${target} INTERFACE cmake_git_version_tracking)
