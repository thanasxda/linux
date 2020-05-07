#!/bin/bash
### INIT.SH USERSPACE PRECONFIGURATION SCRIPT FOR THANAS-X86-64-KERNEL
### THIS FILE WILL BE LOCATED IN ROOT FILESYSTEM "/init.sh"
######################################################################

###### CONFIGURE SCHEDULER

### configure paths for scheduler
#$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
sd=sd*
nvme=nvme*

#### FOR SD*
### currently [none], [kyber], [bfq], [mq-deadline]
echo "none" > /sys/block/$sd/queue/scheduler
### if scheduler is set underneath options can configure it
echo "0" > /sys/block/$sd/queue/add_random
echo "0" > /sys/block/$sd/queue/iostats
echo "0" > /sys/block/$sd/queue/io_poll
echo "0" > /sys/block/$sd/queue/nomerges
echo "2048" > /sys/block/$sd/queue/nr_requests
echo "2048" > /sys/block/$sd/queue/read_ahead_kb
echo "0" > /sys/block/$sd/queue/rotational
echo "1" > /sys/block/$sd/queue/rq_affinity
echo "write through" > /sys/block/$sd/queue/write_cache
echo "4" > /sys/block/$sd/queue/iosched/quantum
echo "80" > /sys/block/$sd/queue/iosched/fifo_expire_sync
echo "330" > /sys/block/$sd/queue/iosched/fifo_expire_async
echo "12582912" > /sys/block/$sd/queue/iosched/back_seek_max
echo "1" > /sys/block/$sd/queue/iosched/back_seek_penalty
echo "60" > /sys/block/$sd/queue/iosched/slice_sync
echo "50" > /sys/block/$sd/queue/iosched/slice_async
echo "2" > /sys/block/$sd/queue/iosched/slice_async_rq
echo "0" > /sys/block/$sd/queue/iosched/slice_idle
echo "0" > /sys/block/$sd/queue/iosched/group_idle
echo "1" > /sys/block/$sd/queue/iosched/low_latency
echo "150" > /sys/block/$sd/queue/iosched/target_latency

#### FOR NVME*
### currently [none], [kyber], [bfq], [mq-deadline]
echo "none" > /sys/block/$nvme/queue/scheduler
### if scheduler is set underneath options can configure it
echo "0" > /sys/block/$nvme/queue/add_random
echo "0" > /sys/block/$nvme/queue/iostats
echo "0" > /sys/block/$nvme/queue/io_poll
echo "0" > /sys/block/$nvme/queue/nomerges
echo "2048" > /sys/block/$nvme/queue/nr_requests
echo "2048" > /sys/block/$nvme/queue/read_ahead_kb
echo "0" > /sys/block/$nvme/queue/rotational
echo "1" > /sys/block/$nvme/queue/rq_affinity
echo "write through" > /sys/block/$nvme/queue/write_cache
echo "4" > /sys/block/$nvme/queue/iosched/quantum
echo "80" > /sys/block/$nvme/queue/iosched/fifo_expire_sync
echo "330" > /sys/block/$nvme/queue/iosched/fifo_expire_async
echo "12582912" > /sys/block/$nvme/queue/iosched/back_seek_max
echo "1" > /sys/block/$nvme/queue/iosched/back_seek_penalty
echo "60" > /sys/block/$nvme/queue/iosched/slice_sync
echo "50" > /sys/block/$nvme/queue/iosched/slice_async
echo "2" > /sys/block/$nvme/queue/iosched/slice_async_rq
echo "0" > /sys/block/$nvme/queue/iosched/slice_idle
echo "0" > /sys/block/$nvme/queue/iosched/group_idle
echo "1" > /sys/block/$nvme/queue/iosched/low_latency
echo "150" > /sys/block/$nvme/queue/iosched/target_latency

###### END
