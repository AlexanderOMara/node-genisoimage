FROM trzeci/emscripten:sdk-tag-1.39.4-64bit

COPY \
	patch/patched/library_fs.js \
	patch/patched/library_nodefs.js \
	patch/patched/library_noderawfs.js \
	patch/patched/library_syscall.js \
	patch/patched/struct_info.json \
	/emsdk_portable/emscripten/tag-1.39.4/src/

RUN emcc --clear-cache
