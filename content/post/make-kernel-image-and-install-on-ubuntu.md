+++
title = "Make new kernel image and install on Ubuntu"
description = ""

tags = [
    "linux",
    "kernel",
]
date = "2016-04-03"
categories = [
    "blog",
]
+++

If you want to use latest version kernel on your Ubuntu, you need to compile kernel source code by yourself. Let's make and install it.

* Download the latest version kernel source code from [https://www.kernel.org/](https://www.kernel.org/).

* Untar the downloaded files.

```
tar xf linux-4.5.tar.xz
```

* Prepare `.config` file.

```
cd linux-4.5
cp /boot/config-`uname -r` ./.config
make menuconfig
```
Select `Load`, load `.config` file.

Select `Save`, save `.config` file.

Select `Exit`.

* Make kernel image.

```
sudo make-kpkg --initrd kernel_image
```

* Install kernel image.

```
sudo dpkg -i ../linux-image-4.5.0_4.5.0-10.00.Custom_amd64.deb
```

Now reboot PC, system will use the new kernel.

If you want to remove one kernel image package, then

```
sudo dpkg --purge linux-image-4.5.0+
```
