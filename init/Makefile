# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the linux kernel.
#

subdir-ccflags-y := -O3 -ffast-math -fforce-addr --param=ssp-buffer-size=32 -D_FORTIFY_SOURCE=2 -D_REENTRANT -fassociative-math -fasynchronous-unwind-tables -feliminate-unused-debug-types -fexceptions -fno-semantic-interposition \
-fno-signed-zeros -fno-strict-aliasing -fno-trapping-math -ldl -lhmmer -lm -lncurses -lpthread -lsquid -m64 -pthread -Wall -Wformat-security -Wl-sort-common -Wl-z -Wp -mcpu=native -g -Wp-D_REENTRANT -fno-stack-protector \
-fwrapv -lpgcommon -lpgport -lpq -lrt -lcrypt -mtune=native -march=native -fomit-frame-pointer -pipe -Wno-error -funroll-loops -ftree-vectorize -Wno-frame-address -Wno-maybe-uninitialized -fopenmp -Wno-uninitialized  -mabi=native -mfpu=native -mfloat-abi=native \



ccflags-y := -fno-function-sections -fno-data-sections

obj-y                          := main.o version.o mounts.o
ifneq ($(CONFIG_BLK_DEV_INITRD),y)
obj-y                          += noinitramfs.o
else
obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
endif
obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o

obj-y                          += init_task.o

mounts-y			:= do_mounts.o
mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
mounts-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o

# dependencies on generated files need to be listed explicitly
$(obj)/version.o: include/generated/compile.h

# compile.h changes depending on hostname, generation number, etc,
# so we regenerate it always.
# mkcompile_h will make sure to only update the
# actual file if its content has changed.

       chk_compile.h = :
 quiet_chk_compile.h = echo '  CHK     $@'
silent_chk_compile.h = :
include/generated/compile.h: FORCE
	@$($(quiet)chk_compile.h)
	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"	\
	"$(CONFIG_PREEMPT_RT)" "$(CC)" "$(LD)"
