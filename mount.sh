#!/bin/bash


set -ex

arquivo="$1"
pasta="$2"

pasta="${pasta:-mnt}"

#chrootar=${3:-OFF}
[ -z "$arquivo" ] && echo "informe como primeiro argumento um arquivo" >&2 && exit 1
[ -z "$pasta" ] && echo "informe como segundo argumento um nome de pasta" >&2 && exit 2
[ "$EUID" != "0" ] && echo "deve rodar como sudo" >&2 && exit 3

dispositivo_virtual="$(losetup -f)"

losetup "${dispositivo_virtual}" "$arquivo"

sudo partprobe $dispositivo_virtual

mount ${dispositivo_virtual}p3 "$pasta"

partprobe ${dispositivo_virtual} 

mkdir -p "$pasta/boot/efi"
mount ${dispositivo_virtual}p2 "$pasta/boot/efi"

mount --bind /proc "$pasta/proc"
mount --bind /dev "$pasta/dev"
mount --bind /sys "$pasta/sys"

partprobe ${dispositivo_virtual} 
echo APÓS MONTADO::::::
lsblk
#chroot "$pasta"
