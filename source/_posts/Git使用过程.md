---
title: Git使用过程
tags:
- Git
- Github
---
本教程只会让你成为Git用户，不会让你成为Git专家。很多Git命令只有那些专家才明白（事实上我也不明白，因为我不是Git专家），但我保证这些命令可能你一辈子都不会用到。既然Git是一个工具，就没必要把时间浪费在那些“高级”但几乎永远不会用到的命令上。一旦你真的非用不可了，到时候再自行Google或者请教专家也未迟。

[参考网站](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

## 安装git

### linux安装

`sudo apt install git`  
早期的版本都是安装git-core,因为git=GNU interactive Tools,后来由于git名气太大,就用git了.

### windows安装

在 Windows 上安装 Git 同样轻松，有个叫做 msysGit 的项目提供了安装包，可以到 GitHub 的页面上下载 exe 安装文件并运行:http://msysgit.github.com/
完成安装之后，就可以使用命令行的 git 工具（已经自带了 ssh 客户端）了，另外还有一个图形界面的 Git 项目管理工具。

## 配置

配置文件目录
linux:`/etc/gitconfig` 和 `~/.gitconfig`
wins:`C:\Documents and Settings\$USER`

<!-- more -->

```
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

因为Git是分布式版本控制系统，所以，每个机器都必须自报家门：你的名字和Email地址。你也许会担心，如果有人故意冒充别人怎么办？这个不必担心，首先我们相信大家都是善良无知的群众，其次，真的有冒充的也是有办法可查的。

注意`git config`命令的`--global`参数，用了这个参数，表示你这台机器上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Email地址。

此外还可以设置默认文本编辑器和差异分析工具

```
git config --global core.editor emacs
git config --global merge.tool vimdiff
```

## 创建仓库(repository/版本库)

### 选择合适的地方创建空目录

```
mkdir learngit
cd learngit
pwd
```

### 初始化一个Git仓库

使用`git init`命令;将目录变成可以管理的仓库
瞬间Git就把仓库建好了，而且告诉你是一个空的仓库（empty Git repository），细心的读者可以发现当前目录下多了一个`.git`的目录，这个目录是Git来跟踪管理版本库的，没事千万不要手动修改这个目录里面的文件，不然改乱了，就把Git仓库给破坏了。

### 把文件添加到版本库
第一步，使用命令`git add <file>`，注意，可反复多次使用，添加多个文件；
第二步，使用命令`git commit`，完成。如:

```
git add file1.txt
git add file2.txt file3.txt
git commit -m "add 3 files."
```

说明:不要用记事本编辑任何文本文件,Microsoft开发记事本的团队使用了一个非常弱智的行为来保存UTF-8编码的文件，他们自作聪明地在每个文件开头添加了0xefbbbf（十六进制）的字符，你会遇到很多不可思议的问题.
GIt只能跟踪文本文件的改动,word(二进制文件)不可以

## 时光机穿梭

提交修改和提交新文件是一样的两步，第一步是`git add`,第二部是`git commit -m "add distributed"`  
要随时掌握工作区的状态，使用`git status`命令。  
如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容。

### 版本回退

```
git log #可以查看每次提交改动的历史记录
git log --pretty=oneline #可以一行显示一条
git reset --hard HEAD^ #退回当前版本的上一个版本
git reset --hard HEAD^^ #退回当前版本的上两个版本
git reset --hard HEAD~100 #退回当前版本的上100个版本
git reset --hard 3628164...... #退回commit id为3628164开头的那个版本(可以不写完)
```

HEAD指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令`git reset --hard commit_id`。  
穿梭前，用`git log`可以查看提交历史，以便确定要回退到哪个版本。  
要重返未来，用`git reflog`查看命令历史，以便确定要回到未来的哪个版本。  

### 工作区和暂存区

工作区+git版本库{暂存区+N个分支(分支+指向分支的指针HEAD)}

为什么说Git管理的是修改，而不是文件呢？`文件`修改后提交,是不会在库里有修改记录的,必须把`修改`,`git add`后才能用`git status`查询.

### 撤销修改

场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令`git checkout -- file`。

场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD file`，就回到了场景1，第二步按场景1操作。

场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。

### 删除文件

确实要从版本库中删除该文件，那就用命令`git rm`删掉，并且`git commit`

另一种情况是删错了，因为版本库里还有呢，所以可以很轻松地把误删的文件恢复到最新版本  
`$ git checkout -- test.txt`  
`git checkout`其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。

## 远程仓库

### 添加远程库

为什么GitHub需要SSH Key呢？因为GitHub需要识别出你推送的提交确实是你推送的，而不是别人冒充的，而Git支持SSH协议，所以，GitHub只要知道了你的公钥，就可以确认只有你自己才能推送。

要关联一个远程库，使用命令`git remote add origin git@server-name:path/repo-name.git`；

关联后，使用命令`git push -u origin master`第一次推送master分支的所有内容；

此后，每次本地提交后，只要有必要，就可以使用命令`git push origin master`推送最新修改；

分布式版本系统的最大好处之一是在本地工作完全不需要考虑远程库的存在，也就是有没有联网都可以正常工作，而SVN在没有联网的时候是拒绝干活的！当有网络的时候，再把本地提交推送一下就完成了同步，真是太方便了！

### 从远程库克隆

要克隆一个仓库，首先必须知道仓库的地址，然后使用`git clone`命令克隆。  
Git支持多种协议，包括https，但通过ssh支持的原生git协议速度最快。

## 分支管理

### 创建与合并分支

Git鼓励大量使用分支：
查看分支：`git branch`
创建分支：`git branch <name>`
切换分支：`git checkout <name>`
创建+切换分支：`git checkout -b <name>`
合并某分支到当前分支：`git merge <name>`
删除分支：`git branch -d <name>`

### 解决冲突

当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。
用git log --graph命令可以看到分支合并图。

### 分支管理策略

Git分支十分强大，在团队开发中应该充分应用。  
合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。

### Bug分支

修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除；  
当手头工作没有完成时，先把工作现场git stash一下，然后去修复bug，修复后，再git stash pop，回到工作现场。

### Feature分支

开发一个新feature，最好新建一个分支；  
如果要丢弃一个没有被合并过的分支，可以通过git branch -D `<name>`强行删除。

### 多人协作

查看远程库信息，使用`git remote -v`；

本地新建的分支如果不推送到远程，对其他人就是不可见的；

从本地推送分支，使用`git push origin branch-name`，如果推送失败，先用`git pull`抓取远程的新提交；

在本地创建和远程分支对应的分支，使用`git checkout -b branch-name origin/branch-name`，本地和远程分支的名称最好一致；

建立本地分支和远程分支的关联，使用`git branch --set-upstream branch-name origin/branch-name`；

从远程抓取分支，使用`git pull`，如果有冲突，要先处理冲突。

## 标签管理

请把上周一的那个版本打包发布，commit号是6a5819e...一串乱七八糟的数字不好找！请把上周一的那个版本打包发布，版本号是v1.2,“好的，按照tag v1.2查找commit就行！所以，tag就是一个让人容易记住的有意义的名字，它跟某个commit绑在一起。

### 创建标签

```
git branch #查看所有分支
git checkout master #切换到需要打标签的分支上
git tag v1.0 #打一个新标签
git tag #查看所有标签
git tag v0.9 `<commit id>` #可以对历史某个commit打标签
```

命令`git tag <name>`用于新建一个标签，默认为HEAD，也可以指定一个commit id；
`git tag -a <tagname> -m "blablabla..."`可以指定标签信息；
`git tag -s <tagname> -m "blablabla..."`可以用PGP签名标签；
命令`git tag`可以查看所有标签。

### 操作标签

命令`git push origin <tagname>`可以推送一个本地标签；  
命令`git push origin --tags`可以推送全部未推送过的本地标签；  
命令`git tag -d <tagname>`可以删除一个本地标签；  
命令`git push origin :refs/tags/<tagname>`可以删除一个远程标签。  

## 使用github

在GitHub上，可以任意Fork开源仓库；  
自己拥有Fork后的仓库的读写权限；  
可以推送pull request给官方仓库来贡献代码。

## 自定义git

### 忽略特殊文件

忽略某些文件时，需要编写.gitignore；  
.gitignore文件本身要放到版本库里，并且可以对.gitignore做版本管理！

### 设置别名

给Git配置好别名，就可以输入命令时偷个懒。我们鼓励偷懒。

### 搭建Git服务器

针对于自己公司非开源的项目.

搭建Git服务器非常简单，通常10分钟即可完成；  
要方便管理公钥，用Gitosis；  
要像SVN那样变态地控制权限，用Gitolite。
