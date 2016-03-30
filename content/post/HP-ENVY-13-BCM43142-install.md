+++
title = "HP ENVY13 BCM43142 Driver Install"
description = ""

tags = [
    "linux",
    "driver"
]
date = "2016-03-29"
categories = [
    "blog",
]
+++

HP ENVY13 laptop install Ubuntu 15.10, WiFi didn't work. Use `ifconfig` can't see wireless card, only see lo.

```
$ ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:2191 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2191 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:191462 (191.4 KB)  TX bytes:191462 (191.4 KB)
```

Use `lspci` can find wireless card.

```
$ lspci |grep Network
01:00.0 Network controller: Broadcom Corporation BCM43142 802.11b/g/n (rev 01)
```

### Install Driver

* First download BCM43142 linux driver from [http://broadcom.com/support/802.11](http://broadcom.com/support/802.11). I download version 6.30.223.271.

* Untar the downloaded file.

```
mkdir bcm
tar xzf hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz -C bcm
```

* Build module.

```
cd bcm
make API=CFG80211
```

* Install module.

```
sudo make install
depmod
```

* Unload bcma module.

```
echo "blacklist bcma" >> /etc/modprobe.d/blacklist.conf
```
* Reboot laptop

```
sudo reboot
```

Now WiFi work well.

If you meet any other problem, you can reference dirver [release note](http://www.broadcom.com/docs/linux_sta/README_6.30.223.271.txt).
