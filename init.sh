#!/bin/bash
######################################################################
### INIT.SH USERSPACE PRECONFIGURATION SCRIPT FOR THANAS-X86-64-KERNEL
### THIS FILE WILL BE LOCATED IN ROOT FILESYSTEM "/init.sh"
### script triggered by crontab @reboot with SU rights
######################################################################
###    by thanasxda - 15927885+thanasxda@users.noreply.github.com
######################################################################
#################### https://github.com/thanasxda ####################
######################################################################

#### add delay prior to application
sleep 30

###### CONFIGURE SCHEDULER
################################
### configure paths for scheduler
#$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
sd=sd*
nvme=nvme*

#### FOR SD*
################################
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
################################
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

###### FILESYSTEM
################################
echo "0" > /proc/sys/fs/dir-notify-enable
echo "20" > /proc/sys/fs/lease-break-time
echo "1" > /proc/sys/vm/compact_unevictable_allowed
echo "15" > /proc/sys/vm/dirty_background_ratio
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "60" > /proc/sys/vm/dirty_ratio
echo "3000" > /proc/sys/vm/dirty_writeback_centisecs
echo "1" > /proc/sys/vm/oom_dump_tasks
echo "1" > /proc/sys/vm/oom_kill_allocating_task
echo "1200" > /proc/sys/vm/stat_interval
echo "10" > /proc/sys/vm/vfs_cache_pressure
echo "90" > /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=90

###### CPU
################################
### governor
function setgov ()
{
    echo "performance" | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
}
### workqueues
sudo chmod 666 /sys/module/workqueue/parameters/power_efficient
sudo chown root /sys/module/workqueue/parameters/power_efficient
sudo bash -c 'echo "N"  > /sys/module/workqueue/parameters/power_efficient'

###### EXTRAS
################################
### kernel panic
sysctl -e -w kernel.panic_on_oops=0
sysctl -e -w kernel.panic=0
### rcu
echo "0" > /sys/kernel/rcu_expedited
echo "1" > /sys/kernel/rcu_normal
### entropy
echo "96" > /proc/sys/kernel/random/urandom_min_reseed_secs
echo "1024" > /proc/sys/kernel/random/write_wakeup_threshold
### hibernation
echo "deep" > /sys/power/mem_sleep
### extras
echo "Y" > /sys/module/cryptomgr/parameters/notests
echo "1" > /sys/module/hid/parameters/ignore_special_drivers
echo "N" > /sys/module/drm_kms_helper/parameters/poll
echo "N" > /sys/module/printk/parameters/always_kmsg_dump

###### TCP SETTINGS
################################
echo "128" > /proc/sys/net/core/netdev_max_backlog
echo "0" > /proc/sys/net/core/netdev_tstamp_prequeue
echo "0" > /proc/sys/net/ipv4/cipso_cache_bucket_size
echo "0" > /proc/sys/net/ipv4/cipso_cache_enable
echo "0" > /proc/sys/net/ipv4/cipso_rbm_strictvalid
echo "0" > /proc/sys/net/ipv4/igmp_link_local_mcast_reports
echo "24" > /proc/sys/net/ipv4/ipfrag_time
echo "bbr" > /proc/sys/net/ipv4/tcp_congestion_control
echo "1" > /proc/sys/net/ipv4/tcp_ecn
echo "0" > /proc/sys/net/ipv4/tcp_fwmark_accept
echo "320" > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo "21600" > /proc/sys/net/ipv4/tcp_keepalive_time
echo "1800" > /proc/sys/net/ipv4/tcp_probe_interval
echo "1" > /proc/sys/net/ipv4/tcp_no_metrics_save
echo "0" > /proc/sys/net/ipv4/tcp_slow_start_after_idle
echo "0" > /proc/sys/net/ipv6/calipso_cache_bucket_size
echo "0" > /proc/sys/net/ipv6/calipso_cache_enable
echo "48" > /proc/sys/net/ipv6/ip6frag_time

echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_rfc1337
echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_window_scaling
echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_workaround_signed_windows
echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_sack
echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_fack
echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_low_latency
echo "0" > /proc/sys/net/ipv4/net.ipv4.ip_no_pmtu_disc
echo "1" > /proc/sys/net/ipv4/net.ipv4.tcp_mtu_probing
echo "2" > /proc/sys/net/ipv4/net.ipv4.tcp_frto
echo "2" > /proc/sys/net/ipv4/net.ipv4.tcp_frto_response

for i in $(find /sys/class/net -type l); do
  echo "128" > $i/tx_queue_len;
done;

###### OMIT DEBUGGING
################################
echo "0" > /proc/sys/debug/exception-trace
echo "0 0 0 0" > /proc/sys/kernel/printk

echo "Y" > /sys/module/printk/parameters/console_suspend

for i in $(find /sys/ -name debug_mask); do
echo "0" > $i;
done
for i in $(find /sys/ -name debug_level); do
echo "0" > $i;
done
for i in $(find /sys/ -name edac_mc_log_ce); do
echo "0" > $i;
done
for i in $(find /sys/ -name edac_mc_log_ue); do
echo "0" > $i;
done
for i in $(find /sys/ -name enable_event_log); do
echo "0" > $i;
done
for i in $(find /sys/ -name log_ecn_error); do
echo "0" > $i;
done
for i in $(find /sys/ -name snapshot_crashdumper); do
echo "0" > $i;
done
if [ -e /sys/module/logger/parameters/log_mode ]; then
 echo "2" > /sys/module/logger/parameters/log_mode
fi;

###### SCHEDULE FSTRIM ONCE WEEKLY
################################
### rerunning this same command will not trigger reset in timer
sudo systemctl start fstrim.timer

###### END
