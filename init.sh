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
sleep 10

systemctl start firewalld


#### extras
echo 1 > /proc/sys/vm/overcommit_memory
/etc/init.d/irqbalance start
echo fq_codel > /proc/sys/net/core/default_qdisc
#sysctl net.ipv4.tcp_fastopen=3
#sysctl net.core.busy_read=50
sysctl net.ipv4.tcp_slow_start_after_idle=0

echo "1" /proc/sys/fs/leases-enable
echo "0" > /proc/sys/fs/dir-notify-enable
echo "20" > /proc/sys/fs/lease-break-time
echo "1" > /proc/sys/vm/overcommit_memory

sudo echo always > /sys/kernel/mm/transparent_hugepage/enabled
sudo echo always > /sys/kernel/mm/transparent_hugepage/defrag

sysctl -w kernel.sched_scaling_enable=1
sysctl sched_scaling_enable=1
sysctl sched_tunable_scaling=2
sysctl /proc/sys/kernel/sched_child_runs_first=1
sysctl /proc/sys/kernel/sched_min_granularity_ns=1000000
sysctl /proc/sys/kernel/sched_wakeup_granularity_ns=2000000
sysctl /proc/sys/kernel/sched_latency_ns=40000

sudo apparmor_parser -r /etc/apparmor.d/*snap-confine*
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap-confine*
systemctl enable --now apparmor.service

###### CONFIGURE SCHEDULER
################################
### currently [none], [kyber], [bfq], [mq-deadline]
#$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
for i in $(find /sys/block -type l); do
  echo "none" > $i/queue/scheduler;
  echo "0" > $i/queue/add_random;
  echo "0" > $i/queue/iostats;
  echo "0" > $i/queue/io_poll
  echo "2" > $i/queue/nomerges
  echo "512" > $i/queue/nr_requests
  echo "4096" > $i/queue/read_ahead_kb
  echo "0" > $i/queue/rotational
  echo "2" > $i/queue/rq_affinity
  echo "write through" > $i/queue/write_cache
  echo "4" > $i/queue/iosched/quantum
  echo "80" > $i/queue/iosched/fifo_expire_sync
  echo "330" > $i/queue/iosched/fifo_expire_async
  echo "12582912" > $i/queue/iosched/back_seek_max
  echo "1" > $i/queue/iosched/back_seek_penalty
  echo "60" > $i/queue/iosched/slice_sync
  echo "50" > $i/queue/iosched/slice_async
  echo "2" > $i/queue/iosched/slice_async_rq
  echo "0" > $i/queue/iosched/slice_idle
  echo "0" > $i/queue/iosched/group_idle
  echo "1" > $i/queue/iosched/low_latency
  echo "150" > $i/queue/iosched/target_latency
done;

echo "write through" | sudo tee /sys/block/*/queue/write_cache

###### FILESYSTEM
################################
echo "0" > /proc/sys/fs/dir-notify-enable
echo "20" > /proc/sys/fs/lease-break-time
echo "1" > /proc/sys/vm/compact_unevictable_allowed
echo "5" > /proc/sys/vm/dirty_background_ratio
echo "12000" > /proc/sys/vm/dirty_expire_centisecs
echo "80" > /proc/sys/vm/dirty_ratio
echo "3000" > /proc/sys/vm/dirty_writeback_centisecs
echo "1" > /proc/sys/vm/oom_dump_tasks
echo "1" > /proc/sys/vm/oom_kill_allocating_task
echo "1200" > /proc/sys/vm/stat_interval
echo "10" > /proc/sys/vm/vfs_cache_pressure
echo "90" > /proc/sys/vm/swappiness
sysctl vm.swappiness=90
sysctl vm.dirty_ratio=80
sysctl vm.dirty_background_ratio=5
sysctl vm.dirty_expire_centisecs=12000
sysctl vm.watermark_scale_factor=200
### IMPROVE SYSTEM MEMORY MANAGEMENT ###
# Increase size of file handles and inode cache
sysctl fs.file-max=2097152
### GENERAL NETWORK SECURITY OPTIONS ###
# Number of times SYNACKs for passive TCP connection.
#sysctl net.ipv4.tcp_synack_retries=2
# Allowed local port range
sysctl net.ipv4.ip_local_port_range=2000 65535
# Protect Against TCP Time-Wait
#sysctl net.ipv4.tcp_rfc1337=1
# Decrease the time default value for tcp_fin_timeout connection
sysctl net.ipv4.tcp_fin_timeout=15
# Decrease the time default value for connections to keep alive
sysctl net.ipv4.tcp_keepalive_time=300
sysctl net.ipv4.tcp_keepalive_probes=5
sysctl net.ipv4.tcp_keepalive_intvl=15
### TUNING NETWORK PERFORMANCE ###
# Default Socket Receive Buffer
#sysctl net.core.rmem_default=31457280
# Maximum Socket Receive Buffer
#sysctl net.core.rmem_max=12582912
# Default Socket Send Buffer
#sysctl net.core.wmem_default=31457280
# Maximum Socket Send Buffer
#sysctl net.core.wmem_max=12582912
# Increase number of incoming connections
#sysctl net.core.somaxconn=4096
# Increase number of incoming connections backlog
#sysctl net.core.netdev_max_backlog=65536
# Increase the maximum amount of option memory buffers
#sysctl net.core.optmem_max=25165824
# Increase the maximum total buffer-space allocatable
# This is measured in units of pages (4096 bytes)
#sysctl net.ipv4.tcp_mem=65536 131072 262144
#sysctl net.ipv4.udp_mem=65536 131072 262144
# Increase the read-buffer space allocatable
#sysctl net.ipv4.tcp_rmem=8192 87380 16777216
#sysctl net.ipv4.udp_rmem_min=16384
# Increase the write-buffer-space allocatable
#sysctl net.ipv4.tcp_wmem=8192 65536 16777216
#sysctl net.ipv4.udp_wmem_min=16384
# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks
#sysctl net.ipv4.tcp_max_tw_buckets=1440000
#sysctl net.ipv4.tcp_tw_recycle=1
#sysctl net.ipv4.tcp_tw_reuse=1

sysctl fs.xfs.xfssyncd_centisecs=10000

###### CPU
################################
### governor
function setgov ()
{
    echo "performance" | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
}
### workqueues
chmod 666 /sys/module/workqueue/parameters/power_efficient
chown root /sys/module/workqueue/parameters/power_efficient
bash -c 'echo "N"  > /sys/module/workqueue/parameters/power_efficient'

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

sysctl net.core.somaxconn=1000
sysctl net.core.netdev_max_backlog=5000
sysctl net.core.rmem_max=16777216
sysctl net.core.wmem_max=16777216
sysctl net.ipv4.tcp_wmem=4096 12582912 16777216
sysctl net.ipv4.tcp_rmem=4096 12582912 16777216
sysctl net.ipv4.tcp_max_syn_backlog=8096
sysctl net.ipv4.tcp_slow_start_after_idle=0
sysctl net.ipv4.tcp_tw_reuse=1
sysctl net.ipv4.ip_local_port_range=10240 65535

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

wl -i eth0 interference 3
wl -i eth1 interference 3
wl -i eth2 interference 3
ifconfig eth0 txqueuelen 2
ifconfig eth1 txqueuelen 2
ifconfig eth2 txqueuelen 2
echo 262144 > /proc/sys/net/core/rmem_max
echo 262144 > /proc/sys/net/core/wmem_max
echo "4096 16384 262144" > /proc/sys/net/ipv4/tcp_wmem
echo "4096 87380 262144" > /proc/sys/net/ipv4/tcp_rmem
echo 1000 > /proc/sys/net/core/netdev_max_backlog
echo 16384 > /proc/sys/net/ipv4/netfilter/ip_conntrack_max
echo 16384 > /sys/module/nf_conntrack/parameters/hashsize

###### SCHEDULE FSTRIM ONCE WEEKLY
################################
### rerunning this same command will not trigger reset in timer
systemctl start fstrim.timer

###### END
