---
title: Hexo-Github建博客教程
tags:
- hexo
- github page
- 搭建博客
---
本人=一名小白,而且我对网站开发以及前端的知识几乎是零基础,所以在自己刚接触这个东西的时候,我像很多人一样,都是上网找教程,但是要知道,那都是程序员的教程.一路摸爬滚打,终于搞定了,这篇文章算是自己的操作记录,为以后的重新搭建留个备忘...

参考官网:https://hexo.io/docs  
参考网站1:http://jiji262.github.io  
[参考网站2](http://crazymilk.github.io/2015/12/28/GitHub-Pages-Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2/#more)

## 安装Hexo

Hexo安装需要安装`Node.js`和`Git`.二者的安装可以到相应的官网下载安装即可.注意`apt-get`安装的`Node.js`不是最新版本.  
倘若遇到问题,可以参考[hexo官网](https://hexo.io/docs  ).

```bash
npm install hexo-cli -g 
```

## 创建Github pages

- 在线创建库并起名`yaro97.github.io`,在设置中通过` Launch automatic page generator`生成github page即可  
**注意:**`name`要是唯一的话,生成的网址为`name.github.io`,若不唯一,网址为`yaro97.github.com/name.github.io`
- 克隆远程库到本地文件夹`yaro97.github.io`(一般在user目录下)  
`git clone https://github.com/yaro97/yaro97.github.io.git`
- 本地创建并切换至`hexo`分支  
`git checkout -b hexo`
- 把当前hexo分支push到远程  
`git push --set-upstream origin hexo`
- 远程把`hexo`分支设为默认分支  
hexo分支用于存储原始文件,master用于存储生成的网页静态文件.

<!--more-->

## 初始化Hexo

在`yaro97.github.io`文件夹中运行

```bash
hexo init blog #建立文件夹`blog`,并在其中初始化hexo
cd blog 
npm install #npm安装package.json中的依赖包
npm install hexo-deployer-git --save #安装deploy插件,后续部署github需要.
```

初始化完成后,可以`hexo generate`,`hexo server`查看是否能正常访问本地博客`http://localhost:4000`.  
安装成功后可以使用`hexo -v`查看本地配置环境

## Hexo主题

### 下载主题

- 可以直接下载相关zip文件,解压缩到`.../hexo/blog/`文件夹下

- 可以在`blog`目录下运行`git clone https://github.com/iissnan/hexo-theme-next themes/next`将next主题下载到themes文件夹下.

### 启用主题

编辑配置文件`_config.xml`中的主题名为`themes`文件夹下对应的文件夹名.然后运行如下命令.

```bash
hexo clean #清理hexo缓存
hexo s #重新启动本地web服务器
```

主题的其他设置见next主题[官网](http://theme-next.iissnan.com/).

## 部署本地Hexo到Github pages

- 注意部署前一定要安装插件`hexo-deployer-git`.前面已经安装

- 修改`_config.xml`文件

```
deploy:
    type: git
    repo: https://github.com/yaro97/yaro97.github.io.git
    branch: master
    name: yaro
    email: wyzh97@gmail.com
# 注意这里是上传至master分支.具体设置可以参考hexo官网.
```

- 执行命令`hexo d`完成部署,过程中需要github账号/密码,账号为`yaro97`.

## 自定义域名

### 绑定主域名

- 在新建的`repository`中新建文件`CNAME`,内容填写:
    
    ```
    www.paotime.com
    paotimecom
    ```

- 在阿里云中,添加域名解析,内容如下:

    ```
    记录类型:A; 主机记录:@; 记录值:192.30.252.153.
    记录类型:A; 主机记录:www; 记录值:192.30.252.153.
    ```

### 绑定二级域名

- 在新建的`repository`中新建文件`CNAME`,内容填写:

    ```
    blog.paotime.com
    ```

- 在阿里云中,添加域名解析,内容如下:

    ```
    记录类型:CNAME; 主机记录:blog 记录值:paotime.github.io. #注意这个点`.`
    ```


## 日常博客管理流程

### 日常修改

在本地对博客进行修改(添加新博文、修改样式等等)后,通过下面的流程进行管理:

- 依次执行`git add .`、`git commit -m “…”`、`git push origin hexo`指令将改动推送到GitHub(此时当前分支应为hexo);  
- 然后再执行`hexo g -d`发布网站到master分支上.

虽然两个过程顺序调转一般不会有问题,不过逻辑上这样的顺序是绝对没问题的(例如突然死机要重装了,悲催….的情况,调转顺序就有问题了).

### 本地资料丢失

当重装电脑之后,或者想在其他电脑上修改博客,可以使用下列步骤:

- 使用`git clone https://github.com/yaro97/yaro97.github.io.git`拷贝仓库(默认分支为hexo)；
- 在本地新拷贝的`yaro97.github.io`文件夹下通过`Git bash`依次执行下列指令:`npm install hexo-cli -g`-`npm install`-`npm install hexo-deployer-git --save`(**记得,不需要`hexo init`这条指令)**.
