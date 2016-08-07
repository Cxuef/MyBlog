---
title: 'Linux永久挂载(mount)分区'
comments: true
categories: linux
tags: [linux, mount]
date: 2016-02-22 10:37:36
---
** 1.eirot@ubuntu64:~$ sudo blkid /dev/sdb1 **
得到/dev/sdb1这个分区的UUID:
```bash
/dev/sdb1: UUID="f85f79e6-19d0-4f4f-a15d-6204eed0b21d" TYPE="ext4"
```

** 2.eirot@ubuntu64:~$ vim /etc/fstab **
添加挂载项:
```bash
UUID=f85f79e6-19d0-4f4f-a15d-6204eed0b21d /home/eirot/MyDev    ext4    defaults     0       2
```
![Linux-mount](/PostImage/mount.png)

