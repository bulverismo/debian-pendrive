#!/bin/bash

pasta="$1"
pasta="${pasta:-mnt}"

[ -z "$pasta" ] && echo "informe como argumento um nome de pasta" >&2 && exit 1
[ "$EUID" != "0" ] && echo "deve rodar como sudo" >&2 && exit 2

umount "$pasta/proc"
umount "$pasta/dev"
umount "$pasta/sys"
umount "$pasta/boot/efi"
umount -l "$pasta"

losetup --detach-all
