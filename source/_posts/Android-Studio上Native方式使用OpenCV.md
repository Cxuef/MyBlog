---
title: Android Studio上Native方式使用OpenCV
comments: true
categories: android
tags: [OpenCV, Jni]
date: 2016-11-28 10:46:21
---
开始之前先说下native方式使用OpenCV的好处吧，坏处我不说，嘿嘿。
* native函数执行效率高，速度快
* 不用安装可恶的OpenCVManger.apk
* 大量可复用C++代码，不用苦逼地查找这个api在java的哪个类
![opencv android ndk](/PostImage/opencv_android_ndk.png)
<!--more-->

好啦，直奔主题喽。新建项目的过程这里也不赘述了，我们直接看关键的修改地方吧。
** 1. 新建app\src\main\jni\Android.mk文件，内容如下： **
```xml
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#opencv
include /home/eirot/MyDev/Opencv/OpenCV-android-sdk/sdk/native/jni/OpenCV.mk
OPENCV_CAMERA_MODULES:=on
OPENCV_INSTALL_MODULES:=on
OPENCV_LIB_TYPE:=SHARED

LOCAL_SRC_FILES := GrayProcess.cpp

LOCAL_LDLIBS += -llog
LOCAL_MODULE := grayprocess

include $(BUILD_SHARED_LIBRARY)
```
其中，/home/eirot/MyDev/Opencv/OpenCV-android-sdk/sdk/native/jni/OpenCV.mk要指向你自己的OpenCV Android SDK中对应文件的位置。
OPENCV_CAMERA_MODULES:=on 说明要使用摄像头功能，我们的demo中虽然没有用到，但是平时写程序时经常会忘记在这里添加，所以一并写上了。
OPENCV_INSTALL_MODULES:=on 可以理解为，编译器自动把OpenCV-android-sdk\sdk\native\libs\armeabi-v7a\libopencv_java3.so拷贝并打包在最终的apk中（目标架构armeabi-v7a因目标设备而定），这也是不需要我们手动向项目内添加任何OpenCV相关库文件的原因。
LOCAL_SRC_FILES 是需要编译的C/C++源码文件，如果有多个文件，只需要用空格将文件名分隔，如果文件名太多需要换行，则在前一行行末添加一个“\”符号即可。
LOCAL_MODULE 是编译产生的.so库的名称，应该与MainActivity.java中通过System.loadLibrary("grayprocess");调用的库名称一致。

** 2. 新建app\src\main\jni\Application.mk文件，内容如下： **
```xml
APP_STL := gnustl_shared
APP_CPPFLAGS := -frtti -fexceptions -std=c++11
APP_ABI := armeabi-v7a arm64-v8a
APP_PLATFORM := android-21
```
其中，APP_CPPFLAGS中的-std=c++11表示开启C++11支持。
APP_ABI规定了NDK编译的目标平台。
APP_PLATFORM指定了NDK编译针对的平台，其取值应该尽量与app\build.gradle中的minSdkVersion相一致。参考这里：http://stackoverflow.com/a/21982908/3829845。

** 3. 配置build.gradle文件 **
这里的build.gradle是指app模块下的build.gradle，不是整个工程的build.gradle文件。在模块的build.gradle的defaultConfig下加入以下配置：
```java
import org.apache.tools.ant.taskdefs.condition.Os
apply plugin: 'com.android.application'
android {
    compileSdkVersion 24
    buildToolsVersion "24.0.2"
    defaultConfig {
        applicationId "com.ckt.eirot.opencv4jni"
        minSdkVersion 21
        targetSdkVersion 23
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"

        ndk {
            moduleName "grayprocess"
            ldLibs "log", "z", "m"
            abiFilters "armeabi", "armeabi-v7a", "armeabi-v8a"
        }
    }

    sourceSets.main {
        jniLibs.srcDirs = ['src/main/libs', 'src/main/jniLibs']
        jni.srcDirs = [] //disable automatic ndk-build call
    }

    // call regular ndk-build(.cmd) script from app directory
    task ndkBuild(type: Exec) {
        Properties properties = new Properties()
        properties.load(project.rootProject.file('local.properties').newDataInputStream())
        def ndkDir = properties.getProperty('ndk.dir')

        if (Os.isFamily(Os.FAMILY_WINDOWS)) {
            commandLine "$ndkDir/ndk-build.cmd", '-C', file('src/main/jni').absolutePath
        } else {
            commandLine "$ndkDir/ndk-build", '-C', file('src/main/jni').absolutePath
        }
    }

    tasks.withType(JavaCompile) {
        compileTask -> compileTask.dependsOn ndkBuild
    }
}
```

** 4. 配置gradle.properties文件 **
打开工程目录下的gradle.properties文件（注意不是build.gradle，而是gradle.properties），在文件的最后一行加入:
<font color=#0099ff face="黑体">android.useDeprecatedNdk=true</font>

** 5. 新建GrayProcess.java **
你也可以直接写在MainActivity类里，看个人习惯吧，内容如下：

```java
public class GrayProcess {
    /**
     * @param buf
     * @param w
     * @param h
     * @return
     */
    public static native int[] grayProcess(int[] buf, int w, int h);
}
```

** 6. 生成对应java类的头文件 **
打开命令行编辑工具后，cd到工程的src/main/java目录（注意路径），输入格式如下：

<font color=#0099ff face="黑体">javah -d ../jni 你的包名.引用本地方法的类的名称</font>

eirot@ubuntu64:~/MyDev/study/AndroidApps/OpenCV4JNI/app/src/main/java$ javah -d ../jni com.ckt.eirot.opencv4jni.GrayProcess
构建完成后就会在工程的src/main目录下生成一个jni目录，下边还包含.h头文件，如下图所示：
![GrayProcess](/PostImage/GrayProcess.png)

** 7. 编写C++实现类 **
这里可以copy下.h头文件重命名为你需要的XXX.cpp，然后去掉不需要的内容并把函数补写完成，个人感觉这样快捷点。另外，关于在Jni调用涉及OpenCV api的时候，这里我的Android studio没有提示，env-> 这些其他Jni是有的。【求教！！！】
![GrayProcess.cpp](/PostImage/GrayProcess_CPP.png)

** 8. 编写Demo界面，运行程序 **
Android UI界面布局就不介绍了，随你咋弄。具体代码请移步github [OpenCV4JNI](https://github.com/Cxuef/OpenCV4JNI) 效果如下，还是美女彩色图变成灰度图：
![Result](/PostImage/OpenCVResult.gif)

** 9. 参考链接 **
* http://johnhany.net/2016/07/opencv-3-1-ndk-dev-on-android-studio-2/#opencv-ndk-app
* http://blog.csdn.net/aplixy/article/details/51429305
* https://www.youtube.com/watch?v=flBlhnEd530

** 10.Q&A **
参考纯java实现OpenCV Demo时，我们可以import new module将OpenCV-android-sdk\sdk\java\作为依赖库导入，这样涉及到OpenCV api时AS有提示。那么在Android studio上能否实现Native层当涉及到OpenCV的函数时出现提示呢？？？比如如下Jni函数实现：
```java
JNIEXPORT jintArray JNICALL Java_com_ckt_eirot_opencv4jni_GrayProcess_grayProcess(JNIEnv *env,
    class obj,jintArray buf,jint w, jint h) {
    jboolean ptfalse = false;
    jint *srcBuf = env->GetIntArrayElements(buf, &ptfalse);
    if (srcBuf == NULL) {
        return 0;
    }
    int size = w * h;
    Mat srcImage(h, w, CV_8UC4, (unsigned char *) srcBuf);
    Mat grayImage;
    // 加粗字符想实现像java层一样给出代码提示  cvt….
    cvtColor(srcImage, grayImage, COLOR_BGRA2GRAY);
    cvtColor(grayImage, srcImage, COLOR_GRAY2BGRA);
    jintArray result = env->NewIntArray(size);
    env->SetIntArrayRegion(result, 0, size, srcBuf);
    env->ReleaseIntArrayElements(buf, srcBuf, 0);
    return result;
}
```

期待回复，O(∩_∩)O谢谢
