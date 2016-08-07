---
title: Add outchain of music.163.com to hexo article
comments: true
categories: 心晴
tags: [music]
date: 2016-02-24 09:28:48
---
Wow, such a beautiful html5 music player, I love it!!! Thanks for Open Source, thank you [DIYgod](https://www.anotherhome.net/) and [Grzhan](https://blog.grr.moe/)
https://github.com/DIYgod/APlayer
https://github.com/grzhan/hexo-tag-aplayer
https://www.anotherhome.net/file/APlayer/
![ListenMusic](/PostImage/ListenMusic.jpg)
<!--more-->
## Installation
npm install hexo-tag-aplayer

## Usage
```javascript
{% aplayer title author url [picture_url, narrow, autoplay] %}
```
**Wrap the arguments within a string literal, for example:**
```javascript
{% aplayer "Caffeine" "Jeff Williams" "caffeine.mp3" "autoplay" %}
```
Show it now :
{% aplayer "Caffeine" "Eirot" "http://7xq131.com1.z0.glb.clouddn.com/あっちゅ～ま青春!.mp3" "/MusicAlbum/default.png" %}

Add the local music:
{% aplayer "MustClaver" "GatterJaani" "/music/MustKlaver.mp3" "/MusicAlbum/gatter_jaani.png" "narrow"  %}

This is a music outchain of music.163.com
<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="http://music.163.com/outchain/player?type=2&id=28947001&auto=0&height=66"></iframe>

