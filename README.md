# Photon Desktop



### Packages

* `yay` - AUR
* `picom-ibhagwan-git` - blrrr
* `alacritty` - [hackerman](https://c.tenor.com/mAlJkmN3TEcAAAAi/hackerman-emote.gif)
* `zsh` and `oh-my-zsh` - `powerline10k`
* `lightdm` - `lighted-webkit2-theme-glorious`
* `refind` - make go computer (also fixes terminal size issue with Nvidia proprietary drivers)
* `syncthing` - netwrok folder sync
* `nnn` - file "manager"? better `ranger` , will probably add 
* `foliate` - ebook reader (works with `nnn` for preview and launch from terminal)
* `scrot` 
* `solaar` - Logi unifying support
* `eww-git` - widgets are 100% required for d2d operations
* `borg` - compressed (zstd) and encrypted (blake2) VCS-esque backup.
* `qemu` - for VMs
* `kyoto` - nvim IDE (?)
* `polybar` 
* `awesome` or `bspwm` or or or `xmonad` if I bother to learn some Haskell.



## TODO:

#### Sort out zen kernel Nvidia proprietary driver issues

This has turned into a trial-and-error situation.  So far, all signs point to incompatible despite docs saying otherwise.  

#### Settle on a partition scheme

`/` and `boot` on the nvme gen4x4

​	Only question here is whether to include a swap here or on it's own drive.  If I include it here, it would be 1x RAM volume at most and would facilitate hibernation more than anything.  Given that it would mostly hibernate during times when I'd like to run the spinning rust backup or during times when I'm using my laptop (`syncthing` would be running anyway), I don't see this being an issue.

`/home` on `md` gen3 RAID 0 array (?)

​	Slower than the root drive, even in RAID 0, but more than fast enough to operate as primary storage. Question here is: which file system.  This is getting pretty deep into the weeds but realistic options are **EXT4**,**NTFS** or **BTRFS**.  See [ZFS](####ZFS) for the other option

`/var` on tiny gen3

​	Not strictly necessary, but I've got it floating around so why not.  I can also toss a RAM sized swap to split the drive. Alternatively could be used as a cache for spinning rust (not sure `borg` supports caching).

`/data` on Pulsar Array. If I can find somewhere to offload the current backups, a ZFS partition with a cache could work.  Other options include a FreeNAS VM running the array alongside PLEX.  

#### ZFS

The "out there" choice would be **ZFS** but given it's *out of tree* status leading to the kernel module not loading at boot *on top of* striped soft-RAID, it's risky.  This is assuming I choose to partition the array.  Otherwise I can just have `zfs-linux` handle the volume management and `zfs-mount-generator` to handle the systemd side of things.
