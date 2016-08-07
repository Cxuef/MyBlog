---
title: Android 自定义View之Dialog使用RelativeLayout布局无法全屏显示
comments: true
categories: android
tags: [android,自定义View]
date: 2016-03-18 15:13:09
---
## 1. 问题描述
现在需要弹出一个自定义的Dialog，里面有两张ImageView和两个TextView，分别用于存放生成的二维码、X关闭和WiFi Hotspot信息显示。需要呈现的UI界面如下：

![QrbarcodeUI](/PostImage/QrbarcodeUI.png)

## 2. 布局文件和QRDialog style展示
先看布局文件settings_hotspot.xml

<!--more-->
```xml
<?xml version="1.0" encoding="utf-8"?>
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:background="@drawable/custom_settings_bg"
    android:gravity="center_horizontal"
    android:layout_width="match_parent"
    android:layout_height="match_parent" >

    <ImageView
        android:id="@+id/image"
        android:src="@drawable/custom_connection"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="10dp" />

    <ImageView
        android:id="@+id/qr_close"
        android:src="@drawable/qr_close"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="4dp"
        android:layout_marginLeft="156dp" />

    <TextView
        android:id="@+id/ap_ssid"
        style="@style/QRHotspotText"
        android:layout_below="@id/image" />

    <TextView
        android:id="@+id/ap_psword"
        style="@style/QRHotspotText"
        android:layout_below="@id/ap_ssid"
        android:layout_marginBottom="2dp" />

</RelativeLayout>
```

再看我们的自定义的QRDialog的样式style.xml
```xml
<style name="QRDialog" parent="@android:style/Theme.Dialog">
        <item name="android:windowFrame">@null</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowIsFloating">true</item>
        <item name="android:windowIsTranslucent">false</item>
        <item name="android:windowBackground">@android:color/transparent</item>
        <item name="android:windowNoTitle">true</item>
        <item name="android:backgroundDimEnabled">true</item>
</style>
```

最后用的时候指定它的样式为自己自定义的布局就好：

<span style="color:red"> DialogmQRDialog = new Dialog(getActivity(), R.style.QRDialog); </span>

![QrbarcodeAbnormal](/PostImage/QrbarcodeAbnormal.png)

但奇怪，我已经定义了Dialog的大小为全屏显示ture

** <span style="color:red"> android:windowFullscreen **

但是仍没有作用呢？？？由于之前我没有加上X关闭的ImageView时使用的是父容器用的是线性布局，是可以全屏的，所以怀疑是父容器的问题（其实，一开始以为是自己设置的style属性没有生效，重启编译Settings 并且push了多次的 o(╯□╰)o ）

## 3. 更改布局文件，父容器使用LinearLayout
修改为父容器使用LinearLayout，二维码的和X关闭的图片使用RelativeLayout相对布局

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:background="@drawable/custom_settings_bg"
    android:gravity="center_horizontal"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent" >

    <RelativeLayout
        android:layout_width="wrap_content"
        android:layout_height="wrap_content">
        <ImageView
            android:id="@+id/image"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="10dp" />

        <ImageView
            android:id="@+id/qr_close"
            android:src="@drawable/qr_close"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:padding="5dp"
            android:layout_marginTop="4dp"
            android:layout_marginLeft="156dp" />
    </RelativeLayout>

    <TextView
        android:id="@+id/ap_ssid"
        style="@style/QRHotspotText" />

    <TextView
        android:id="@+id/ap_psword"
        style="@style/QRHotspotText"
        android:layout_marginBottom="2dp" />

</LinearLayout>
```

得到最终的效果图:

![QrbarcodeNormal](/PostImage/QrbarcodeNormal.png)

## 4. 总结
自定义Dialog时如果想全屏显示，最外层的父容器应该选择LinearLayout而不是RelativeLayout。具体原因有待进一步分析，Dialog源码~

