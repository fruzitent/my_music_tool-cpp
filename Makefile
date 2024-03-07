CPP_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
RS_DIR  := $(CPP_DIR)/../rs

.PHONY: all
all: clean .WAIT install .WAIT build

.PHONY: build
build: ./out/build/unix-clang-release/
	cmake --build --preset "unix-clang-release"

.PHONY: clean
clean: clean_cmake clean_python

.PHONY: clean_cmake
clean_cmake:
	rm --force --recursive "./.cache/"
	rm --force --recursive "./out/"
	rm --force "./.clangd"

.PHONY: clean_python
clean_python:
	rm --force --recursive "./.venv/"
	rm --force --recursive "./src/my_music_tool_cpp.egg-info/"

.PHONY: docker
docker:
	docker buildx build . \
		--build-context rs="../rs/" \
		--file "./docker/Dockerfile" \
		--output "dest=./,type=local" \
		--tag "ghcr.io/fruzitent/my_music_tool-cpp:latest" \
		--target "artifact" \
		;

.PHONY: install
install: install_cmake install_ffi install_lib install_python

.PHONY: install_cmake
install_cmake: ./out/build/unix-clang-release/

./out/build/unix-clang-release/:
	cmake --preset "unix-clang-release"

.PHONY: install_ffi
install_ffi: $(CPP_DIR)/out/artifact/mmt_spotify/include/my_music_tool/

$(CPP_DIR)/out/artifact/mmt_spotify/include/my_music_tool/: $(RS_DIR)/out/include/my_music_tool/
	mkdir --parent      "$(CPP_DIR)/out/artifact/mmt_spotify/include/"
	cp --recursive "$<" "$(CPP_DIR)/out/artifact/mmt_spotify/include/"

.PHONY: install_lib
install_lib: $(CPP_DIR)/out/artifact/mmt_spotify/lib/debug/libspotify.a $(CPP_DIR)/out/artifact/mmt_spotify/lib/debug/libspotify.so $(CPP_DIR)/out/artifact/mmt_spotify/lib/release/libspotify.a $(CPP_DIR)/out/artifact/mmt_spotify/lib/release/libspotify.so

$(CPP_DIR)/out/artifact/mmt_spotify/lib/debug/libspotify.a: $(RS_DIR)/target/debug/libspotify.a
	mkdir --parent "$(CPP_DIR)/out/artifact/mmt_spotify/lib/debug/"
	cp "$<" "$@"

$(CPP_DIR)/out/artifact/mmt_spotify/lib/debug/libspotify.so: $(RS_DIR)/target/debug/libspotify.so
	mkdir --parent "$(CPP_DIR)/out/artifact/mmt_spotify/lib/debug/"
	cp "$<" "$@"

$(CPP_DIR)/out/artifact/mmt_spotify/lib/release/libspotify.a: $(RS_DIR)/target/release/libspotify.a
	mkdir --parent "$(CPP_DIR)/out/artifact/mmt_spotify/lib/release/"
	cp "$<" "$@"

$(CPP_DIR)/out/artifact/mmt_spotify/lib/release/libspotify.so: $(RS_DIR)/target/release/libspotify.so
	mkdir --parent "$(CPP_DIR)/out/artifact/mmt_spotify/lib/release/"
	cp "$<" "$@"

.PHONY: install_python
install_python: ./.venv/
	. ./.venv/bin/activate && pip install -e ".[dev]"

./.venv/:
	python3 -m venv "./.venv/"
