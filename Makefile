build-laptop:
	cp ./scripts/arch-install-laptop.sh ./archiso/archlaptopiso/airootfs/root/install.sh && sudo mkarchiso -v -r -w /tmp/archiso-tmp -o ./dist ./archiso/archlaptopiso/

run-laptop:
	run_archiso -u -i $(basename ./dist/*)
