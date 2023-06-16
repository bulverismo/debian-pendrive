#!/bin/bash

dispositivo_virtual="$1"

mount -t efivarfs efivarfs /sys/firmware/efi/efivars

DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    bash-completion \
    network-manager \
    shim-signed \
    console-setup 

grub-install --target=i386-pc --recheck ${dispositivo_virtual}
mkdir -p /boot/efi/EFI/BOOT

cp /boot/efi/EFI/debian/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI

chmod -x /etc/grub.d/30_os-prober
update-grub

#grub-install

echo e agora josé?
