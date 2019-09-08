#!/bin/bash
script_full_path=$(dirname "$0")
cd $script_full_path

rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release.gpg Release

apt-ftparchive packages ./debs > Packages
gzip -c9 Packages > Packages.gz
xz -c9 Packages > Packages.xz
zstd -c19 Packages > Packages.zst
echo "Done updating!"
