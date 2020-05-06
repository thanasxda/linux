#!/bin/bash
#$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
sda=sda
nvme=nvme0n1
echo "bfq" > /sys/block/$sda/queue/scheduler
echo "0" > /sys/block/$sda/queue/add_random
echo "0" > /sys/block/$sda/queue/iostats
echo "0" > /sys/block/$sda/queue/io_poll
echo "0" > /sys/block/$sda/queue/nomerges
echo "2048" > /sys/block/$sda/queue/nr_requests
echo "2048" > /sys/block/$sda/queue/read_ahead_kb
echo "0" > /sys/block/$sda/queue/rotational
echo "1" > /sys/block/$sda/queue/rq_affinity
echo "write through" > /sys/block/$sda/queue/write_cache
echo 4 > /sys/block/$sda/queue/iosched/quantum
echo 80 > /sys/block/$sda/queue/iosched/fifo_expire_sync
echo 330 > /sys/block/$sda/queue/iosched/fifo_expire_async
echo 12582912 > /sys/block/$sda/queue/iosched/back_seek_max
echo 1 > /sys/block/$sda/queue/iosched/back_seek_penalty
echo 60 > /sys/block/$sda/queue/iosched/slice_sync
echo 50 > /sys/block/$sda/queue/iosched/slice_async
echo 2 > /sys/block/$sda/queue/iosched/slice_async_rq
echo 0 > /sys/block/$sda/queue/iosched/slice_idle
echo 0 > /sys/block/$sda/queue/iosched/group_idle
echo 1 > /sys/block/$sda/queue/iosched/low_latency
echo 150 > /sys/block/$sda/queue/iosched/target_latency

echo "bfq" > /sys/block/$nvme/queue/scheduler
echo "0" > /sys/block/$nvme/queue/add_random
echo "0" > /sys/block/$nvme/queue/iostats
echo "0" > /sys/block/$nvme/queue/io_poll
echo "0" > /sys/block/$nvme/queue/nomerges
echo "2048" > /sys/block/$nvme/queue/nr_requests
echo "2048" > /sys/block/$nvme/queue/read_ahead_kb
echo "0" > /sys/block/$nvme/queue/rotational
echo "1" > /sys/block/$nvme/queue/rq_affinity
echo "write through" > /sys/block/$nvme/queue/write_cache
echo 4 > /sys/block/$nvme/queue/iosched/quantum
echo 80 > /sys/block/$nvme/queue/iosched/fifo_expire_sync
echo 330 > /sys/block/$nvme/queue/iosched/fifo_expire_async
echo 12582912 > /sys/block/$nvme/queue/iosched/back_seek_max
echo 1 > /sys/block/$nvme/queue/iosched/back_seek_penalty
echo 60 > /sys/block/$nvme/queue/iosched/slice_sync
echo 50 > /sys/block/$nvme/queue/iosched/slice_async
echo 2 > /sys/block/$nvme/queue/iosched/slice_async_rq
echo 0 > /sys/block/$nvme/queue/iosched/slice_idle
echo 0 > /sys/block/$nvme/queue/iosched/group_idle
echo 1 > /sys/block/$nvme/queue/iosched/low_latency
echo 150 > /sys/block/$nvme/queue/iosched/target_latency
