---
title: 【置顶】搭建nginx rtmp直播服务器，ffmpeg模拟推流
comments: true
categories: linux
tags: [nginx, rtmp, ffmpeg]
date: 2076-02-26 09:21:22
---
Nginx本身是一个非常出色的HTTP服务器，FFMPEG是非常好的音视频解决方案。这两个东西通过一个nginx的模块nginx-rtmp-module，组合在一起即可以搭建一个功能相对比较完善并可支持RTMP和HLS的流媒体服务器。
nginx配合ffmpeg做流媒体服务器的原理是：nginx通过rtmp模块提供rtmp服务，ffmpeg推送一个rtmp流到nginx，然后客户端通过访问nginx来收看实时视频流。HLS也是差不多的原理，只是最终客户端是通过HTTP协议来访问的,但是ffmpeg推送流仍然是rtmp的。

![流媒体服务器原理](/PostImage/nginx_rtmp_ffmpeg_0.png)

<!--more-->

好啦，现在开始进入主题吧~

** 1. 从github下载nginx-rtmp-module **

eirot@ubuntu64:~/MyDev$ git clone https://github.com/arut/nginx-rtmp-module.git

![nginx-rtmp-module](/PostImage/nginx_rtmp_ffmpeg_1.png)


** 2. 下载nginx压缩包并解压 **

http://nginx.org/en/download.html

![nginx-rtmp-module-download](/PostImage/nginx_rtmp_ffmpeg_2.png)

** 3. 解压nginx-1.11.1.tar.gz并进入查看 **

eirot@ubuntu64:~/MyDev$ tar -xvf nginx-1.11.1.tar.gz

![tar-ll-nginx-rtmp-module](/PostImage/nginx_rtmp_ffmpeg_3.png)

** 4. 配置nginx **

eirot@ubuntu64:~/MyDev/nginx-1.11.1$ ./configure --prefix=/usr/local/nginx --add-module=/home/eirot/MyDev/nginx-rtmp-module --with-http_ssl_module --with-debug

![nginx-config](/PostImage/nginx_rtmp_ffmpeg_4.png)

【注意】如果安装失败，请检查系统是否有PCRE、OpenSSL、zlib 等library

** 5. 直接开始make nginx-rtmp-module **

eirot@ubuntu64:~/MyDev/nginx-1.11.1$ make

![nginx-make](/PostImage/nginx_rtmp_ffmpeg_5.png)

** 6. 然而出错啦！好吧，修改/home/eirot/MyDev/nginx-rtmp-module/ngx_rtmp_core_module.c中的memcpy函数参数类型 **

![nginx-fix-error](/PostImage/nginx_rtmp_ffmpeg_6.png)

** 7. 修改后再次make，没有报错得到*.o编译输出 **

eirot@ubuntu64:~/MyDev/nginx-1.11.1$ make

![nginx-remake](/PostImage/nginx_rtmp_ffmpeg_7.png)

** 8. OK之后，执行make install **

eirot@ubuntu64:~/MyDev/nginx-1.11.1$ sudo make install

![nginx-make-install](/PostImage/nginx_rtmp_ffmpeg_8.png)

** 9. 检查/usr/local/nginx/sbin/下是否有生成nginx **

![nginx-check](/PostImage/nginx_rtmp_ffmpeg_9.png)

** 10. 修改nginx.conf，添加rtmp配置项（端口和服务名可以自己修改）**

![nginx-conf](/PostImage/nginx_rtmp_ffmpeg_10.png)

```xml
rtmp {
   server {
       listen 1935;
       chunk_size 4096;

       application myapp {
           live on;
       }
       application hls {
           live on;
           hls on;
           hls_path /tmp/hls;
       }
   }
}
```
别忘了执行sudo ./nginx -c nginx.conf使配置生效！

** 11. 启动nginx **

eirot@ubuntu64:/usr/local/nginx/sbin$ sudo ./nginx

![nginx-start](/PostImage/nginx_rtmp_ffmpeg_11.png)

** 12. 检查端口是否占用 **

eirot@ubuntu64:/usr/local/nginx/sbin$ netstat -ntlp

![nginx-listen](/PostImage/nginx_rtmp_ffmpeg_12.png)

** 13. 在浏览器输入localhost，看是否能成功进入nginx的欢迎页面 **

![nginx-broswer](/PostImage/nginx_rtmp_ffmpeg_13.png)

** 14. 用ffmpeg产生一个模拟直播源，向rtmp服务器推送 **

eirot@ubuntu64:~/MyDev/video$ ffmpeg -re -i test.flv -f flv rtmp://192.168.242.172/myapp/test1

eirot@ubuntu64:~/MyDev/video$ ffmpeg -re -i Caminandes.mp4 -vprofile baseline -vcodec copy  -acodec copy  -strict -2 -f flv rtmp://192.168.242.172/myapp/test2

![ffmpeg-rtmp](/PostImage/nginx_rtmp_ffmpeg_14.png)

** 15.使用ffplayer或者vlc播放rtmp流 **

eirot@ubuntu64:~/MyDev/video$ ffplay rtmp://192.168.242.172/myapp/test1

![ffplay-rtmp](/PostImage/nginx_rtmp_ffmpeg_15.png)


## 参考blog

https://github.com/arut/nginx-rtmp-module

http://blog.csdn.net/zgl_dm/article/details/8167128

http://www.cnblogs.com/wainiwann/p/3866254.html

http://www.thinksaas.cn/topics/0/277/277674.html

http://redstarofsleep.iteye.com/blog/2123752

http://blog.csdn.net/ygm_linux/article/details/49978119

http://www.cnblogs.com/haibindev/archive/2013/01/30/2880764.html

http://www.w2bc.com/article/124934
