+++
title = "Create cscope database for linux kernel source code"
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

I often use cscope to browse linux kernel source code in Vim. It is very convenient.

```sh
make cscope
```

We can use `make cscope` to generate cscope database for linux kernel source code.

But if we only use `make cscope`, we can't use cscope database in Vim. Because in `cscope.files`, the file path is relative path.

We should use absolute file path. So we need to add one parameter `O=.`

```sh
make O=. cscope
```
