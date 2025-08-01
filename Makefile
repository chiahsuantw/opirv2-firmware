ARCH := riscv
CROSS_COMPILE := riscv64-linux-gnu-

all: uboot genimage

uboot:
	$(MAKE) -C u-boot x1_defconfig
	$(MAKE) -C u-boot ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE}

genimage:
	mkimage -C none -A riscv -T script -d boot.cmd root/boot.scr
	genimage --config genimage-opirv2.cfg --inputpath u-boot --outputpath build

clean:
	$(MAKE) -C u-boot distclean
	rm -rf build root/boot.scr
