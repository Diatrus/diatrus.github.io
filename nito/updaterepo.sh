#!/bin/bash
script_full_path=$(dirname "$0")
cd $script_full_path

rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release.gpg Release

apt-ftparchive packages ./debs > Packages
gzip -c9 Packages > Packages.gz
xz -c9 Packages > Packages.xz
zstd -c19 Packages > Packages.zst
bzip2 -c9 Packages > Packages.bz2

apt-ftparchive release -c ./configs/nito.conf . > Release

gpg -abs --default-key A62E24F587D7497DA677036D2948E440D73080B4 -o Release.gpg Release

echo "Done updating!"
