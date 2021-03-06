{ pkgs }:

pkgs.writeScript "sd-fuse" ''
  echo "writing to $1"
  dd if=${pkgs.pkgsCross.aarch64-multiplatform.ubootSapphire}/idbloader.img of=$1 conv=fsync,notrunc bs=512 seek=64
  dd if=${pkgs.pkgsCross.aarch64-multiplatform.ubootSapphire}/u-boot.itb of=$1 conv=fsync,notrunc bs=512 seek=16384
''
