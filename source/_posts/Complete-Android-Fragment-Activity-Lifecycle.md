---
title: 'Complete Android Fragment & Activity Lifecycle'
comments: true
categories: android
tags: [Fragment,Activity]
date: 2016-02-01 21:13:27
---
After struggling with trying to figure out how various pieces fit together, I've done some research and put together the complete Android Activity/Fragment lifecycle chart. This has two parallel lifecycles (activities and fragments) which are organized vertically by time. Lifecycle stages will occur in the vertical order in which they're displayed, across activities and fragments. In this way, you can see how your fragments interact with your activities.
<!--more-->

>note: A PreferenceFragment doesn't have a its own Context object. If you need a Context object, you can call getActivity(). However, be careful to call getActivity() only when the fragment is attached to an activity. When the fragment is not yet attached, or was detached during the end of its lifecycle, getActivity() will return null.

![Complete Android Fragment & Activity Lifecycle](/PostImage/android-activity-fragment-life.png)
