#!/usr/bin/env bash
cd $(dirname "$0")
FTPARCHIVE='apt-ftparchive'
for arch in iphoneos-arm darwin-arm64 darwin-amd64; do
    echo $dist $arch
    binary=binary-${arch}
    contents=Contents-${arch}
    mkdir -p ${binary}
    rm -f {Release{,.gpg},${binary}/{Packages{,.xz,.zst},Release{,.gpg}}}

    $FTPARCHIVE --arch ${arch} packages pool > \
            ./${binary}/Packages 2>/dev/null
    xz -c9 ./${binary}/Packages > ./${binary}/Packages.xz
    zstd -q -c19 ./${binary}/Packages > ./${binary}/Packages.zst

    $FTPARCHIVE contents pool > \
        ./${contents}
    xz -c9 ./${contents} > ./${contents}.xz
    zstd -q -c19 ./${contents} > ./${contents}.zst

    $FTPARCHIVE release -c config/${arch}-basic.conf ./${binary} > ./${binary}/Release 2>/dev/null
    $FTPARCHIVE release -c config/zebra.conf . > Release 2>/dev/null
done
