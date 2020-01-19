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

commit_id="$(git rev-parse HEAD)"
build_number="$1"
build_id="${commit_id}-${build_number}"

cd "${__dir}/.."

echo "TODO: Cache"
echo "build_id: ${build_id}"
