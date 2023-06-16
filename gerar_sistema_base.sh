#!/bin/bash

set -e
arquivo="$1"
pasta_temporaria="$2"
script_instalacao_de_pacotes="$3"

arquivo="${arquivo:-disco}"
pasta_temporaria="${pasta_temporaria:-mnt}"
script_instalacao_de_pacotes="${script_instalacao_de_pacotes:-instalar_pacotes.sh}"

numero_particao_efi=2
numero_particao_sistema=3

[[ -d "$pasta_temporaria" ]] || mkdir -p "$pasta_temporaria"

truncate -s 10G $arquivo 

dispositivo_virtual="$(losetup -f)"

echo "$arquivo" | ./saida_colorida.sh arquivo 4
echo "$pasta_temporaria" | ./saida_colorida.sh pasta_temporaria 5
echo "$dispositivo_virtual" | ./saida_colorida.sh dispositivo_virtual 6

losetup "$dispositivo_virtual" "$arquivo"

sfdisk "$dispositivo_virtual" < tabela-de-partição |& ./saida_colorida.sh "tabela de partições" 3  
partprobe "$dispositivo_virtual"

lsblk -o name,mountpoint $dispositivo_virtual |& ./saida_colorida.sh "Partições" 7 

# formatar partição do efi
mkfs.vfat ${dispositivo_virtual}p${numero_particao_efi} |& ./saida_colorida.sh "mkfs.vfat" 6

yes | grml-debootstrap \
    --release bookworm \
    --target ${dispositivo_virtual}p${numero_particao_sistema} \
    --efi ${dispositivo_virtual}p${numero_particao_efi} \
    --grub ${dispositivo_virtual} \
    --hostname sys1 \
    --password sys1 |& ./saida_colorida.sh debootstrap 2

echo "umount -l /mnt/*"
umount -l /mnt/* |& ./saida_colorida.sh "umount" 1 

echo "losetup --detach-all"
losetup --detach-all |& ./saida_colorida.sh "detach all" 4 

echo "./mount.sh $arquivo $pasta_temporaria"
./mount.sh $arquivo "$pasta_temporaria" |& ./saida_colorida.sh "mount" 2

lsblk -o name,mountpoint |& ./saida_colorida.sh "Pastas montadas" 3 

cp $script_instalacao_de_pacotes "$pasta_temporaria"

chroot "$pasta_temporaria" "/$script_instalacao_de_pacotes" "${dispositivo_virtual}"

./umount.sh $pasta_temporaria

echo "Processo de geração finalizado, você pode gravar o arquivo gerado: >>> $arquivo <<< no pendrive ou outro lugar que quiser através do script flash-me-or-die.sh"
