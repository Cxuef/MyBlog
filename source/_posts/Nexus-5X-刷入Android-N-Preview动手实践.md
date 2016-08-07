---
title: Nexus 5X 刷入Android N Preview动手实践
comments: true
categories: android
tags: [Android N Preview]
date: 2016-04-27 21:16:49
---
还在纠结自己手机的版本还是多年前的X.x吗？嘿嘿，其实买个Google的亲儿子nexus系列的手机就好了。本文送给喜欢尝鲜的原生控geeker，不谢(￣_,￣ )
需要用到的命令：
```bash
fastboot oem unlock
fastboot flash bootloader bootloader-xxx-xxx.img
fastboot flash radio radio-xxx-xxx-xxx.img
fastboot reboot-bootloader
fastboot flash recovery recovery.img
fastboot flash boot boot.img
fastboot flash system system.img
```
<!--more-->

## 准备工作:

1. 下载适合自己nexus系列的ROM http://developer.android.com/intl/zh-cn/preview/download.html
2. 解压得到的工厂镜像 bullhead-npc56w-preview-d86c7559.tgz
3. 打开命令行，连接电脑并确认adb可用。然后进入刚才解压镜像文件的目录
4. 进入Settings系统设置，开启USB debugging并打开OEM锁。Settings  >>  Developer options >> OEM unlocking

把zip包依次解压：
![把zip包依次解压](/PostImage/unzip_rom.png)

解压后的文件夹结构：
![解压后的文件夹结构](/PostImage/file_structure.png)

好了，一切就绪。Let's go !

## 正式开工：
** 1. 解除厂商设备锁 **
fastboot oem unlock

** 2. 刷入 Bootloader & Radio **
打开命令行，进入解压工厂镜像的目录，依次输入以下命令：
fastboot flash bootloader bootloader-bullhead-bhz10m.img
注：由于每种设备的 bootloader 和 radio 文件名都不同，在操作时请将文件名换为对应的文件名。如果你的设备是手机或支持移动网络的平板设备，你还需要刷入radio:
fastboot flash radio radio-bullhead-m8994f-2.6.31.1.09.img

** 3. 重启设备至 Bootloader **
fastboot reboot-bootloader

** 4. 依次刷入其他镜像文件 **
重启完毕后，请依次刷入 recovery、boot、system 镜像文件
fastboot flash recovery recovery.img
fastboot flash boot boot.img
fastboot flash system system.img
Nexus 9 用户在完成以上几步后，还需要刷入 vendor.img，命令如下：
fastboot flash vendor vendor.img

** 5. 清除用户数据（非必选）**
fastboot flash cache cache.img
fastboot flash userdata userdata.img
强烈建议执行此步，以避免完成后系统因为缓存或其他问题不能正常工作。

** 6. 再次重启 **
fastboot reboot

好了，开始享受你的Android N 吧：）如果你不急的话，也可以将自己的手机绑定Google账号(Settings >> Accounts >> Google)并注册Android beta等待OTA 升级(Settings >> About Phone >> System update)
https://www.google.com/android/beta
![Android beta](/PostImage/android_beta.png)

## 命令行实际操作截图：

![ll](/PostImage/cmd_1.png)

![fastboot_1](/PostImage/cmd_2.png)

![fastboot_2](/PostImage/cmd_3.png)

![android_n_preview](/PostImage/android_n_preview.png)

## 可能遇到的错误：
* fastboot no permissions
eirot@ubuntu64:~$ fastboot devices
no permissions (verify udev rules); see [http://developer.android.com/tools/device.html]    fastboot

解决办法：
1、设置usb权限，找到设备ID，终端命令执行：lsusb
eirot@ubuntu64:~$ lsusb
Bus 001 Device 002: ID 05c6:903a Qualcomm, Inc.
Bus 001 Device 017: ID 0e8d:2003 MediaTek Inc.
记住该手机对应的ID（ 05c6 就是idVendor ，903a就是 idProduct）

高通手机系列：
eirot@ubuntu64:~$ lsusb
Bus 001 Device 002: ID 05c6:901d Qualcomm, Inc.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 003: ID 0e0f:0002 VMware, Inc. Virtual USB Hub
Bus 002 Device 002: ID 0e0f:0003 VMware, Inc. Virtual Mouse
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

MTK手机系列：
eirot@ubuntu64:~/MyDev/lra/mt6735$ lsusb
Bus 001 Device 017: ID 0e8d:2003 MediaTek Inc.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 003: ID 0e0f:0002 VMware, Inc. Virtual USB Hub
Bus 002 Device 002: ID 0e0f:0003 VMware, Inc. Virtual Mouse
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

2、新建或修改配置XXX.rules文件，终端命令执行：sudo vim /etc/udev/rules.d/99-vmware-scsi-udev.rules ，添加如下一行配置：
SUBSYSTEM=="usb", ATTRS{idVendor}=="05c6", ATTRS{idProduct}=="903a",MODE="0666"
MODE="0666"：为所有用户添加读写权限：0666（'a+rw'）

3、重启相关服务：
重启udev：sudo service udev restart
重启adb：adb start-server

* oem unlock is not allowed
eirot@ubuntu64:~/MyDev/apps/eirotApp/bullhead-npc56w$ fastboot flashing unlock
...
FAILED (remote: oem unlock is not allowed)
finished. total time: 0.003s

解决办法：
Settings  >>  Developer options >> OEM unlocking

## 参考附录：
http://developer.android.com/intl/zh-cn/preview/download.html
https://developers.google.com/android/nexus/images#instructions
https://developer.sony.com/develop/smartphones-and-tablets/android-n-developer-preview/
http://www.ithome.com/html/android/211020.htm
http://sspai.com/27429
