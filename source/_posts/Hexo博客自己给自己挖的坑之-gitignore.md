---
title: Hexo博客自己给自己挖的坑之.gitignore
comments: true
categories: devtools
tags: [Hexo]
date: 2016-02-29 14:58:11
---
之前blog一直可以通过点击tags进入某一标签的文章，类似于话题归类吧。但是前几天突然发现不行了，链接点击一直404。于是网上各种百度啊，好吧~众说纷纭！一开始怀疑是hexo没有重新生成或者生成不成功，删除public文件夹和db.json后hexo clean && hexo g && hexo d 了很多次，每次都提示成功了的(⊙﹏⊙) 自己也查看了下，\public\tags\也生成了index.html，因此不存在生成问题。既然生成没有问题，又开始怀疑是不是主题缓存问题呢？又哐当哐当地更新了nodejs
```bash
sudo npm cache clean --force
sudo npm update
```
<!--more-->

几个回合的折腾后，最后跑到github部署的主页上看看自己的提交，一看吓一跳，新的tags没有提交成功！OMG，问题就在这啦。知道问题所在就好办了，先检查自己的配置是否正确，发现是OK的！好吧，git用多了你就会敏锐地怀疑是不是哪里设置了忽略的配置.gitignore。果不其然，在我的home目录下自己设置了全局的.gitignore，如下：

```bash
# ignore the ctag file
tags

# ignore the eclipse generate file
.project
.classpath
project.properties
packages/apps/*/bin/
packages/apps/*/gen/

# ignore the android compile dir
out/
prebuilts/
prebuilts/python/linux-x86/2.7.5/lib/python2.7/
kernel-3.18/*
packages/apps/Settings/.settings/
```
这下终于找到罪魁祸首了，自己以前设置的忽略ctag生成的tags导致tags文件或tags/文件夹下的东西都被忽略了！啊，多么痛的领悟，赶紧加上 ** !tags/ ** 改回来：
```bash
# ignore the ctag file
tags

# Don't ignore the tags dir of my blog
!tags/

# ignore the eclipse generate file
.project
.classpath
project.properties
packages/apps/*/bin/
packages/apps/*/gen/

# ignore the android compile dir
out/
prebuilts/
prebuilts/python/linux-x86/2.7.5/lib/python2.7/
kernel-3.18/*
packages/apps/Settings/.settings/
```
好啦，重新hexo d部署，一切OK！
