+++
title = "jekyll add github equal blog"
description = "Use jekyll to create blog web site"

tags = [
    "jekyll",
]
date = "2016-03-22"
categories = [
    "blog",
]
+++

## Make a Repository

Following the [https://pages.github.com/](https://pages.github.com/) make a repository.

## Install Jekyll

```
apt-get install jekyll
```

## Create new jekyll site

```
git clone https://github.com/sunwxg/sunwxg.github.io.git
cd sunwxg.github.io
jekyll new .
```

## Browse your blog site

```
jekyll build
jekyll serve
```
Browse http://localhost:4000

## Change `_config.yml` file

Reference jekyll [manual](https://jekyllrb.com/docs/configuration/)

## Push to remote repository

```
git push
```
Browse [http//sunwxg.github.io](http://sunwxg.github.io)
