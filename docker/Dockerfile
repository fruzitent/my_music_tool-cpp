# syntax=docker/dockerfile:1.6-labs
# @help: https://docs.docker.com/reference/dockerfile

ARG WORKDIR="/workspaces/my_music_tool-cpp/"

FROM docker.io/library/ubuntu:24.04 as base

ARG WORKDIR
WORKDIR ${WORKDIR}

ARG DEBIAN_FRONTEND="noninteractive"

# @see: https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mounttypecache
RUN <<EOF
    rm -rf "/etc/apt/apt.conf.d/docker-clean"
EOF

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt/,sharing=locked --mount=type=cache,target=/var/lib/apt/,sharing=locked <<EOF
    apt-get update
    apt-get -y install --no-install-recommends \
        "clang-18" \
        "clang-tools-18" \
        "cmake" \
        "gcc-14" \
        "libc++-18-dev" \
        "libstdc++-14-dev" \
        "mold" \
        "ninja-build" \
        "pkg-config" \
        ;
    update-alternatives --install "/usr/local/bin/clang"   clang   "/usr/bin/clang-18"   1
    update-alternatives --install "/usr/local/bin/clang++" clang++ "/usr/bin/clang++-18" 1
    update-alternatives --install "/usr/local/bin/g++"     g++     "/usr/bin/g++-14"     1
    update-alternatives --install "/usr/local/bin/gcc"     gcc     "/usr/bin/gcc-14"     1
EOF

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt/,sharing=locked --mount=type=cache,target=/var/lib/apt/,sharing=locked <<EOF
    apt-get update
    apt-get -y install --no-install-recommends \
        "git" \
        "neovim" \
        ;
EOF

FROM base as deps

ARG WORKDIR
WORKDIR ${WORKDIR}

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt/,sharing=locked --mount=type=cache,target=/var/lib/apt/,sharing=locked <<EOF
    apt-get update
    apt-get -y install --no-install-recommends \
        "libgl-dev" \
        "libwayland-dev" \
        "libxkbcommon-dev" \
        "wayland-protocols" \
        ;
EOF

CMD ["sleep", "infinity"]

FROM deps as builder

ARG WORKDIR
WORKDIR ${WORKDIR}

COPY "./cmake"            "${WORKDIR}/cmake/"
COPY "./configured_files" "${WORKDIR}/configured_files/"
COPY "./src"              "${WORKDIR}/src/"

COPY "./CMakeLists.txt"    "${WORKDIR}/"
COPY "./CMakePresets.json" "${WORKDIR}/"

RUN --mount=type=cache,target=${WORKDIR}/.cache/,sharing=locked <<EOF
    cmake --workflow --preset "unix-clang-release"
EOF

# hadolint ignore=DL3006
FROM scratch as artifact

ARG WORKDIR

COPY --from=builder "${WORKDIR}/out/build/unix-clang-release/src/cli/src/cli"           "/out/build/unix-clang-release/src/cli/src/"
COPY --from=builder "${WORKDIR}/out/build/unix-clang-release/src/gui-unix/src/gui-unix" "/out/build/unix-clang-release/src/gui-unix/src/"

FROM docker.io/library/ubuntu:24.04 as runner

ARG WORKDIR
WORKDIR ${WORKDIR}

COPY --from=builder "${WORKDIR}/out/build/unix-clang-release/src/cli/src/cli"           "/usr/local/bin/my_music_tool-cli"
COPY --from=builder "${WORKDIR}/out/build/unix-clang-release/src/gui-unix/src/gui-unix" "/usr/local/bin/my_music_tool-gui"

CMD ["/usr/local/bin/my_music_tool-cli"]
