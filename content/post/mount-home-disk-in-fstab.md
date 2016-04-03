+++
title = "Mount home disk by fstab file"
description = ""

tags = [
    "linux",
]
date = "2016-04-03"
categories = [
    "blog",
]
+++

I want to mount disk `/dev/sda3` to be `/home`.
I need to add one line in `/etc/fstab` file.

* Find `/dev/sda3` disk `UUID`.

```
$ lsblk -o +UUID /dev/sda3
NAME MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT UUID
sda3   8:3    0 203.1G  0 part /home      c0b3529a-c9ef-4c92-88c2-b278a7c4111b
```

* Add one line in `/etc/fstab` file.

```
UUID=c0b3529a-c9ef-4c92-88c2-b278a7c4111b /home ext4 defaults,noatime 0 2
```

* Reboot PC.
