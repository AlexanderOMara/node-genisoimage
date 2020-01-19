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
release='22960555'

commit_id="$(git rev-parse HEAD)"
build_number="$1"
build_id="${commit_id}-${build_number}"
file_name="$(basename "${file_path}")"
build_file="${build_id}-${file_name}"

cd "${__dir}/.."

echo "build_id: ${build_id}"
tar -cz -f "${file_path}" "${dir_path}"
if hash shasum 2>/dev/null; then
	shasum -a 256 "${file_path}"
fi

echo "Uploading..."

output="$(curl -s \
    -H "Authorization: token ${GITHUB_API_KEY}" \
    -H "Content-Type: application/octet-stream" \
    --data-binary "@${file_path}" \
    "https://uploads.github.com/repos/${repo}/releases/${release}/assets?name=${build_file}"
)"

rm "${file_path}"

if [[ "$output" == *'"errors":'* ]]; then
	echo "ERROR:"
	echo "$output"
	exit 1
fi
echo "Done"
