#/bin/bash -xe

systemctl stop pvestatd.service
systemctl stop pvedaemon.service
systemctl stop pve-cluster.service
systemctl stop corosync
systemctl stop pve-cluster

sqlite3 /var/lib/pve-cluster/config.db "delete from tree where name = 'corosync.conf';"

pmxcfs -l
rm -rf /etc/pve/corosync.conf
rm -rf /etc/corosync/*
rm -rf /var/lib/corosync/*
cp /etc/pve/qemu-server/*.conf /root
rm -rf /etc/pve/nodes/*
mv /root/*.conf /etc/pve/qemu-server/
pkill -9 pmxcfs

systemctl start pve-cluster
systemctl start corosync
systemctl start pve-cluster.service
systemctl start pvedaemon.service
systemctl start pvestatd.service
