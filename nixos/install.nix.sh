#!/bin/sh

lsblk

read -p "Enter nixos installation target disk: " target

cfdisk /dev/$target

echo "Partition..."

echo "Partition gpt table"
parted /dev/$target -- mklabel gpt

echo "Main partiton"
parted /dev/$target -- mkpart primary 512MB -8GB

echo "Swap partition"
parted /dev/$target -- mkpart primary linux-swap -8GB 100%

echo "UEFI partition"
parted /dev/$target -- mkpart ESP fat32 1MB 512MB
parted /dev/$target -- set 3 esp on

echo "Formating..."

echo "Formating main partition"
mkfs.ext4 -L nixos /dev/${target}p1

echo "Formating swap partition"
mkswap -L swap /dev/${target}p2
swapon /dev/${target}p2

echo "Formating UEFI partition"
mkfs.fat -F 32 -n boot /dev/${target}p3

echo "Mounting..."

echo "Mounting /mnt"
mount /dev/disk/by-label/nixos /mnt

echo "Mounting /mnt/boot"
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

echo "Generate nixos system configuration"
nixos-generate-config --root /mnt

echo "install nixos using domestic substituters"
nixos-install --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org"
