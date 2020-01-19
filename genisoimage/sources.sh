#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

cdrkit_dir='cdrkit'
cdrkit_repo='https://github.com/Distrotech/cdrkit.git'
cdrkit_tag='distrotech-cdrkit-1.1.11'
patch_dir='patch'
patch_file='patch.diff'

cdrkit_dir_abs="${__dir}/${cdrkit_dir}"
patch_dir_abs="${__dir}/${patch_dir}"
patch_file_abs="${patch_dir_abs}/${patch_file}"

rm -rf "${cdrkit_dir_abs}"
mkdir -p "${cdrkit_dir_abs}"

git clone --depth 1 --branch "${cdrkit_tag}" \
	"${cdrkit_repo}" "${cdrkit_dir_abs}"

rm -rf "${cdrkit_dir_abs}.git"

patch -d "${cdrkit_dir_abs}" -p1 < "${patch_file_abs}"
