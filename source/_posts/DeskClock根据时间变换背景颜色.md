---
title: DeskClock根据时间变换背景颜色
comments: true
categories: android
tags: [DeskClock]
date: 2016-07-06 17:54:43
---
DeskClock.java是入口Activity，它继承于BaseActivity。那么真正完成根据时间换色的就是在这里了，Let's have a look !
在BaseActivity的onCreate和onResume中分别都有setBackgroundColor（），这是改变颜色的关键所在！只是需要你决定在什么时候调用这个函数哦，然后就是从数组中取出对应时间点的十六进制颜色值。

![DeskClock](/PostImage/DeskClock.png)

<!--more-->

好了，直接上关键部分的代码吧~
```java
 /**
 *  BaseActivity.java
 */
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    final int currentColor = Utils.getCurrentHourColor();
    final int backgroundColor = savedInstanceState == null ? currentColor
            : savedInstanceState.getInt(KEY_BACKGROUND_COLOR, currentColor);
    setBackgroundColor(backgroundColor, false /* animate */);
}

@Override
protected void onResume() {
    super.onResume();

    // Register mOnTimeChangedReceiver to update current background color periodically.
    if (mOnTimeChangedReceiver == null) {
        final IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_TIME_TICK);
        filter.addAction(Intent.ACTION_TIME_CHANGED);
        filter.addAction(Intent.ACTION_TIMEZONE_CHANGED);
        registerReceiver(mOnTimeChangedReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                setBackgroundColor(Utils.getCurrentHourColor(), true /* animate */);
            }
        }, filter);
    }

    // Ensure the background color is up-to-date.
    setBackgroundColor(Utils.getCurrentHourColor(), true /* animate */);
}

 /**
 * Sets the current background color to the provided value and animates the change if desired.
 *
 * @param color the ARGB value to set as the current background color
 * @param animate {@code true} if the change should be animated
 */
protected void setBackgroundColor(int color, boolean animate) {
    if (mBackground == null) {
        mBackground = new ColorDrawable(color);
        getWindow().setBackgroundDrawable(mBackground);
    }

    if (mBackground.getColor() != color) {
        if (animate) {
            ObjectAnimator.ofObject(mBackground, "color", AnimatorUtils.ARGB_EVALUATOR, color)
                    .setDuration(BACKGROUND_COLOR_ANIMATION_DURATION)
                    .start();
        } else {
            mBackground.setColor(color);
        }
    }
}
```
再来看看Utils.java工具类的实现^_^
```java
 /**
 * Utils.java
 * Returns the background color to use based on the current time.
 */
public static int getCurrentHourColor() {
    return BACKGROUND_SPECTRUM[Calendar.getInstance().get(Calendar.HOUR_OF_DAY)];
}

 /**
 * The background colors of the app - it changes throughout out the day to mimic the sky.
 */
private static final int[] BACKGROUND_SPECTRUM = {
        0xFF212121 /* 12 AM */,
        0xFF20222A /*  1 AM */,
        0xFF202233 /*  2 AM */,
        0xFF1F2242 /*  3 AM */,
        0xFF1E224F /*  4 AM */,
        0xFF1D225C /*  5 AM */,
        0xFF1B236B /*  6 AM */,
        0xFF1A237E /*  7 AM */,
        0xFF1D2783 /*  8 AM */,
        0xFF232E8B /*  9 AM */,
        0xFF283593 /* 10 AM */,
        0xFF2C3998 /* 11 AM */,
        0xFF303F9F /* 12 PM */,
        0xFF2C3998 /*  1 PM */,
        0xFF283593 /*  2 PM */,
        0xFF232E8B /*  3 PM */,
        0xFF1D2783 /*  4 PM */,
        0xFF1A237E /*  5 PM */,
        0xFF1B236B /*  6 PM */,
        0xFF1D225C /*  7 PM */,
        0xFF1E224F /*  8 PM */,
        0xFF1F2242 /*  9 PM */,
        0xFF202233 /* 10 PM */,
        0xFF20222A /* 11 PM */
};
```
以下地址是参考DeskColock根据时间换色的Demo，参考请移步github [ChangeColor](https://github.com/Cxuef/ChangeColor)
![ChangeColor](/PostImage/ChangeColor.gif)
