all:
	./gerar_sistema_base.sh

clean:
	./umount.sh
	rm -rf disco* mnt
