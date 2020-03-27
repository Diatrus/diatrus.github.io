#!/bin/bash
script_full_path=$(dirname "$0")
cd $script_full_path

rm Packages Packages.zst Release

apt-ftparchive packages ./debs > Packages
zstd -c19 Packages > Packages.zst

apt-ftparchive release -c ./configs/new.conf . > Release

echo "Done updating!"
