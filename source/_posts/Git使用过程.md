---
title: Git使用过程
tags:
- Git
- Github
---
本文其实只是自己的操作备忘啦啦啦..   
Git是什么？Git是目前世界上最先进的分布式版本控制系统（没有之一）。   
Git有什么特点？简单来说就是：高端大气上档次！  GIt只能跟踪文本文件的改动,图片/视频等多媒体就算了吧,还有MSword是二进制文件,也不可以的..
balabala...

详细教程请[参考网站](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

## 安装git

- linux安装

	```
	sudo apt install git
	```  

	> 早期的版本都是安装git-core,因为git=GNU interactive Tools,后来由于git名气太大,就用git了.

- windows安装

	在 Windows 上安装 Git 同样轻松，有个叫做 `msysGit`的项目提供了安装包，可以到 GitHub 的页面上下载 exe 安装文件并运行:http://msysgit.github.com/

	> 说明:不要用记事本编辑任何文本文件,Microsoft开发记事本的团队使用了一个非常弱智的行为来保存UTF-8编码的文件，他们自作聪明地在每个文件开头添加了0xefbbbf（十六进制）的字符，你会遇到很多不可思议的问题.


## 配置

因为Git是分布式版本控制系统，所以，每个机器都必须自报家门：你的名字和Email地址。你也许会担心，如果有人故意冒充别人怎么办？这个不必担心，首先我们相信大家都是善良无知的群众，其次，真的有冒充的也是有办法可查的。

配置文件目录  
linux在:`/etc/gitconfig` 和 `~/.gitconfig`  
wins在:`C:\Documents and Settings\$USER`  
可以在目录中直接编辑,也可以通过相应命令来配置.

```
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

注意`git config`命令的`--global`参数，用了这个参数，表示你这台机器上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Email地址。

此外还可以设置默认文本编辑器/差异分析工具/配色等等

```
git config --global core.editor emacs
git config --global merge.tool vimdiff
```

## 创建仓库(repository/版本库)

首先我们需要知道三个概念：`工作区(Working Directory)`、`版本库(Repository)`、`暂存区(Stage or index)`.

工作区-当你在开发一个项目时，主目录就是你的工作区。  

版本库-工作区中有一个隐藏目录.git，这个就是git的版本库了。  

暂存区-Git的版本库里存了很多文件，其中包括称为Stage或index的暂存区，还有一个git为我们自动创建的第一个分支master，以及指向master的一个指针HEAD。如下图:  

![](http://7u2o1q.com1.z0.glb.clouddn.com/git%E4%B8%89%E4%B8%AA%E5%8C%BA%E7%A4%BA%E6%84%8F%E5%9B%BE.jpg)

- 命令行进入已存在或新建的`目录`,(windows需要右键`Git bash here`)  
	`友情提示`:记得使用英文目录哦
- 通过初始化将当前目录变成Git管理的仓库  
	使用`git init`命令;将目录变成可以管理的仓库，细心的读者可以发现当前目录下多了一个`.git`的目录，这个目录是Git来跟踪管理版本库的，没事就不要修改这个目录，免得Git仓库给破坏了。

- 添加相应文件到缓存区,并提交到仓库.
	如:

	```
	git add file1.txt
	git add file2.txt file3.txt
	git commit -m "add 3 files."
	```

	> `git add -A` =>保存所有的修改.  
	> `git add .` =>保存新的添加和修改，但是不包括删除.  
	> `git add -u`=>保存修改和删除，但是不包括新建文件.

## 时光机穿梭

提交修改和提交新文件是一样的两步，第一步是`git add`,第二部是`git commit -m "add distributed"`  

要随时掌握工作区的状态，使用`git status`命令。  

如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容。

- 版本回退

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

- 工作区和暂存区

	工作区+git版本库{暂存区+N个分支(分支+指向分支的指针HEAD)}

	为什么说Git管理的是修改，而不是文件呢？`文件`修改后提交,是不会在库里有修改记录的,必须把`修改`,`git add`后才能用`git status`查询.

- 撤销修改

	场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令`git checkout -- file`。

	场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD file`，就回到了场景1，第二步按场景1操作。

	场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。

- 删除文件

	确实要从版本库中删除该文件，那就用命令`git rm`删掉，并且`git commit`

	另一种情况是删错了，因为版本库里还有呢，所以可以很轻松地把误删的文件恢复到最新版本  
	`git checkout -- test.txt`  
	`git checkout`其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。

## 远程仓库

为什么GitHub需要SSH Key呢？因为GitHub需要识别出你推送的提交确实是你推送的，而不是别人冒充的，而Git支持SSH协议，所以，GitHub只要知道了你的公钥，就可以确认只有你自己才能推送。

- 添加远程库

	要关联一个远程库，使用命令`git remote add origin 仓库地址`；

	关联后，使用命令`git push -u origin master`第一次推送master分支的所有内容；

	此后，每次本地提交后，只要有必要，就可以使用命令`git push origin master`推送最新修改；

- 从远程库克隆

	要克隆一个仓库，首先必须知道仓库的地址，然后使用`git clone 仓库地址`命令克隆。  
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
用`git log --graph --pretty=oneline --abbrev-commit`命令可以看到分支合并图。

### 分支管理策略

在实际开发中，我们应该按照几个基本原则进行分支管理：

首先，master分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；

那在哪干活呢？干活都在dev分支上，也就是说，dev分支是不稳定的，到某个时候，比如1.0版本发布时，再把dev分支合并到master上，在master分支发布1.0版本；

你和你的小伙伴们每个人都在dev分支上干活，每个人都有自己的分支，时不时地往dev分支上合并就可以了。

所以，团队合作的分支看起来就像这样：

![](http://www.liaoxuefeng.com/files/attachments/001384909239390d355eb07d9d64305b6322aaf4edac1e3000/0)

### Bug分支

突然接到任务要修复代号101的bug,很自然,你想创建一个分支`issue-101`来修复,但是当前`dev`分支上的工作还没有提交,并不是你不想提交，而是工作只进行到一半，还没法提交，预计完成还需1天时间。但是，必须在两个小时内修复该bug，怎么办？

```
git status #查看到在`dev`分支上的工作没有提交
git stash #把当前工作现场“储藏”起来

git checkout master #切换到master分支
git checkout -b issue-101 #创建并切换到`issue-101`分支
git add readme.txt  #修复bug后增加相应文件
git commit -m "fix bug 101" #提交
git checkout master #切换到master分支
git merge --no-ff -m "merged bug fix 101" issue-101 #将`issue-101`分支合并到master分支
git branch -d issue-101 #删除`issue-101`分支

#太棒了，原计划两个小时的bug修复只花了5分钟！现在，是时候接着回到dev分支干活了！
git checkout dev
git status

#工作区是干净的，刚才的工作现场存到哪去了？用git stash list命令看看：
git stash list #查看刚才的工作现场存到哪去了?
git stash pop #恢复工作现场继续工作
```

### Feature分支

添加一个新功能时，你肯定不希望因为一些实验性质的代码，把主分支搞乱了，所以，每添加一个新功能，最好新建一个feature分支，在上面开发，完成后，合并，最后，删除该feature分支。

现在，你终于接到了一个新任务：开发代号为Vulcan的新功能，该功能计划用于下一代星际飞船。

于是准备开发：

```
git checkout -b feature-vulcan

#5分钟后，开发完毕：
git add vulcan.py
git status
git commit -m "add feature vulcan"
git checkout dev #切换到`dev`分支,准备合并
git merge feature-vulcan #将`feature-vulcan`分支合并到 `dev`分支
```


### 多人协作

查看远程库信息，使用`git remote`或`git remote -v`(更详细)；

本地新建的分支如果不推送到远程，对其他人就是不可见的；

从本地推送分支，使用`git push origin branch-name`，如果推送失败，先用`git pull`抓取远程的新提交；

在本地创建和远程分支对应的分支，使用`git checkout -b branch-name origin/branch-name`，本地和远程分支的名称最好一致；

建立本地分支和远程分支的关联，使用`git branch --set-upstream branch-name origin/branch-name`；

从远程抓取分支，使用`git pull`，如果有冲突，要先处理冲突。

## 标签管理

请把上周一的那个版本打包发布，commit号是`6a5819e...`一串乱七八糟的数字不好找！请把上周一的那个版本打包发布，版本号是v1.2,“好的，按照tag v1.2查找commit就行！所以，tag就是一个让人容易记住的有意义的名字，它跟某个commit绑在一起。

- 创建标签

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

- 操作标签

	命令`git push origin <tagname>`可以推送一个本地标签；  
	命令`git push origin --tags`可以推送全部未推送过的本地标签；  
	命令`git tag -d <tagname>`可以删除一个本地标签；  
	命令`git push origin :refs/tags/<tagname>`可以删除一个远程标签。  

## 使用github

在GitHub上，可以任意Fork开源仓库；  
自己拥有Fork后的仓库的读写权限；  
可以推送pull request给官方仓库来贡献代码。

![](http://www.liaoxuefeng.com/files/attachments/001384926554932eb5e65df912341c1a48045bc274ba4bf000/0)

## 自定义git

- 忽略特殊文件

	有些时候，你必须把某些文件放到Git工作目录中，但又不能提交它们，比如保存了数据库密码的配置文件啦，等等，每次`git status`都会显示`Untracked files ...`，有强迫症的童鞋心里肯定不爽。

	好在Git考虑到了大家的感受，这个问题解决起来也很简单，在Git工作区的根目录下创建一个特殊的`.gitignore文件，然后把要忽略的文件名填进去，Git就会自动忽略这些文件。

	忽略某些文件时，需要编写.gitignore；  
	`.gitignore`文件本身要放到版本库里，并且可以对`.gitignore`做版本管理！

- 设置别名

	给Git配置好别名，就可以输入命令时偷个懒。我们鼓励偷懒。

- 搭建Git服务器

	针对于自己公司非开源的项目.

	搭建Git服务器非常简单，通常10分钟即可完成；  
