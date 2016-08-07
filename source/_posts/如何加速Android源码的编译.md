---
title: 如何加速Android源码的编译
comments: true
categories: android
tags: [ccache]
date: 2016-02-22 13:21:09
---
Cache一词来源于法语，其原意是“藏匿处，隐秘的地方”，而自从被应用于计算机科学之后，就已经成为了英语中的一个计算机体系结构专有名词。
Sun Microsystems的前首席科学家Billy Joy，作为BSD unix，csh，vi，NFS，java，TCP/IP等的发明者，他曾经说过，在计算机科学领域，如果没有了cache的发明，其他的一切发明都将失去意义。而正是他，将给予分页的虚拟内存系统引入了Unix，影响了之后所有的新操作系统开发。
Cache的出现是为了解决CPU日益增长的核心时钟频率以及系统主内存日益落后的素质之间的矛盾。
Cache的基本原理是局部性原理，局部性原理简单说起来就是在前一段时间经常用到的代码，在将来会被再次使用的几率也很高。
![Android-ccache](/PostImage/android-ccache.png)

<!-- more -->
** 1. vim ~/.bashrc 添加相关配置 **
```bash
#add ccache for speeding up android source code compilation
export USE_CCACHE=1
export CCACHE_DIR=/home/eirot/ccache
```
** 2. 进入到所在项目的android目录下设置ccache的大小**
eirot@ubuntu64:~/MyDev/rimocode/msm8994_S/LINUX/android$ ./prebuilts/misc/linux-x86/ccache/ccache -M 30G

** 3. 按照原有的方式正常编译 **
```bash
   source build/envsetup.sh
   lunch
   make -j8
```
** 4. 查看ccache使用率 **
On Linux, you can watch ccache being used by doing the following:
eirot@ubuntu64:~/MyDev/rimocode/msm8994_S/LINUX/android$ watch -n1 -d prebuilts/misc/linux-x86/ccache/ccache -s

** 5. 清除ccache缓存 **
eirot@ubuntu64:~/MyDev/rimocode/msm8994_S/LINUX/android$ ./prebuilts/misc/linux-x86/ccache/ccache -c
