.PHONY: all
all: clean .WAIT install .WAIT build

.PHONY: build
build: ./out/build/unix-gcc-debug/
	cmake --build --preset "unix-gcc-debug"

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
		--file "./docker/Dockerfile" \
		--output "dest=./,type=local" \
		--tag "ghcr.io/fruzitent/my_music_tool-cpp:latest" \
		--target "artifact" \
		;

.PHONY: install
install: install_cmake install_python

.PHONY: install_cmake
install_cmake: ./out/build/unix-gcc-debug/

./out/build/unix-gcc-debug/:
	cmake --preset "unix-gcc-debug"

.PHONY: install_python
install_python: ./.venv/
	. ./.venv/bin/activate && pip install -e ".[dev]"

./.venv/:
	python3 -m venv "./.venv/"
