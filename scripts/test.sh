#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

cd "${__dir}/.."

errored=0

# TODO: Not very thorough testing, could use more tests.
rm -rf 'spec/disk.iso'
vuid='9770f5913f4042ad9d30ea16f93f85e7'
./bin/node-genisoimage -D -V "${vuid}" -no-pad -r -o 'spec/disk.iso' 'spec/disk'
output="$(strings 'spec/disk.iso')"

if [[ "${output}" == *"${vuid}"* ]]; then
	echo 'PASS: spec/disk.iso: Volume UID present'
else
	echo 'FAIL: spec/disk.iso: Volume UID missing'
	errored=1
fi

if [[ "${output}" == *"$(cat 'spec/disk/dir/sub/uid.txt')"* ]]; then
	echo 'PASS: spec/disk.iso: File UID present'
else
	echo 'FAIL: spec/disk.iso: File UID missing'
	errored=1
fi

exit "${errored}"
