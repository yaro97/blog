---
title: 第1篇-初识Py
date: 2017-07-15 15:02:47
tags:
- python
---
### Python简介 

#### Python前世今生

python的创始人为吉多·范罗苏姆（Guido van Rossum）。1989年的圣诞节期间，吉多·范罗苏姆为了在阿姆斯特丹打发时间，决心开发一个新的脚本解释程序，作为ABC语言的一种继承。  

最新的TIOBE排行榜，Python赶超PHP占据第五！！！

Python可以应用于众多领域，如：数据分析、组件集成、网络服务、图像处理、数值计算和科学计算等众多领域。目前业内几乎所有大中型互联网企业都在使用Python，如：Youtube、Dropbox、BT、Quora（中国知乎）、豆瓣、知乎、Google、Yahoo!、Facebook、NASA、百度、腾讯、汽车之家、美团等。互联网公司广泛使用Python来做的事一般有：**自动化运维**、**自动化测试**、**大数据分析、爬虫、Web 等。**

> 一言以蔽之：Python屌屌哒...

#### Python和其他语言对比

C语言： 代码编译得到 机器码 ，机器码在处理器上直接执行，每一条指令控制CPU工作

<!-- more -->

其他语言： 代码编译得到 字节码 ，虚拟机执行字节码并转换成机器码再后在处理器上执行

- Python 和 C  Python这门语言是由C开发而来

  对于使用：Python的类库齐全并且使用简洁，如果要实现同样的功能，Python 10行代码可以解决，C可能就需要100行甚至更多.
  对于速度：Python的运行速度相较与C，绝逼是慢了

- Python 和 Java、C#等

　　对于使用：Linux原装Python，其他语言没有；以上几门语言都有非常丰富的类库支持
　　对于速度：Python在速度上**可能**稍显逊色

所以，Python和其他语言没有什么本质区别，其他区别在于：擅长某领域、人才丰富、先入为主。

#### Python的种类

- Cpython
  Python的官方版本，使用C语言实现，使用最为广泛，CPython实现会将源文件（py文件）转换成字节码文件（pyc文件），然后运行在Python虚拟机上。
- Jyhton
  Python的Java实现，Jython会将Python代码动态编译成Java字节码，然后在JVM上运行。
- IronPython
  Python的C#实现，IronPython将Python代码编译成C#字节码，然后在CLR上运行。（与Jython类似）
- PyPy（特殊）
  Python实现的Python，将Python的字节码字节码再编译成机器码。
- RubyPython、Brython ...

PyPy，在Python的基础上对Python的字节码进一步处理，从而提升执行速度！

<img src="https://i.loli.net/2017/07/13/5966ab032400e.png" alt="PyPy速度优势" title="" width="650px" />

### Python环境 

#### 安装Python

- windows：

  1、下载安装包:https://www.python.org/downloads/

  2、安装:

  3、环境变量

- linux：

  基本默认都安装,使用`apt`(或其他)工具直接安装即可,需要特定版本的,自己编译(基于C语言,使用gcc)

- iPython

  建议使用`iPython`,智能提示,还可以输入使用`shell`命令;重要的是提供`history`命令,在命令行调试好之后,直接辅助相应的代码到IDE即可.

#### 更新Python及设置默认版本

- windows:

  卸载重装即可更新

- linux:

  默认安装的python可能存在以来关系,不建议卸载,建议重复安装;

- 设置默认版本

  windows下通过环境变量,linux可以下通过`软连接`

### Python 入门

#### 一、第一句Python代码

在 /home/dev/ 目录下创建 hello.py 文件，内容如下：

```python
print "hello,world"
```

执行 hello.py 文件，即： 

```sh
python /home/dev/hello.py
```

python内部执行过程如下：

<img src="https://i.loli.net/2017/07/13/5966b0da1560a.png" alt="Python内部执行过程" width="700"  />

#### 二、解释器

上一步中执行 python /home/dev/hello.py 时，明确的指出 hello.py 脚本由 python 解释器来执行。

如果想要类似于执行shell脚本一样执行python脚本，例： `./hello.py `，那么就需要在 hello.py 文件的头部指定解释器，如下：

```python
#!/usr/bin/env python
print "hello,world"
```

> 说明:通过env指定比通过python执行文件路径指定要好,不同机器python安装路径可能不同

如此一来，执行： .`/hello.py` 即可。

ps：执行前需给予 hello.py 执行权限，`chmod +x hello.py`

#### 三、内容编码

python解释器在加载 .py 文件中的代码时，会对内容进行编码（默认ascill）

ASCII（American Standard Code for Information Interchange，美国标准信息交换代码）是基于拉丁字母的一套电脑编码系统，主要用于显示现代英语和其他西欧语言，其最多只能用 8 位来表示（一个字节），即：2**8 = 256，所以，ASCII码最多只能表示 256 个符号。

ASCII码对照表: https://zh.wikipedia.org/wiki/ASCII

显然ASCII码无法将世界上的各种文字和符号全部表示，所以，就需要新出一种可以代表所有字符和符号的编码，即：Unicode

Unicode（统一码、万国码、单一码）是一种在计算机上使用的字符编码。Unicode 是为了解决传统的字符编码方案的局限而产生的，它为每种语言中的每个字符设定了统一并且唯一的二进制编码，规定虽有的字符和符号最少由 16 位来表示（2个字节），即：2 **16 = 65536，
注：此处说的的是最少2个字节，可能更多

UTF-8，是对Unicode编码的压缩和优化，他不再使用最少使用2个字节，而是将所有的字符和符号进行分类：ascii码中的内容用1个字节保存、欧洲的字符用2个字节保存，**东亚的字符用3个字节保存**...

所以，python解释器在加载 .py 文件中的代码时，会对内容进行编码（默认ascill），如果是如下代码的话：

报错：ascii码无法表示中文

```python
#!/usr/bin/env python
print "你好，世界"
```

改正：应该显示的告诉python解释器，用什么编码来执行源代码，即：

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
print "你好，世界"
```

#### 四、注释

单行注释：` # 被注释内容`

多行注释：`""" 被注释内容 """`

#### 五、执行脚本传入参数

Python有大量的模块，从而使得开发Python程序非常简洁。类库有包括三种：

- Python内部提供的模块
- 业内开源的模块
- 程序员自己开发的模块

Python内部提供一个 sys 的模块，其中的 sys.argv 用来捕获执行执行python脚本时传入的参数

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
print sys.argv
```

#### 六、 pyc 文件

执行Python代码时，如果导入了其他的 .py 文件，那么，执行过程中会自动生成一个与其同名的 .pyc 文件，该文件就是Python解释器编译之后产生的字节码。

ps：代码经过编译可以产生字节码；字节码通过反编译也可以得到代码。

#### 七、变量

1、声明变量: `name = "wupeiqi"`,变量名为： name，变量name的值为："wupeiqi"

变量的作用：昵称，其代指内存里某个地址中保存的内容:

<img src="https://i.loli.net/2017/07/13/5966b9c2eeab5.png" alt="声明变量原理" width="400"/>

变量定义的规则：

- 变量名只能是 字母、数字或下划线的任意组合
- 变量名的第一个字符不能是数字
- 以下关键字不能声明为变量名
  ['and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'exec', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'not', 'or', 'pass', 'print', 'raise', 'return', 'try', 'while', 'with', 'yield']

2、变量的赋值

```python
name1 = "yaro"
name2 = "alex"
```

<img src="https://i.loli.net/2017/07/13/5966ba6563058.png" alt="" width="400px">

```python
name1 = "yaro"
name2 = name
```

<img src="https://i.loli.net/2017/07/13/5966baade2c28.png" alt="" width="400px">

#### 八、输入

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 将用户输入的内容赋值给 name 变量
name = raw_input("请输入用户名：")
#python3的输入为 input
# 打印输入的内容
print name
```

输入密码时，如果想要不可见，需要利用getpass 模块中的 getpass方法，即：

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
  
import getpass
  
# 将用户输入的内容赋值给 name 变量
pwd = getpass.getpass("请输入密码：")
  
# 打印输入的内容
print pwd
```

#### 九、流程控制和缩进

**需求一、用户登陆验证**

```python
#!/usr/bin/env python
# -*- coding: encoding -*-
  
# 提示输入用户名和密码
# 验证用户名和密码
#     如果错误，则输出用户名或密码错误
#     如果成功，则输出 欢迎，XXX!
 
import getpass
name = raw_input('请输入用户名：')
pwd = getpass.getpass('请输入密码：')
  
if name == "alex" and pwd == "cmd":
    print "欢迎，alex！"
else:
    print "用户名和密码错误"
```

**需求二、根据用户输入内容输出其权限**

```python
# 根据用户输入内容打印其权限
  
# alex --> 超级管理员
# eric --> 普通管理员
# tony,rain --> 业务主管
# 其他 --> 普通用户
name = raw_input('请输入用户名：')
if name == "alex"：
    print "超级管理员"
elif name == "eric":
    print "普通管理员"
elif name == "tony" or name == "rain":
    print "业务主管"
else:
    print "普通用户"
```

#### 十、while循环

1、基本循环

```python
while 条件:
    # 循环体
```

2、break

break用于退出循环

```python
while True:
    print "123"
    break
    print "456"
```

3、continue

continue用于退出当前循环，继续下一次循环

```python
while True:
    print "123"
    continue
    print "456"
```

### 练习题

1、使用while循环输入 1 2 3 4 5 6     8 9 10

2、求1-100的所有数的和

3、输出 1-100 内的所有奇数

4、输出 1-100 内的所有偶数

5、求1-2+3-4+5 ... 99的所有数的和

6、用户登陆（三次机会重试）