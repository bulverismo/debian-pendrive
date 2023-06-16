## Criar pendrive bootavel com Debian automaticamente

Isso que está sendo gerado aqui se diferencia da versão live-cd oficial do debian por que ela tem armazenamento permanente e por que você pode utilizar isso como base para personalizar uma imagem debian sua, seja pra ficar utilizavel por um pendrive ou por ssd.

##### Como gerar a imagem:
```
sudo make
```
Precisa do sudo por que usa chroot e dispositivos de loopback

##### Como gravar a imagem no pendrive:
```
sudo ./flash-me-or-die.sh /dev/seu-pendrive
```

#### Dica para achar qual o seu pendrive:
```
# O comando lsblk é capaz de exibir dentre outras coisas os seus pendrives
# que estão conectados ao seu computador
lsblk
# a saído do comando terá a mesma estrutura que esse exemplo:

NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sdb      8:16   1  28.9G  0 disk 
├─sdb1   8:17   1     1M  0 part 
├─sdb2   8:18   1    50M  0 part 
└─sdb3   8:19   1   9.9G  0 part 

# neste exemplo vemos um pendrive com 29.9G que está acessivel pelo caminho
# /dev/sdb, e ele tem 3 partições: sdb1, sdb2 e sdb3 
# logo o caminho para o meu pendrive é /dev/sdb
```

#### Informações sobre o que faz cada arquivo

Arquivo principal é gerar_sistema_base.sh, nele você pode dar uma entendida geral em como isso funciona e também modificar o processo, este arquivo rodou com sucesso numa maquina debian bookworm, se você for rodar através de outra distribuição gnu/linux saiba que não foi testado.

No arquivo instalar_pacotes.sh você tem os comandos que rodam dentro do sistema destino, aqui você pode adicionar ou remover pacotes.

Os arquivos mount.sh e umount.sh são auxiliares para ajudar a montar de desmontar os dispositivos virtuais usados durante o processo de criação da imagem.

O arquivo tabela-de-partição usa sintaxe que o programa sfdisk consegue entender pra criar a tabela de partição que será utilizada no dispositivo virtual durante o processo.

O arquivo flash-me-or-die.sh é utilizado para gravar a imagem gerada em um pendrive.

#### Sugestão:

Para entender o que acontece sugiro que olhe as referencias utilizadas e você também  pode olhar o man de cada pacote utilizado. :)

Baseado em:

[Professor Kretcheu pendrive.grub](https://salsa.debian.org/kretcheu/tutoriais/-/blob/master/pendrive.grub.md)

[Curso GNU Linux - Tutorial 04 - Debian no Pendrive](https://www.youtube.com/watch?v=eZtK1cFHvcQ)
