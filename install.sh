ping -c 1 google.com;
timedatectl set-ntp true;
echo fdisk -l;

cfdisk /dev/nvme0n1
create 550M
create 1000G

cfdisk /dev/nvme3n1 # assuming this is the 256G
create 128



sudo mdadm --misc --zero-superblock /dev/nvme1n1
sudo mdadm --misc --zero-superblock /dev/nvme2n1
sudo dd if=/dev/zero of=/dev/nvme1n1
sudo dd if=/dev/zero of=/dev/nvme2n1


sudo mdadm --create --verbose --level=0 --metadata=1.2 --chunk=128 --raid-devices=2 /dev/md0 /dev/nvme1n1 /dev/nvme2n1
sudo mdadm --detail --scan >> /etc/mdadm.conf

lvmdiskscan

pvcreate /dev/nvme0n1
pvcreate /dev/md0
pvcreate /dev/sda
pvcreate /dev/nvme3n1
pvcreate /dev/nvme4n1

vgcreate vg_main /dev/nvme0n1
vgcreate vg_home /dev/md0
vgcreate vg_
