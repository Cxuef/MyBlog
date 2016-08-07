---
title: OpenCV3.0将彩色视频转换为灰度视频
comments: true
categories: linux
tags: OpenCV
date: 2016-02-25 10:01:13
---
开始工作之前，我们先理一下思路:如果是将一张彩色图片转化为灰度图，我们可以直接调用Opencv自带函数cvtColor()。同理，视频无外乎就是一系列的帧，我们可以循环读入帧并转化成灰度图然后写入磁盘即可。本示例是在Ubuntu14.0+Cmake+Opencv3.0的环境下编译运行的，算是比较新的版本了。我们分为4个步骤:

1. 编写CMakeLists.txt定义编译的Project
2. 码主程序GrayVideo.cpp
3. cmake编译
4. 运行程序

<!--more-->
Now show the code:
1. 编写CMakeLists.txt定义编译的Project
** eirot@ubuntu64:~/MyDev/Opencv/Demo/GrayVideo$ vim CMakeLists.txt **
```bash
cmake_minimum_required(VERSION 2.8)
project( Grayvideo )
find_package( OpenCV REQUIRED )
add_executable( GrayVideo  GrayVideo.cpp )
target_link_libraries( GrayVideo ${OpenCV_LIBS} )
```

2. 码主程序GrayVideo.cpp
** eirot@ubuntu64:~/MyDev/Opencv/Demo/GrayVideo$ vim GrayVideo.cpp **
```c++
#include <opencv2/opencv.hpp>
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include "opencv2/core/core.hpp"
#include <opencv2/core/utility.hpp>
#include <opencv2/opencv.hpp>
#include "opencv2/video/video.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/videoio/videoio.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/opencv_modules.hpp"

using namespace std;
using namespace cv;
#define FILENAME "GrayVideo.avi"

double outputFps = 30;
string outputPath = "GrayVideo.avi";

int main()
{
    VideoCapture capture("DXJX2011.mov");
    VideoWriter writer;
    Mat gray_frame;
    Mat orignal_frame;
    //Mat edge_frame;
    int nframes = 0;

    fstream _file;
    _file.open(FILENAME,ios::in);
    if(_file)
    {
        cout << "Video have been converted to gray ! Exit now" << endl;
        exit(0);
    }

    while (1)
    {
        nframes++;
        // init writer (once) and save grayed frame
        capture >> orignal_frame;
        cvtColor(orignal_frame, gray_frame, COLOR_BGR2GRAY);
        /* Do some addtional work if you want
        blur(gray_frame, edge_frame, Size(7,7));
        Canny(gray_frame, edge_frame, 0,30 ,3); */
        if (!outputPath.empty())
        {
            if (!writer.isOpened())
            {
                //is_color=1 默认为彩色视频,转化为灰度视频必须设为单通道
                writer.open(outputPath, VideoWriter::fourcc('X','V','I','D'),
                    outputFps, orignal_frame.size(), 0);
            }
            writer << gray_frame;
            cout << "--->>Write frame: " << nframes << endl;
        }
        if (orignal_frame.empty())
        {
            cout << "It's done ! " << endl;
            break;
        }

        if (waitKey(30) >= 0) break;
        imshow("GrayVideo", gray_frame);

     }

    cout << "processed frames: " << nframes << endl<< "finished\n";

}
```

3. cmake编译
** eirot@ubuntu64:~/MyDev/Opencv/Demo/GrayVideo$ cmake . **
** eirot@ubuntu64:~/MyDev/Opencv/Demo/GrayVideo$ make **
![Cmake. make](/PostImage/cmake_make.png)

4. 运行程序
** eirot@ubuntu64:~/MyDev/Opencv/Demo/GrayVideo$ ./GrayVideo **
--->>Write frame: 361
It's done !
processed frames: 361
finished
![SWU JX2011](/PostImage/GrayVideoFrame.png)
