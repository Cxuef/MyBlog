---
title: 快用Hexo动手搭建自己的Blog吧
comments: true
categories: devtools
tags: [Hexo, 个人小站]
date: 2016-02-19 13:55:18
---
Hexo是一款基于Node.js的静态博客，它是由台湾的一位大学生写出来的，支持很多主题和Markdown，很炫酷并且也很好用，现在已经可以支持多说了，很多人都在使用。如果你想Geek一下，可以尝试一下自己搭建一款属于自己的Hexo博客。其中自己特别喜欢yilia主题的简约大气，赞~ 另外本篇博文介绍的是Ubuntu14.0+hexo3.1+github+markdown的写作方式，比较适合Linuxer玩家哟
![blog-hexo](/PostImage/blog-hexo.png)

<!-- more -->

https://github.com/hexojs/hexo
![hexo-github](/PostImage/hexo-github.png)

https://hexo.io/
![hexo-io](/PostImage/hexo-io.png)

https://hexo.io/docs/
![hexo-doc](/PostImage/hexo-doc.png)

https://hexo.io/plugins/
![hexo-plusins](/PostImage/hexo-plusins.png)

接下来就是正式地安装啦 O(∩_∩)O~
** 1. eirot@ubuntu64:~/MyDev/eirotBlog$ sudo apt-get install npm **
![sudo_apt-get_install_npm](/PostImage/sudo_apt-get_install_npm.png)

** 2. eirot@ubuntu64:~/MyDev/eirotBlog$ npm install hexo-cli -g  (多执行几次！) **
![npm_install_hexo-cli_-g_1](/PostImage/npm_install_hexo-cli_-g_1.png)
![npm_install_hexo-cli_-g_2](/PostImage/npm_install_hexo-cli_-g_2.png)

** 3. eirot@ubuntu64:~/MyDev/eirotBlog$ hexo init blog **
![hexo_init_blog](/PostImage/hexo_init_blog.png)

解决方法：http://stackoverflow.com/questions/26320901/cannot-install-nodejs-usr-bin-env-node-no-such-file-or-directory
![softlink](/PostImage/softlink.png)
建立软连接：eirot@ubuntu64:~/MyDev/eirotBlog$ sudo ln -s /usr/bin/nodejs /usr/bin/node

3.1再执行eirot@ubuntu64:~/MyDev/eirotBlog$ hexo init blog

3.2现在我们的工作继续，得到如下结果：
![hexo_init_blog_2](/PostImage/hexo_init_blog_2.png)

** 4. 进入刚刚创建的blog目录：eirot@ubuntu64:~/MyDev/eirotBlog/blog$ sudo npm install **
![sudo_npm_install](/PostImage/sudo_npm_install.png)
![sudo_npm_install_2](/PostImage/sudo_npm_install_2.png)

** 5. eirot@ubuntu64:~/MyDev/eirotBlog/blog$ hexo server **
![hexo_server](/PostImage/hexo_server.png)

** 6. eirot@ubuntu64:~/MyDev/eirotBlog/blog$ hexo new "Hello Eirot hexo !" **
![hexo_new](/PostImage/hexo_new.png)

** 7. eirot@ubuntu64:~/MyDev/eirotBlog/blog$ hexo generate **
![hexo_generate](/PostImage/hexo_generate.png)

** 8. 下载并配置自己喜欢的主题：eirot@ubuntu64:~/MyDev/eirotBlog/blog$ git clone https://github.com/litten/hexo-theme-yilia.git **
![diy_theme_1](/PostImage/diy_theme_1.png)
![diy_theme_2](/PostImage/diy_theme_2.png)
yilia主题结构：
.
├── languages
├── layout
│   └── _partial
│       └── post
└── source
    ├── css
    │   ├── fonts
    │   ├── _partial
    │   └── _util
    ├── fancybox
    │   └── helpers
    ├── img
    └── js
附上该大虾Blog~  http://litten.github.io/2014/08/31/hexo-theme-yilia/

** 9. github托管（注意千万不要少了空格！） **
![hexo_generate](/PostImage/hexo_generate.png)
![hexo_clean](/PostImage/hexo_clean.png)
安装默认插件完成后，为了支持github，还需要安装另一个插件：npm install hexo-deployer-git --save
![hexo-deployer-git1](/PostImage/hexo-deployer-git1.png)
![hexo-deployer-git2](/PostImage/hexo-deployer-git2.png)

** 10. eirot@ubuntu64:~/MyDev/eirotBlog/blog$ hexo d **
![hexo_d1](/PostImage/hexo_d1.png)
![hexo_d2](/PostImage/hexo_d2.png)

** 11. Hexo 常用命令 **
```bash
hexo new "postName" #新建文章
hexo new page "pageName" #新建页面
hexo clean #清除生成的东西
hexo generate #生成静态页面至public目录
hexo server #开启预览访问端口（默认端口4000，'ctrl + c'关闭server）
hexo deploy #将.deploy目录部署到GitHub
hexo help  # 查看帮助
hexo version  #查看Hexo的版本
```
