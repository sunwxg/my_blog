+++
title = "Ubuntu 15.10 Sunpinyin Install"
description = ""

tags = [
    "linux",
    "Sun Pinyin"
]
date = "2016-03-30"
categories = [
    "blog",
]
+++

In Ubuntu 15.10 I use Sun Pinyin as Chinese input.

* Install Chinese language.
Open `System Setting` -> `Language Support`. Press `Install/Remove Languages...`, then select `Chinese(Simplified)`. Press `Apply Changes`.

* Active fcitx input frame work

```sh
im-config
```

* Open `System Setting`-> `Language Support`. At `Keyboard input method system:`, select `fcitx`.

* Logout and Login

Now you can use `Ctrl + Space` to switch input method between English and Chinese.

Press `dash` and input `fcitx configration`, open fcitx configration tool to change any parameter for sun pinying, like fuzzy input.
