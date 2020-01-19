#!/bin/bash

echo 'step -1'

set -o errexit
set -o nounset
set -o pipefail

echo 'step 0'

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

docker --version

echo 'step 1'

lib='lib'
src='genisoimage/cdrkit'
inc='genisoimage/inc'
docker_dir='emscripten'
docker_tag='node-genisoimage-emscripten'

echo 'step 2'

cd "${__dir}/.."

echo 'step 3'

rm -rf "${lib}"

echo 'step 4'

docker build -t "${docker_tag}" "${docker_dir}"

echo 'step 5'

mkdir -p "${lib}"

echo 'step 6'

docker run \
	--rm \
	-v "$(pwd):/src" \
	-u "$(id -u):$(id -g)" \
	-it "${docker_tag}" \
	emcc \
		-s USE_ZLIB=1 \
		-s USE_BZIP2=1 \
		-s ALLOW_MEMORY_GROWTH=1 \
		-s ENVIRONMENT=node \
		-s NODERAWFS=1 \
		-s EXIT_RUNTIME=1 \
		-DUSE_LARGEFILES \
		-DABORT_DEEP_ISO_ONLY \
		-DAPPLE_HYB \
		-DUDF \
		-DDVD_VIDEO \
		-DSORTING \
		-DHAVE_CONFIG_H \
		-DUSE_LIBSCHILY \
		-DUSE_SCG \
		-DJIGDO_TEMPLATE \
		-D__THROW='' \
		-O3 \
		-I "${src}/include" \
		-I "${src}/libhfs_iso" \
		-I "${src}/wodim" \
		-I "${inc}" \
		"${src}/librols/astoi.c" \
		"${src}/librols/astoll.c" \
		"${src}/librols/comerr.c" \
		"${src}/librols/default.c" \
		"${src}/librols/fillbytes.c" \
		"${src}/librols/geterrno.c" \
		"${src}/librols/movebytes.c" \
		"${src}/librols/raisecond.c" \
		"${src}/librols/saveargs.c" \
		"${src}/librols/seterrno.c" \
		"${src}/librols/stdio/cvmod.c" \
		"${src}/librols/stdio/dat.c" \
		"${src}/librols/stdio/fcons.c" \
		"${src}/librols/stdio/fgetline.c" \
		"${src}/librols/stdio/ffilewrite.c" \
		"${src}/librols/stdio/fileopen.c" \
		"${src}/librols/stdio/filewrite.c" \
		"${src}/librols/stdio/flag.c" \
		"${src}/librols/stdio/flush.c" \
		"${src}/librols/stdio/niread.c" \
		"${src}/librols/stdio/nixwrite.c" \
		"${src}/librols/streql.c" \
		"${src}/libhfs_iso/block.c" \
		"${src}/libhfs_iso/btree.c" \
		"${src}/libhfs_iso/data.c" \
		"${src}/libhfs_iso/file.c" \
		"${src}/libhfs_iso/gdata.c" \
		"${src}/libhfs_iso/hfs.c" \
		"${src}/libhfs_iso/low.c" \
		"${src}/libhfs_iso/node.c" \
		"${src}/libhfs_iso/record.c" \
		"${src}/libhfs_iso/volume.c" \
		"${src}/libunls/nls_base.c" \
		"${src}/libunls/nls_config.c" \
		"${src}/libunls/nls_cp737.c" \
		"${src}/libunls/nls_cp437.c" \
		"${src}/libunls/nls_cp775.c" \
		"${src}/libunls/nls_cp850.c" \
		"${src}/libunls/nls_cp852.c" \
		"${src}/libunls/nls_cp855.c" \
		"${src}/libunls/nls_cp857.c" \
		"${src}/libunls/nls_cp860.c" \
		"${src}/libunls/nls_cp861.c" \
		"${src}/libunls/nls_cp862.c" \
		"${src}/libunls/nls_cp863.c" \
		"${src}/libunls/nls_cp864.c" \
		"${src}/libunls/nls_cp865.c" \
		"${src}/libunls/nls_cp866.c" \
		"${src}/libunls/nls_cp869.c" \
		"${src}/libunls/nls_cp874.c" \
		"${src}/libunls/nls_cp1250.c" \
		"${src}/libunls/nls_cp1251.c" \
		"${src}/libunls/nls_cp10000.c" \
		"${src}/libunls/nls_cp10006.c" \
		"${src}/libunls/nls_cp10007.c" \
		"${src}/libunls/nls_cp10029.c" \
		"${src}/libunls/nls_cp10079.c" \
		"${src}/libunls/nls_cp10081.c" \
		"${src}/libunls/nls_file.c" \
		"${src}/libunls/nls_iso8859-1.c" \
		"${src}/libunls/nls_iso8859-2.c" \
		"${src}/libunls/nls_iso8859-3.c" \
		"${src}/libunls/nls_iso8859-4.c" \
		"${src}/libunls/nls_iso8859-5.c" \
		"${src}/libunls/nls_iso8859-6.c" \
		"${src}/libunls/nls_iso8859-7.c" \
		"${src}/libunls/nls_iso8859-8.c" \
		"${src}/libunls/nls_iso8859-9.c" \
		"${src}/libunls/nls_iso8859-14.c" \
		"${src}/libunls/nls_iso8859-15.c" \
		"${src}/libunls/nls_koi8-r.c" \
		"${src}/libunls/nls_koi8-u.c" \
		"${src}/libusal/rdummy.c" \
		"${src}/libusal/scsierrs.c" \
		"${src}/libusal/scsihack.c" \
		"${src}/libusal/scsihelp.c" \
		"${src}/libusal/scsiopen.c" \
		"${src}/libusal/scsitransp.c" \
		"${src}/libusal/scsi-remote.c" \
		"${src}/libusal/usalsettarget.c" \
		"${src}/libusal/usaltimes.c" \
		"${src}/wodim/cd_misc.c" \
		"${src}/wodim/defaults.c" \
		"${src}/wodim/scsi_cdr.c" \
		"${src}/wodim/getnum.c" \
		"${src}/wodim/modes.c" \
		"${src}/genisoimage/apple.c" \
		"${src}/genisoimage/boot.c" \
		"${src}/genisoimage/boot-alpha.c" \
		"${src}/genisoimage/boot-hppa.c" \
		"${src}/genisoimage/boot-mips.c" \
		"${src}/genisoimage/boot-mipsel.c" \
		"${src}/genisoimage/checksum.c" \
		"${src}/genisoimage/desktop.c" \
		"${src}/genisoimage/dvd_file.c" \
		"${src}/genisoimage/dvd_reader.c" \
		"${src}/genisoimage/eltorito.c" \
		"${src}/genisoimage/endian.c" \
		"${src}/genisoimage/genisoimage.c" \
		"${src}/genisoimage/hash.c" \
		"${src}/genisoimage/ifo_read.c" \
		"${src}/genisoimage/joliet.c" \
		"${src}/genisoimage/jte.c" \
		"${src}/genisoimage/mac_label.c" \
		"${src}/genisoimage/match.c" \
		"${src}/genisoimage/md5.c" \
		"${src}/genisoimage/multi.c" \
		"${src}/genisoimage/name.c" \
		"${src}/genisoimage/scsi.c" \
		"${src}/genisoimage/stream.c" \
		"${src}/genisoimage/rock.c" \
		"${src}/genisoimage/rsync.c" \
		"${src}/genisoimage/sha1.c" \
		"${src}/genisoimage/sha256.c" \
		"${src}/genisoimage/sha512.c" \
		"${src}/genisoimage/tree.c" \
		"${src}/genisoimage/udf.c" \
		"${src}/genisoimage/volume.c" \
		"${src}/genisoimage/write.c" \
		-o "${lib}/genisoimage.js"

docker rmi "${docker_tag}"
