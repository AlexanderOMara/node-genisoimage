#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

patch_dir='patch'
patched_dir='patched'
patch_file='patch.diff'
tag='1.39.4'
sources=(
'library_fs.js'
'library_nodefs.js'
'library_noderawfs.js'
'library_syscall.js'
'struct_info.json'
)

patch_dir_abs="${__dir}/${patch_dir}"
patched_dir_abs="${patch_dir_abs}/${patched_dir}"
patch_file_abs="${patch_dir_abs}/${patch_file}"

rm -rf "${patched_dir_abs}"
mkdir -p "${patched_dir_abs}"

for source in "${sources[@]}"; do
	wget -O "${patched_dir_abs}/${source}" \
		"https://raw.githubusercontent.com/emscripten-core/emscripten/${tag}/src/${source}"
done

patch -d "${patched_dir_abs}" -p1 < "${patch_file_abs}"
