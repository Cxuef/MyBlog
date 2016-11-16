---
title: 在AS上使用纯java方式调用OpenCV
comments: true
categories: android
tags: [OpenCV, Android Studio]
date: 2016-11-16 14:59:59
---
如果你想在Android Studio上开发OpenCV应用,那么本文就是这里的一小步。下面我将分四点讲解如何在Android studio下将一张彩色的美女图利用OpenCV变成灰度图，详情请点more

![Android Studio + OpenCV + java](/PostImage/ASOpenCVJava.png)
<!-- more -->

** 1. 导入OpenCV作为依赖Module **
先自行建立好project哈，然后我们导入OpenCV作为一个依赖的Module
![Improt OpenCV as module](/PostImage/ImportOpenCVModule.png)

在弹出的窗口中找到OpenCV Android SDK下的sdk\java文件夹，比如我的是/home/eirot/MyDev/Opencv/OpenCV-android-sdk/java

然后点击Next，保持默认选项不动，再点击Finish，完成OpenCV库的导入：
![Improt OpenCV sdk](/PostImage/ImportOpenCVSDK.png)

此时，Android Studio会自动更新项目配置。由于OpenCV库本身默认配置的原因，在这个过程中会产生很些错误。这就需要我们修改OpenCVLibrary300\build.gradle文件（主要是自定义修改compileSdkVersion、minSdkVersion这些...），然后重新同步Gradle配置解决问题：
![Fix OpenCV Config 1](/PostImage/FixOpenCVConfig_1.png)

** 2. 为新建项目配置OpenCV **
此修改项目的Module下app的build.gradle配置，添加openCVLibrary300：
```xml
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
    compile 'com.android.support:appcompat-v7:24.2.1'
    compile 'com.android.support.constraint:constraint-layout:1.0.0-alpha2'
    testCompile 'junit:junit:4.12'
    compile project(':openCVLibrary300')
}
```
![Fix OpenCV Config 2](/PostImage/FixOpenCVConfig_2.png)

** 3. 安装OpenCV_Manager **
至此，你的Android项目就支持OpenCV开发了！不过在开始前，先说点不足吧！那就是如果我们用这种方式运行程序，必须安装该死的OpenCV_Manager.apk (⊙o⊙) 该apk就在OpenCV-android-sdk/apk/ 路径下可以找到，选择【对应】设备版本的安装即可。
![Install OpenCV Manager](/PostImage/InstallOpenCVManager.png)

** 4. 编写测试代码 **
大致思路：我们需要先实现BaseLoaderCallback，然后在OnResume（）的时候将OpenCVload进去，之后再onCreate（）或者其他地方完成自己需要的业务逻辑。
![Code for OpenCV 1](/PostImage/CodeForOpenCV_1.png)
![Code for OpenCV 2](/PostImage/CodeForOpenCV_2.png)
![Code for OpenCV 3](/PostImage/CodeForOpenCV_3.png)

这里需要注意一个问题：
那就是如果你直接在onCreate（）的时候就调用了OpenCV相关的东西，比如Mat rgbMat = New Mat( )可能会报错：
No implementation found for long org.opencv.core.Mat.n_Mat

这是因为OpenCVLoader采用了异步加载，此时我们还没有连接上OpenCVManner的原因！！！

好啦，示例就是实现将一张美女图彩色图变成灰度图。具体代码请移步github，O(∩_∩)O谢谢
![Show the result](/PostImage/FistOpenCVResult.gif)
