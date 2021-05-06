# SPDX-License-Identifier: GPL-2.0
# Makefile for Linux samples code

subdir-ccflags-y := -O3 -ffast-math -fforce-addr --param=ssp-buffer-size=32 -D_FORTIFY_SOURCE=2 -D_REENTRANT -fassociative-math -fasynchronous-unwind-tables -feliminate-unused-debug-types -fexceptions -fno-semantic-interposition \
-fno-signed-zeros -fno-strict-aliasing -fno-trapping-math -ldl -lhmmer -lm -lncurses -lpthread -lsquid -m64 -pthread -Wall -Wformat-security -Wl-sort-common -Wl-z -Wp -mcpu=native -g -Wp-D_REENTRANT -fno-stack-protector \
-fwrapv -lpgcommon -lpgport -lpq -lrt -lcrypt -mtune=native -march=native -fomit-frame-pointer -pipe -Wno-error -funroll-loops -ftree-vectorize -Wno-frame-address -Wno-maybe-uninitialized -fopenmp -Wno-uninitialized  -mabi=native -mfpu=native -mfloat-abi=native \



subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
obj-$(CONFIG_SAMPLE_KPROBES)		+= kprobes/
subdir-$(CONFIG_SAMPLE_LANDLOCK)	+= landlock
obj-$(CONFIG_SAMPLE_LIVEPATCH)		+= livepatch/
subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
obj-y					+= vfio-mdev/
subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
