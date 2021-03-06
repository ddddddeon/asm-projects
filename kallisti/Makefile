arch ?= x86_64
kernel := build/kernel-$(arch).bin
iso := build/os-$(arch).iso

linker_script = src/linker.ld
grub_cfg := src/grub.cfg
assembly_source_files := $(wildcard src/*.asm)
assembly_object_files := $(patsubst src/%.asm, \
	build/%.o, $(assembly_source_files))

.PHONY: all clean run iso usb

all: $(iso)

clean: 
	@rm -r build

run: $(iso)
	@qemu-system-x86_64 -drive format=raw,file=$(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/kernel.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
	@rm -r build/isofiles
$(kernel): $(assembly_object_files) $(linker_script)
	@ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files)

build/%.o: src/%.asm
	@mkdir -p $(shell dirname $@)
	@nasm -felf64 $< -o $@

usb:
	@sudo umount /dev/sdb1 >/dev/null 2>&1 || true;
	@sudo dd if=$(iso) of=/dev/sdb
