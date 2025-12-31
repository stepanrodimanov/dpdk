#!/bin/bash
LOG_FILE="/logs/dpdk_latency_$(date +%Y%m%d_%H%M%S).log"

mkdir -p /dev/hugepages
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 2>/dev/null
mount -t hugetlbfs nodev /dev/hugepages 2>/dev/null

stdbuf -o0 -e0 /opt/dpdk-src/build/examples/dpdk-rxtx_callbacks \
    -l 0 \
    --no-pci \
    --vdev=net_tap0,iface=tap0 \
    --vdev=net_tap1,iface=tap1 \
    2>&1 | tee "$LOG_FILE" &  

DPDK_PID=$!
sleep 3

timeout 20s bash -c '
    while true; do
        arping -I tap0 -c 1 -w 3 10.0.0.2 -q >/dev/null 2>&1
        sleep 0.001
    done
'

kill $DPDK_PID 2>/dev/null
wait $DPDK_PID 2>/dev/null
