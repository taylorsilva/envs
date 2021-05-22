# Jellyfin

## Installation

```
docker-compose up -d
```

If you're restoring from backup make sure the `./config` and `./cache` folders are the in the same directory as the `docker-compose.yml`.

## Enabling Hardware Accerlation

This helps when multiple people are streaming and transcoding at the same time.

Source: https://jellyfin.org/docs/general/administration/hardware-acceleration.html#configuring-vaapi-acceleration-on-debianubuntu-from-deb-packages

Following the VAAPI option.

On Ubuntu install `vainfo`
```
sudo apt install vainfo
```
and verify that `vainfo` displays info about the render driver.

Following insturctions in the jellyfin docs after that.

## Mounting Hard Drives

The two hard drives are connected over USB. They are automounted as `/media/VolumeOne` and `/media/VolumeTwo`.

To automount the drives do the following.
Find the partition mount by running `sudo fdisk -l`. Based on the disk size, find the correct partitions:

```
Disk /dev/sdb: 931.5 GiB, 1000170586112 bytes, 1953458176 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 06F08C73-5E43-4AB6-B760-F366954FD03A

Device      Start        End    Sectors   Size Type
/dev/sdb1      40     409639     409600   200M EFI System
/dev/sdb2  411648 1953456127 1953044480 931.3G Microsoft basic data  ### This is the mount you want


Disk /dev/sdc: 931.5 GiB, 1000170586112 bytes, 1953458176 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 89439BBB-C4D0-4B4A-8F99-8A2FBF59DAF2

Device      Start        End    Sectors   Size Type
/dev/sdc1      40     409639     409600   200M EFI System
/dev/sdc2  411648 1953193983 1952782336 931.2G Microsoft basic data  ### This is the second mount you want
```

In the above example `/dev/sdb2` and `/dev/sdc2` are the mounts we want.

Create mount points for the two drives:
```
mkdir -p /media/VolumeOne
mkdir -p /media/VolumeTwo
```

Add the following lines to `/etc/fstab`, modifying the partitions as needed.

```
# Volumes for jellyfin
/dev/sdb2 /media/VolumeOne exfat defaults,uid=1000,gid=1000 0 0
/dev/sdc2 /media/VolumeTwo exfat defaults,uid=1000,gid=1000 0 0
```

Restart the server and the volumes should be mounted.
