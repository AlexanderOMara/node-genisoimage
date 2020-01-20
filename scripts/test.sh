#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

cd "${__dir}/.."

# TODO: Not very thorough testing, could use more tests.
rm -rf 'spec/disk.iso'
./bin/node-genisoimage -D -V 'volume' -no-pad -r -o 'spec/disk.iso' 'spec/disk'
output="$(strings 'spec/disk.iso')"
uid="$(cat spec/disk/dir/sub/uid.txt)"
if [[ "${output}" == *"${uid}"* ]]; then
	echo 'PASS: spec/disk.iso'
else
	echo 'FAIL: spec/disk.iso'
	exit 1
fi
