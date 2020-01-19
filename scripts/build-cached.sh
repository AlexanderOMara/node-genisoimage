#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ $# -ne 1 ]; then
	echo "Usage: $0 BUILD_ID"
	exit 1
fi

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

dir_path='lib'
file_path='lib.tar.gz'
repo='AlexanderOMara/node-genisoimage'
release='build-cache'

commit_id="$(git rev-parse HEAD)"
build_number="$1"
build_id="${commit_id}-${build_number}"
file_name="$(basename "${file_path}")"
build_file="${build_id}-${file_name}"

cd "${__dir}/.."

echo "build_id: ${build_id}"

rm -rf "${dir_path}"
wget -O "${file_path}" \
	"https://github.com/${repo}/releases/download/${release}/${build_file}"

if hash shasum 2>/dev/null; then
	shasum -a 256 "${file_path}"
fi
tar xvz -f "${file_path}"
rm -rf "${file_path}"
