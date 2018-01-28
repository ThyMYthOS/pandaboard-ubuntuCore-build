CPUS := $(shell getconf _NPROCESSORS_ONLN)

OUTPUT_DIR := $(PWD)
SCRIPT_DIR := $(OUTPUT_DIR)/scripts
TOOLS_DIR := $(OUTPUT_DIR)/tools
PRELOAD_DIR := $(OUTPUT_DIR)/preloader
GADGET_DIR := $(OUTPUT_DIR)/gadget
GADGET_VERSION := `grep version $(GADGET_DIR)/meta/snap.yaml | awk '{print $$2}'`

# VENDOR: toolchain from BSP ; DEB: toolchain from deb
TOOLCHAIN := DEB

ARCH := arm
KERNEL_DTS := omap4-panda
UBOOT_DEFCONFIG := omap4_panda_defconfig

KERNEL_BUILD := $(PWD)/kernel

UBOOT_REPO := git://git.denx.de/u-boot.git
UBOOT_BRANCH := v2017.01
UBOOT_SRC := $(PWD)/u-boot
UBOOT_OUT := $(PWD)/u-boot-build
UBOOT_BIN := $(UBOOT_OUT)/u-boot-dtb.img
UBOOT_MLO := $(UBOOT_OUT)/MLO

ifeq ($(TOOLCHAIN),VENDOR)
CC :=
else
CC := arm-linux-gnueabihf-
endif
