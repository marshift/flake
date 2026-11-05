# NixOS

Despite being written on a Darwin system originally, the flake now debatably has more support for NixOS than nix-darwin.

## Installation

```sh
sudo su
export ROOT_DISK=/dev/disk/by-id/REPLACE_ME
export DATA_DISK=/dev/disk/by-id/REPLACE_ME
wipefs -af $ROOT_DISK
wipefs -af $DATA_DISK
sgdisk -Zo $ROOT_DISK
sgdisk -Zo $DATA_DISK
sgdisk -n3:1M:+1G -t3:EF00 $ROOT_DISK
sgdisk -n2:0:+8G -t2:8200 $ROOT_DISK
sgdisk -n1:0:0 -t1:BF01 $ROOT_DISK
mkfs.vfat ${ROOT_DISK}-part3
mkswap ${ROOT_DISK}-part2
swapon ${ROOT_DISK}-part2
cryptsetup luksFormat ${ROOT_DISK}-part1
cryptsetup open --type luks ${ROOT_DISK}-part1 crypt
zpool create -O mountpoint=none rpool /dev/mapper/crypt
zfs create -o mountpoint=legacy rpool/root
zfs create -o mountpoint=legacy rpool/root/nixos
zfs create -o mountpoint=legacy rpool/home
mount -t zfs rpool/root/nixos /mnt
mkdir /mnt/home
mkdir /mnt/boot
mkdir /mnt/mnt
mount -t zfs rpool/home /mnt/home
mount ${ROOT_DISK}-part3 /mnt/boot
sgdisk -n1:0:0 -t1:BF01 ${DATA_DISK}
cryptsetup luksFormat ${DATA_DISK}-part1 
cryptsetup open --type luks ${DATA_DISK}-part1 datacrypt
zpool create -O mountpoint=none datapool /dev/mapper/datacrypt
zfs create -o mountpoint=legacy datapool/data
mkdir /mnt/mnt/data
mount -t zfs datapool/data /mnt/mnt/data
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/hardware-configuration.nix 
nano /mnt/etc/nixos/configuration.nix 
nmtui
nixos-install
```

## Installation (Asahi Linux)

Follow [the nixos-apple-silicon guide](https://github.com/nix-community/nixos-apple-silicon/blob/main/docs/uefi-standalone.md) until you reach "Partitioning and Formatting". Do the following instead:

```sh
sudo su
export ROOT_DISK=/dev/nvme0n1 # Should never change, but check!
sgdisk -n 0:+8G $ROOT_DISK -s
sgdisk -n 0:0 $ROOT_DISK -s
sgdisk -p $ROOT_DISK # For me, swap was partition 5 and root was partition 6 - again, check!
sgdisk -t5:8200 $ROOT_DISK
sgdisk -t6:EF00 $ROOT_DISK
mkswap ${ROOT_DISK}p5
swapon ${ROOT_DISK}p5
cryptsetup luksFormat ${ROOT_DISK}p6
cryptsetup open --type luks ${ROOT_DISK}p6 crypt
mkfs.btrfs /dev/mapper/crypt
btrfs subvolume create @root
btrfs subvolume create @home
mount -o subvol=@root,compress=zstd,noatime /dev/mapper/crypt /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount -o subvol=@home,compress=zstd,noatime /dev/mapper/crypt /mnt/home
mount /dev/disk/by-partuuid/`cat /proc/device-tree/chosen/asahi,efi-system-partition` /mnt/boot
nixos-generate-config --root /mnt
cp -r /etc/nixos/apple-silicon-support /mnt/etc/nixos
chmod -R +w /mnt/etc/nixos
nano /mnt/etc/nixos/hardware-configuration.nix 
nano /mnt/etc/nixos/configuration.nix # Import the Asahi Linux support module and enable it
nmtui
nixos-install
```
