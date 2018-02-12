include common.mk

GADGET_UBOOT_MLO := $(GADGET_DIR)/boot-assets/MLO
GADGET_UBOOT_BIN := $(GADGET_DIR)/boot-assets/u-boot.img
GADGET_SNAP := $(OUTPUT_DIR)/pandaboard_$(GADGET_VERSION)*.snap

# for preloader packaging
ifneq "$(findstring ARM, $(shell grep -m 1 'model name.*: ARM' /proc/cpuinfo))" ""
BOOTLOADER_PACK=bootloader_pack.arm
else
BOOTLOADER_PACK=bootloader_pack
endif

all: build

clean:
	rm -rf $(GADGET_DIR)/boot-assets
	rm -f $(GADGET_DIR)/uboot.conf
	rm -f $(GADGET_DIR)/uboot.env
	rm -f $(GADGET_SNAP)

distclean: clean

u-boot:
	@if [ ! -d $(GADGET_DIR)/boot-assets ] ; then mkdir $(GADGET_DIR)/boot-assets; fi
	@if [ ! -f $(UBOOT_BIN) ] ; then echo "Build u-boot first."; exit 1; fi
	cp -f $(UBOOT_MLO) $(GADGET_UBOOT_MLO)
	cp -f $(UBOOT_BIN) $(GADGET_UBOOT_BIN)

preload: u-boot
	mkenvimage -r -s 131072  -o $(GADGET_DIR)/uboot.env $(GADGET_DIR)/uboot.env.in
	@if [ ! -f $(GADGET_DIR)/uboot.conf ]; then ln -s uboot.env $(GADGET_DIR)/uboot.conf; fi

snappy: preload
	snapcraft snap gadget

build: u-boot preload snappy

.PHONY: u-boot snappy gadget build preload
