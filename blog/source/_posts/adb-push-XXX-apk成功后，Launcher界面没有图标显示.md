---
title: adb push XXX.apk成功后，Launcher界面没有图标显示
comments: true
categories: android
tags: [adb]
date: 2016-02-27 17:16:37
---
## 原因分析：

* 可能是AndroidManifest.xml定义程序主入口的activity的intent-filte没有申明android.intent.category.LAUNCHER
* 可能是系统没有及时解析
* 看看Launcher是否有针对该应用包名的隐藏设置（系统级隐藏特定包名，一般不会）
* 看看编译的版本是eng还是user-debug？eng版本可能会有这个问题哦

接下来还是一步一步排查吧~
<!--more-->

## 解决方法：

1. 查看该应用的 AndroidManifest.xml定义程序主入口的activity中是否有android.intent.category.LAUNCHER
```xml
<activity android:name="Settings"
                android:taskAffinity="com.android.settings"
                android:label="@string/settings_label_launcher"
                android:launchMode="singleTask">
            <intent-filter android:priority="1">
                <action android:name="android.intent.action.MAIN" />
                <action android:name="android.settings.SETTINGS" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.LAUNCHER" />
                <category android:name="android.intent.category.APP_SETTINGS" />
            </intent-filter>
            <meta-data android:name="com.android.settings.PRIMARY_PROFILE_CONTROLLED"
                android:value="true" />
</activity>

<!-- Alias for launcher activity only, as this belongs to each profile. -->
 <activity-alias android:name="Settings"
                android:taskAffinity="com.android.settings"
                android:label="@string/settings_label_launcher"
                android:launchMode="singleTask"
                android:targetActivity="Settings">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
</activity-alias>
```

2. adb shell stop && adb shell start 重启Framework（或者干脆adb reboot重启设备）

