---
title: 第5篇-Py模块
tags:
- python
---
模块，用一砣代码实现了某个功能的代码集合。 

类似于函数式编程和面向过程编程，函数式编程则完成一个功能，其他代码用来调用即可，提供了代码的重用性和代码间的耦合。而对于一个复杂的功能来，可能需要多个函数才能完成（函数又可以在不同的.py文件中），n个 .py 文件组成的代码集合就称为模块。

如：os 是系统相关的模块；file是文件操作相关的模块

模块分为三种：

自定义模块
第三方模块
内置模块

### 自定义模块

#### 1、定义模块

情景一：

<img src="https://i.loli.net/2017/07/14/5968086a36b7a.png" width="400px">

<!-- more -->

情景二：

<img src="https://i.loli.net/2017/07/14/596808a09535b.png" width="400px">

情景三：

<img src="https://i.loli.net/2017/07/14/596808ad82a32.png" width="400px">

#### 2、导入模块

Python之所以应用越来越广泛，在一定程度上也依赖于其为程序员提供了大量的模块以供使用，如果想要使用模块，则需要导入。导入模块有一下几种方法：

```python
import module
from module.xx.xx import xx
from module.xx.xx import xx as rename 
from module.xx.xx import *
```

导入模块其实就是告诉Python解释器去解释那个py文件

- 导入一个py文件，解释器解释该py文件
- 导入一个包，解释器解释该包下的 __init__.py 文件 【py2.7】

那么问题来了，导入模块时是根据那个路径作为基准来进行的呢？即：sys.path

```python
import sys
print sys.path
# 结果：显示当前的python环境变量
```

如果sys.path路径列表没有你想要的路径，可以通过 sys.path.append('路径') 添加。

```python
import sys
import os
project_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(project_path)
```

### 内置模块

内置模块是Python自带的功能，在使用内置模块相应的功能时，需要【先导入】再【使用】

#### 一、sys

用于提供对Python解释器相关的操作：

```python
sys.argv           #命令行参数List，第一个元素是程序本身路径
sys.exit(n)        #退出程序，正常退出时exit(0)
sys.version        #获取Python解释程序的版本信息
sys.maxint         #最大的Int值
sys.path           #返回模块的搜索路径，初始化时使用PYTHONPATH环境变量的值
sys.platform       #返回操作系统平台名称
sys.stdin          #输入相关
sys.stdout         #输出相关
sys.stderror       #错误相关
```

进度百分比

```python
import sys
import time

def view_bar(num, total):
    rate = float(num) / float(total)
    rate_num = int(rate * 100)
    r = '\r%d%%' % (rate_num, )
    sys.stdout.write(r)
    sys.stdout.flush()

if __name__ == '__main__':
    for i in range(0, 100):
        time.sleep(0.1)
        view_bar(i, 100)
```

#### 二、os

用于提供系统级别的操作：

```python
os.getcwd()                 #获取当前工作目录，即当前python脚本工作的目录路径
os.chdir("dirname")         #改变当前脚本工作目录；相当于shell下cd
os.curdir                   #返回当前目录: ('.')
os.pardir                   #获取当前目录的父目录字符串名：('..')
os.makedirs('dir1/dir2')    #可生成多层递归目录
os.removedirs('dirname1')   #若目录为空，则删除，并递归到上一级目录，如若也为空，则删除，依此类推
os.mkdir('dirname')         #生成单级目录；相当于shell中mkdir dirname
os.rmdir('dirname')         #删除单级空目录，若目录不为空则无法删除，报错；相当于shell中rmdir dirname
os.listdir('dirname')       #列出指定目录下的所有文件和子目录，包括隐藏文件，并以列表方式打印
os.remove()                 #删除一个文件
os.rename("oldname","new")  #重命名文件/目录
os.stat('path/filename')    #获取文件/目录信息
os.sep                      #操作系统特定的路径分隔符，win下为"\\",Linux下为"/"
os.linesep                  #当前平台使用的行终止符，win下为"\t\n",Linux下为"\n"
os.pathsep                  #用于分割文件路径的字符串
os.name                     #字符串指示当前使用平台。win->'nt'; Linux->'posix'
os.system("bash command")   #运行shell命令，直接显示
os.environ                  #获取系统环境变量
os.path.abspath(path)       #返回path规范化的绝对路径
os.path.split(path)         #将path分割成目录和文件名二元组返回
os.path.dirname(path)       #返回path的目录。其实就是os.path.split(path)的第一个元素
os.path.basename(path)      #返回path最后的文件名。如何path以／或\结尾，那么就会返回空值。即os.path.split(path)的第二个元素
os.path.exists(path)        #如果path存在，返回True；如果path不存在，返回False
os.path.isabs(path)         #如果path是绝对路径，返回True
os.path.isfile(path)        #如果path是一个存在的文件，返回True。否则返回False
os.path.isdir(path)         #如果path是一个存在的目录，则返回True。否则返回False
os.path.join(path1[, path2[, ...]])  #将多个路径组合后返回，第一个绝对路径之前的参数将被忽略
os.path.getatime(path)      #返回path所指向的文件或者目录的最后存取时间
os.path.getmtime(path)      #返回path所指向的文件或者目录的最后修改时间
```

#### 三、hashlib

用于加密相关的操作，代替了md5模块和sha模块，主要提供 SHA1, SHA224, SHA256, SHA384, SHA512 ，MD5 算法

```python
import hashlib
 
# ######## md5 ########
hash = hashlib.md5()
# help(hash.update)
hash.update(bytes('admin', encoding='utf-8'))
print(hash.hexdigest())
print(hash.digest())
 
######## sha1 ########
 
hash = hashlib.sha1()
hash.update(bytes('admin', encoding='utf-8'))
print(hash.hexdigest())
 
# ######## sha256 ########
 
hash = hashlib.sha256()
hash.update(bytes('admin', encoding='utf-8'))
print(hash.hexdigest())
 
# ######## sha384 ########
 
hash = hashlib.sha384()
hash.update(bytes('admin', encoding='utf-8'))
print(hash.hexdigest())
 
# ######## sha512 ########
 
hash = hashlib.sha512()
hash.update(bytes('admin', encoding='utf-8'))
print(hash.hexdigest())
```

以上加密算法虽然依然非常厉害，但时候存在缺陷，即：通过撞库可以反解。所以，有必要对加密算法中添加自定义key再来做加密。

```python
import hashlib
 
# ######## md5 ########
 
hash = hashlib.md5(bytes('898oaFs09f',encoding="utf-8"))
hash.update(bytes('admin',encoding="utf-8"))
print(hash.hexdigest())
```

python内置还有一个 hmac 模块，它内部对我们创建 key 和 内容 进行进一步的处理然后再加密

```python
import hmac
 
h = hmac.new(bytes('898oaFs09f',encoding="utf-8"))
h.update(bytes('admin',encoding="utf-8"))
print(h.hexdigest())
```

#### 四、random

```python
import random
 
print(random.random())
print(random.randint(1, 2))
print(random.randrange(1, 10))
```

随机验证码

```python
import random
checkcode = ''
for i in range(4):
    current = random.randrange(0,4)
    if current != i:
        temp = chr(random.randint(65,90))
    else:
        temp = random.randint(0,9)
    checkcode += str(temp)
print checkcode
```

#### 五、re

python中re模块提供了正则表达式相关操作

字符：

　　. 匹配除换行符以外的任意字符
　　\w	匹配字母或数字或下划线或汉字
　　\s	匹配任意的空白符
　　\d	匹配数字
　　\b	匹配单词的开始或结束
　　^	匹配字符串的开始
　　$	匹配字符串的结束

次数：

  * 重复零次或更多次
      +重复一次或更多次
      　　?重复零次或一次
      　　{n}重复n次
      　　{n,}重复n次或更多次
      　　{n,m}重复n到m次

##### match

从起始位置开始匹配，匹配成功返回一个对象，未匹配成功返回None

```python
match(pattern, string, flags=0)
 # pattern： 正则模型
 # string ： 要匹配的字符串
 # falgs  ： 匹配模式
     X  VERBOSE     Ignore whitespace and comments for nicer looking RE's.
     I  IGNORECASE  Perform case-insensitive matching.
     M  MULTILINE   "^" matches the beginning of lines (after a newline)
                    as well as the string.
                    "$" matches the end of lines (before a newline) as well
                    as the end of the string.
     S  DOTALL      "." matches any character at all, including the newline.
 
     A  ASCII       For string patterns, make \w, \W, \b, \B, \d, \D
                    match the corresponding ASCII character categories
                    (rather than the whole Unicode categories, which is the
                    default).
                    For bytes patterns, this flag is the only available
                    behaviour and needn't be specified.
      
     L  LOCALE      Make \w, \W, \b, \B, dependent on the current locale.
     U  UNICODE     For compatibility only. Ignored for string patterns (it
                    is the default), and forbidden for bytes patterns.
```

实例

```python
        # 无分组
        r = re.match("h\w+", origin)
        print(r.group())     # 获取匹配到的所有结果
        print(r.groups())    # 获取模型中匹配到的分组结果
        print(r.groupdict()) # 获取模型中匹配到的分组结果

        # 有分组

        # 为何要有分组？提取匹配成功的指定内容（先匹配成功全部正则，再匹配成功的局部内容提取出来）

        r = re.match("h(\w+).*(?P<name>\d)$", origin)
        print(r.group())     # 获取匹配到的所有结果
        print(r.groups())    # 获取模型中匹配到的分组结果
        print(r.groupdict()) # 获取模型中匹配到的分组中所有执行了key的组
```

##### search

浏览整个字符串去匹配第一个，未匹配成功返回None.`search(pattern, string, flags=0)`

```python
        # 无分组

        r = re.search("a\w+", origin)
        print(r.group())     # 获取匹配到的所有结果
        print(r.groups())    # 获取模型中匹配到的分组结果
        print(r.groupdict()) # 获取模型中匹配到的分组结果

        # 有分组

        r = re.search("a(\w+).*(?P<name>\d)$", origin)
        print(r.group())     # 获取匹配到的所有结果
        print(r.groups())    # 获取模型中匹配到的分组结果
        print(r.groupdict()) # 获取模型中匹配到的分组中所有执行了key的组
```

##### findall

获取非重复的匹配列表；如果有一个组则以列表形式返回，且每一个匹配均是字符串；如果模型中有多个组，则以列表形式返回，且每一个匹配均是元祖；空的匹配也会包含在结果中.`findall(pattern, string, flags=0)`

```python
        # 无分组
        r = re.findall("a\w+",origin)
        print(r)

        # 有分组
        origin = "hello alex bcd abcd lge acd 19"
        r = re.findall("a((\w*)c)(d)", origin)
        print(r)
```

##### sub

```python
# sub，替换匹配成功的指定位置字符串
 
sub(pattern, repl, string, count=0, flags=0)
# pattern： 正则模型
# repl   ： 要替换的字符串或可执行对象
# string ： 要匹配的字符串
# count  ： 指定匹配个数
# flags  ： 匹配模式python
```

```python
        # 与分组无关

        origin = "hello alex bcd alex lge alex acd 19"
        r = re.sub("a\w+", "999", origin, 2)
        print(r)
```

##### split

```python
# split，根据正则匹配分割字符串
 
split(pattern, string, maxsplit=0, flags=0)
# pattern： 正则模型
# string ： 要匹配的字符串
# maxsplit：指定分割个数
# flags  ： 匹配模式
```

```python
		# 无分组
        origin = "hello alex bcd alex lge alex acd 19"
        r = re.split("alex", origin, 1)
        print(r)

        # 有分组
        
        origin = "hello alex bcd alex lge alex acd 19"
        r1 = re.split("(alex)", origin, 1)
        print(r1)
        r2 = re.split("(al(ex))", origin, 1)
        print(r2)
```

正则匹配实例

```python
IP：
^(25[0-5]|2[0-4]\d|[0-1]?\d?\d)(\.(25[0-5]|2[0-4]\d|[0-1]?\d?\d)){3}$
手机号：
^1[3|4|5|8][0-9]\d{8}$
邮箱：
[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+
```

#### 六、序列化

Python中用于序列化的两个模块

- json     用于【字符串】和 【python基本数据类型】 间进行转换
- pickle   用于【python特有的类型】 和 【python基本数据类型】间进行转换

Json模块提供了四个功能：dumps、dump、loads、load

pickle模块提供了四个功能：dumps、dump、loads、load

<img src="https://i.loli.net/2017/07/14/59680fae6dcae.png" width="600px">

#### 七、configparser

configparser用于处理特定格式的文件，其本质上是利用open来操作文件。

指定格式

```
# 注释1
;  注释2
 
[section1] # 节点
k1 = v1    # 值
k2:v2       # 值
 
[section2] # 节点
k1 = v1    # 值
```

1、获取所有节点

```python
import configparser
 
config = configparser.ConfigParser()
config.read('xxxooo', encoding='utf-8')
ret = config.sections()
print(ret)
```

2、获取指定节点下所有的键值对

```python
import configparser
 
config = configparser.ConfigParser()
config.read('xxxooo', encoding='utf-8')
ret = config.items('section1')
print(ret)
```

3、获取指定节点下所有的建

```python
import configparser
 
config = configparser.ConfigParser()
config.read('xxxooo', encoding='utf-8')
ret = config.options('section1')
print(ret)
```

4、获取指定节点下指定key的值

```python
import configparser
 
config = configparser.ConfigParser()
config.read('xxxooo', encoding='utf-8')
 
 
v = config.get('section1', 'k1')
# v = config.getint('section1', 'k1')
# v = config.getfloat('section1', 'k1')
# v = config.getboolean('section1', 'k1')
print(v)
```

5、检查、删除、添加节点

```python
import configparser
 
config = configparser.ConfigParser()
config.read('xxxooo', encoding='utf-8')
 
# 检查
has_sec = config.has_section('section1')
print(has_sec)
 
# 添加节点
config.add_section("SEC_1")
config.write(open('xxxooo', 'w'))
 
# 删除节点
config.remove_section("SEC_1")
config.write(open('xxxooo', 'w'))
```

6、检查、删除、设置指定组内的键值对

```python
import configparser
 
config = configparser.ConfigParser()
config.read('xxxooo', encoding='utf-8')
 
# 检查
has_opt = config.has_option('section1', 'k1')
print(has_opt)
 
# 删除
config.remove_option('section1', 'k1')
config.write(open('xxxooo', 'w'))
 
# 设置
config.set('section1', 'k10', "123")
config.write(open('xxxooo', 'w'))
```

#### 八、XML

XML是实现不同语言或程序之间进行数据交换的协议，现在大多都使用json了，但是银行等相关“传统”的企业很多还在使用xml，XML文件格式如下：

```xml
<data>
    <country name="Liechtenstein">
        <rank updated="yes">2</rank>
        <year>2023</year>
        <gdppc>141100</gdppc>
        <neighbor direction="E" name="Austria" />
        <neighbor direction="W" name="Switzerland" />
    </country>
    <country name="Singapore">
        <rank updated="yes">5</rank>
        <year>2026</year>
        <gdppc>59900</gdppc>
        <neighbor direction="N" name="Malaysia" />
    </country>
    <country name="Panama">
        <rank updated="yes">69</rank>
        <year>2026</year>
        <gdppc>13600</gdppc>
        <neighbor direction="W" name="Costa Rica" />
        <neighbor direction="E" name="Colombia" />
    </country>
</data>
```

##### 1、解析XML

利用ElementTree.XML将字符串解析成xml对象

```python
from xml.etree import ElementTree as ET

# 打开文件，读取XML内容
str_xml = open('xo.xml', 'r').read()

# 将字符串解析成xml特殊对象，root代指xml文件的根节点
root = ET.XML(str_xml)
```

利用ElementTree.parse将文件直接解析成xml对象

```python
from xml.etree import ElementTree as ET

# 直接解析xml文件
tree = ET.parse("xo.xml")

# 获取xml文件的根节点
root = tree.getroot()
```

##### 2、操作XML

XML格式类型是节点嵌套节点，对于每一个节点均有以下功能，以便对当前节点进行操作：

节点功能一览表:

```python
class Element:
    """An XML element.

    This class is the reference implementation of the Element interface.

    An element's length is its number of subelements.  That means if you
    want to check if an element is truly empty, you should check BOTH
    its length AND its text attribute.

    The element tag, attribute names, and attribute values can be either
    bytes or strings.

    *tag* is the element name.  *attrib* is an optional dictionary containing
    element attributes. *extra* are additional element attributes given as
    keyword arguments.

    Example form:
        <tag attrib>text<child/>...</tag>tail

    """

    当前节点的标签名
    tag = None
    """The element's name."""

    当前节点的属性

    attrib = None
    """Dictionary of the element's attributes."""

    当前节点的内容
    text = None
    """
    Text before first subelement. This is either a string or the value None.
    Note that if there is no text, this attribute may be either
    None or the empty string, depending on the parser.

    """

    tail = None
    """
    Text after this element's end tag, but before the next sibling element's
    start tag.  This is either a string or the value None.  Note that if there
    was no text, this attribute may be either None or an empty string,
    depending on the parser.

    """

    def __init__(self, tag, attrib={}, **extra):
        if not isinstance(attrib, dict):
            raise TypeError("attrib must be dict, not %s" % (
                attrib.__class__.__name__,))
        attrib = attrib.copy()
        attrib.update(extra)
        self.tag = tag
        self.attrib = attrib
        self._children = []

    def __repr__(self):
        return "<%s %r at %#x>" % (self.__class__.__name__, self.tag, id(self))

    def makeelement(self, tag, attrib):
        创建一个新节点
        """Create a new element with the same type.

        *tag* is a string containing the element name.
        *attrib* is a dictionary containing the element attributes.

        Do not call this method, use the SubElement factory function instead.

        """
        return self.__class__(tag, attrib)

    def copy(self):
        """Return copy of current element.

        This creates a shallow copy. Subelements will be shared with the
        original tree.

        """
        elem = self.makeelement(self.tag, self.attrib)
        elem.text = self.text
        elem.tail = self.tail
        elem[:] = self
        return elem

    def __len__(self):
        return len(self._children)

    def __bool__(self):
        warnings.warn(
            "The behavior of this method will change in future versions.  "
            "Use specific 'len(elem)' or 'elem is not None' test instead.",
            FutureWarning, stacklevel=2
            )
        return len(self._children) != 0 # emulate old behaviour, for now

    def __getitem__(self, index):
        return self._children[index]

    def __setitem__(self, index, element):
        # if isinstance(index, slice):
        #     for elt in element:
        #         assert iselement(elt)
        # else:
        #     assert iselement(element)
        self._children[index] = element

    def __delitem__(self, index):
        del self._children[index]

    def append(self, subelement):
        为当前节点追加一个子节点
        """Add *subelement* to the end of this element.

        The new element will appear in document order after the last existing
        subelement (or directly after the text, if it's the first subelement),
        but before the end tag for this element.

        """
        self._assert_is_element(subelement)
        self._children.append(subelement)

    def extend(self, elements):
        为当前节点扩展 n 个子节点
        """Append subelements from a sequence.

        *elements* is a sequence with zero or more elements.

        """
        for element in elements:
            self._assert_is_element(element)
        self._children.extend(elements)

    def insert(self, index, subelement):
        在当前节点的子节点中插入某个节点，即：为当前节点创建子节点，然后插入指定位置
        """Insert *subelement* at position *index*."""
        self._assert_is_element(subelement)
        self._children.insert(index, subelement)

    def _assert_is_element(self, e):
        # Need to refer to the actual Python implementation, not the
        # shadowing C implementation.
        if not isinstance(e, _Element_Py):
            raise TypeError('expected an Element, not %s' % type(e).__name__)

    def remove(self, subelement):
        在当前节点在子节点中删除某个节点
        """Remove matching subelement.

        Unlike the find methods, this method compares elements based on
        identity, NOT ON tag value or contents.  To remove subelements by
        other means, the easiest way is to use a list comprehension to
        select what elements to keep, and then use slice assignment to update
        the parent element.

        ValueError is raised if a matching element could not be found.

        """
        # assert iselement(element)
        self._children.remove(subelement)

    def getchildren(self):
        获取所有的子节点（废弃）
        """(Deprecated) Return all subelements.

        Elements are returned in document order.

        """
        warnings.warn(
            "This method will be removed in future versions.  "
            "Use 'list(elem)' or iteration over elem instead.",
            DeprecationWarning, stacklevel=2
            )
        return self._children

    def find(self, path, namespaces=None):
        获取第一个寻找到的子节点
        """Find first matching element by tag name or path.

        *path* is a string having either an element tag or an XPath,
        *namespaces* is an optional mapping from namespace prefix to full name.

        Return the first matching element, or None if no element was found.

        """
        return ElementPath.find(self, path, namespaces)

    def findtext(self, path, default=None, namespaces=None):
        获取第一个寻找到的子节点的内容
        """Find text for first matching element by tag name or path.

        *path* is a string having either an element tag or an XPath,
        *default* is the value to return if the element was not found,
        *namespaces* is an optional mapping from namespace prefix to full name.

        Return text content of first matching element, or default value if
        none was found.  Note that if an element is found having no text
        content, the empty string is returned.

        """
        return ElementPath.findtext(self, path, default, namespaces)

    def findall(self, path, namespaces=None):
        获取所有的子节点
        """Find all matching subelements by tag name or path.

        *path* is a string having either an element tag or an XPath,
        *namespaces* is an optional mapping from namespace prefix to full name.

        Returns list containing all matching elements in document order.

        """
        return ElementPath.findall(self, path, namespaces)

    def iterfind(self, path, namespaces=None):
        获取所有指定的节点，并创建一个迭代器（可以被for循环）
        """Find all matching subelements by tag name or path.

        *path* is a string having either an element tag or an XPath,
        *namespaces* is an optional mapping from namespace prefix to full name.

        Return an iterable yielding all matching elements in document order.

        """
        return ElementPath.iterfind(self, path, namespaces)

    def clear(self):
        清空节点
        """Reset element.

        This function removes all subelements, clears all attributes, and sets
        the text and tail attributes to None.

        """
        self.attrib.clear()
        self._children = []
        self.text = self.tail = None

    def get(self, key, default=None):
        获取当前节点的属性值
        """Get element attribute.

        Equivalent to attrib.get, but some implementations may handle this a
        bit more efficiently.  *key* is what attribute to look for, and
        *default* is what to return if the attribute was not found.

        Returns a string containing the attribute value, or the default if
        attribute was not found.

        """
        return self.attrib.get(key, default)

    def set(self, key, value):
        为当前节点设置属性值
        """Set element attribute.

        Equivalent to attrib[key] = value, but some implementations may handle
        this a bit more efficiently.  *key* is what attribute to set, and
        *value* is the attribute value to set it to.

        """
        self.attrib[key] = value

    def keys(self):
        获取当前节点的所有属性的 key

        """Get list of attribute names.

        Names are returned in an arbitrary order, just like an ordinary
        Python dict.  Equivalent to attrib.keys()

        """
        return self.attrib.keys()

    def items(self):
        获取当前节点的所有属性值，每个属性都是一个键值对
        """Get element attributes as a sequence.

        The attributes are returned in arbitrary order.  Equivalent to
        attrib.items().

        Return a list of (name, value) tuples.

        """
        return self.attrib.items()

    def iter(self, tag=None):
        在当前节点的子孙中根据节点名称寻找所有指定的节点，并返回一个迭代器（可以被for循环）。
        """Create tree iterator.

        The iterator loops over the element and all subelements in document
        order, returning all elements with a matching tag.

        If the tree structure is modified during iteration, new or removed
        elements may or may not be included.  To get a stable set, use the
        list() function on the iterator, and loop over the resulting list.

        *tag* is what tags to look for (default is to return all elements)

        Return an iterator containing all the matching elements.

        """
        if tag == "*":
            tag = None
        if tag is None or self.tag == tag:
            yield self
        for e in self._children:
            yield from e.iter(tag)

    # compatibility
    def getiterator(self, tag=None):
        # Change for a DeprecationWarning in 1.4
        warnings.warn(
            "This method will be removed in future versions.  "
            "Use 'elem.iter()' or 'list(elem.iter())' instead.",
            PendingDeprecationWarning, stacklevel=2
        )
        return list(self.iter(tag))

    def itertext(self):
        在当前节点的子孙中根据节点名称寻找所有指定的节点的内容，并返回一个迭代器（可以被for循环）。
        """Create text iterator.

        The iterator loops over the element and all subelements in document
        order, returning all inner text.

        """
        tag = self.tag
        if not isinstance(tag, str) and tag is not None:
            return
        if self.text:
            yield self.text
        for e in self:
            yield from e.itertext()
            if e.tail:
                yield e.tail
```

由于 每个节点 都具有以上的方法，并且在上一步骤中解析时均得到了root（xml文件的根节点），so   可以利用以上方法进行操作xml文件。

a. 遍历XML文档的所有内容

```python
from xml.etree import ElementTree as ET
############ 解析方式一 ############
"""
# 打开文件，读取XML内容
str_xml = open('xo.xml', 'r').read()

# 将字符串解析成xml特殊对象，root代指xml文件的根节点
root = ET.XML(str_xml)
"""
############ 解析方式二 ############
# 直接解析xml文件
tree = ET.parse("xo.xml")

# 获取xml文件的根节点
root = tree.getroot()

### 操作

# 顶层标签
print(root.tag)

# 遍历XML文档的第二层
for child in root:
    # 第二层节点的标签名称和标签属性
    print(child.tag, child.attrib)
    # 遍历XML文档的第三层
    for i in child:
        # 第二层节点的标签名称和内容
        print(i.tag,i.text)
```

b、遍历XML中指定的节点

```python
from xml.etree import ElementTree as ET

############ 解析方式一 ############
"""
# 打开文件，读取XML内容
str_xml = open('xo.xml', 'r').read()

# 将字符串解析成xml特殊对象，root代指xml文件的根节点
root = ET.XML(str_xml)
"""
############ 解析方式二 ############

# 直接解析xml文件
tree = ET.parse("xo.xml")

# 获取xml文件的根节点
root = tree.getroot()

### 操作

# 顶层标签
print(root.tag)

# 遍历XML中所有的year节点
for node in root.iter('year'):
    # 节点的标签名称和内容
    print(node.tag, node.text)
```

c、修改节点内容

由于修改的节点时，均是在内存中进行，其不会影响文件中的内容。所以，如果想要修改，则需要重新将内存中的内容写到文件。

解析字符串方式，修改，保存:

```python
from xml.etree import ElementTree as ET

############ 解析方式一 ############

# 打开文件，读取XML内容
str_xml = open('xo.xml', 'r').read()

# 将字符串解析成xml特殊对象，root代指xml文件的根节点
root = ET.XML(str_xml)

############ 操作 ############

# 顶层标签
print(root.tag)

# 循环所有的year节点
for node in root.iter('year'):
    # 将year节点中的内容自增一
    new_year = int(node.text) + 1
    node.text = str(new_year)

    # 设置属性
    node.set('name', 'alex')
    node.set('age', '18')
    # 删除属性
    del node.attrib['name']


############ 保存文件 ############
tree = ET.ElementTree(root)
tree.write("newnew.xml", encoding='utf-8')
```

解析文件方式，修改，保存:

```python
from xml.etree import ElementTree as ET

############ 解析方式二 ############

# 直接解析xml文件
tree = ET.parse("xo.xml")

# 获取xml文件的根节点
root = tree.getroot()

############ 操作 ############

# 顶层标签
print(root.tag)

# 循环所有的year节点
for node in root.iter('year'):
    # 将year节点中的内容自增一
    new_year = int(node.text) + 1
    node.text = str(new_year)

    # 设置属性
    node.set('name', 'alex')
    node.set('age', '18')
    # 删除属性
    del node.attrib['name']

############ 保存文件 ############
tree.write("newnew.xml", encoding='utf-8')
```

d、删除节点

解析字符串方式打开，删除，保存:

```python
from xml.etree import ElementTree as ET

############ 解析字符串方式打开 ############

# 打开文件，读取XML内容
str_xml = open('xo.xml', 'r').read()

# 将字符串解析成xml特殊对象，root代指xml文件的根节点
root = ET.XML(str_xml)

############ 操作 ############

# 顶层标签
print(root.tag)

# 遍历data下的所有country节点
for country in root.findall('country'):
    # 获取每一个country节点下rank节点的内容
    rank = int(country.find('rank').text)

    if rank > 50:
        # 删除指定country节点
        root.remove(country)

############ 保存文件 ############
tree = ET.ElementTree(root)
tree.write("newnew.xml", encoding='utf-8')
```

解析文件方式打开，删除，保存:

```python
from xml.etree import ElementTree as ET

############ 解析文件方式 ############

# 直接解析xml文件
tree = ET.parse("xo.xml")

# 获取xml文件的根节点
root = tree.getroot()

############ 操作 ############

# 顶层标签
print(root.tag)

# 遍历data下的所有country节点
for country in root.findall('country'):
    # 获取每一个country节点下rank节点的内容
    rank = int(country.find('rank').text)

    if rank > 50:
        # 删除指定country节点
        root.remove(country)

############ 保存文件 ############
tree.write("newnew.xml", encoding='utf-8')
```

##### 3、创建XML文档

创建方式（一）

```python
from xml.etree import ElementTree as ET


# 创建根节点
root = ET.Element("famliy")


# 创建节点大儿子
son1 = ET.Element('son', {'name': '儿1'})
# 创建小儿子
son2 = ET.Element('son', {"name": '儿2'})

# 在大儿子中创建两个孙子
grandson1 = ET.Element('grandson', {'name': '儿11'})
grandson2 = ET.Element('grandson', {'name': '儿12'})
son1.append(grandson1)
son1.append(grandson2)


# 把儿子添加到根节点中
root.append(son1)
root.append(son1)

tree = ET.ElementTree(root)
tree.write('oooo.xml',encoding='utf-8', short_empty_elements=False)
```

创建方式（二）

```python
from xml.etree import ElementTree as ET

# 创建根节点
root = ET.Element("famliy")


# 创建大儿子
# son1 = ET.Element('son', {'name': '儿1'})
son1 = root.makeelement('son', {'name': '儿1'})
# 创建小儿子
# son2 = ET.Element('son', {"name": '儿2'})
son2 = root.makeelement('son', {"name": '儿2'})

# 在大儿子中创建两个孙子
# grandson1 = ET.Element('grandson', {'name': '儿11'})
grandson1 = son1.makeelement('grandson', {'name': '儿11'})
# grandson2 = ET.Element('grandson', {'name': '儿12'})
grandson2 = son1.makeelement('grandson', {'name': '儿12'})

son1.append(grandson1)
son1.append(grandson2)


# 把儿子添加到根节点中
root.append(son1)
root.append(son1)

tree = ET.ElementTree(root)
tree.write('oooo.xml',encoding='utf-8', short_empty_elements=False)
```

创建方式（三）

```python
from xml.etree import ElementTree as ET


# 创建根节点
root = ET.Element("famliy")


# 创建节点大儿子
son1 = ET.SubElement(root, "son", attrib={'name': '儿1'})
# 创建小儿子
son2 = ET.SubElement(root, "son", attrib={"name": "儿2"})

# 在大儿子中创建一个孙子
grandson1 = ET.SubElement(son1, "age", attrib={'name': '儿11'})
grandson1.text = '孙子'


et = ET.ElementTree(root)  #生成文档对象
et.write("test.xml", encoding="utf-8", xml_declaration=True, short_empty_elements=False)
```

由于原生保存的XML时默认无缩进，如果想要设置缩进的话， 需要修改保存方式：

```python
from xml.etree import ElementTree as ET
from xml.dom import minidom


def prettify(elem):
    """将节点转换成字符串，并添加缩进。
    """
    rough_string = ET.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="\t")

# 创建根节点
root = ET.Element("famliy")

# 创建大儿子
# son1 = ET.Element('son', {'name': '儿1'})
son1 = root.makeelement('son', {'name': '儿1'})
# 创建小儿子
# son2 = ET.Element('son', {"name": '儿2'})
son2 = root.makeelement('son', {"name": '儿2'})

# 在大儿子中创建两个孙子
# grandson1 = ET.Element('grandson', {'name': '儿11'})
grandson1 = son1.makeelement('grandson', {'name': '儿11'})
# grandson2 = ET.Element('grandson', {'name': '儿12'})
grandson2 = son1.makeelement('grandson', {'name': '儿12'})

son1.append(grandson1)
son1.append(grandson2)

# 把儿子添加到根节点中
root.append(son1)
root.append(son1)

raw_str = prettify(root)

f = open("xxxoo.xml",'w',encoding='utf-8')
f.write(raw_str)
f.close()
```

##### 4、命名空间

详细介绍，[猛击这里](http://www.w3school.com.cn/xml/xml_namespaces.asp)

```python
from xml.etree import ElementTree as ET

ET.register_namespace('com',"http://www.company.com") #some name

# build a tree structure
root = ET.Element("{http://www.company.com}STUFF")
body = ET.SubElement(root, "{http://www.company.com}MORE_STUFF", attrib={"{http://www.company.com}hhh": "123"})
body.text = "STUFF EVERYWHERE!"

# wrap it in an ElementTree instance, and save as XML
tree = ET.ElementTree(root)

tree.write("page.xml",
           xml_declaration=True,
           encoding='utf-8',
           method="xml")
```

#### 九、requests

Python标准库中提供了：urllib等模块以供Http请求，但是，它的 API 太渣了。它是为另一个时代、另一个互联网所创建的。它需要巨量的工作，甚至包括各种方法覆盖，来完成最简单的任务。

发送GET请求

```python
import urllib.request

f = urllib.request.urlopen('http://www.webxml.com.cn//webservices/qqOnlineWebService.asmx/qqCheckOnline?qqCode=424662508')
result = f.read().decode('utf-8')
```

发送携带请求头的GET请求

```python
import urllib.request

req = urllib.request.Request('http://www.example.com/')
req.add_header('Referer', 'http://www.python.org/')
r = urllib.request.urlopen(req)

result = f.read().decode('utf-8')
```

*注：更多见Python官方文档：https://docs.python.org/3.5/library/urllib.request.html#module-urllib.request*

Requests 是使用 Apache2 Licensed 许可证的 基于Python开发的HTTP 库，其在Python内置模块的基础上进行了高度的封装，从而使得Pythoner进行网络请求时，变得美好了许多，使用Requests可以轻而易举的完成浏览器所有的任何操作。

##### 1、安装模块

```python
pip3 install requests
```

##### 2、使用模块

GET请求

```python
# 1、无参数实例
import requests
 
ret = requests.get('https://github.com/timeline.json')
 
print(ret.url)
print(ret.text)
 
# 2、有参数实例
 
import requests
 
payload = {'key1': 'value1', 'key2': 'value2'}
ret = requests.get("http://httpbin.org/get", params=payload)
 
print(ret.url)
print(ret.text)
```

POST请求

```python
# 1、基本POST实例
import requests
 
payload = {'key1': 'value1', 'key2': 'value2'}
ret = requests.post("http://httpbin.org/post", data=payload)
 
print(ret.text)
 
# 2、发送请求头和数据实例
 
import requests
import json
 
url = 'https://api.github.com/some/endpoint'
payload = {'some': 'data'}
headers = {'content-type': 'application/json'}
 
ret = requests.post(url, data=json.dumps(payload), headers=headers)
 
print(ret.text)
print(ret.cookies)
```

其他请求

```python
requests.get(url, params=None, **kwargs)
requests.post(url, data=None, json=None, **kwargs)
requests.put(url, data=None, **kwargs)
requests.head(url, **kwargs)
requests.delete(url, **kwargs)
requests.patch(url, data=None, **kwargs)
requests.options(url, **kwargs)
 
# 以上方法均是在此方法的基础上构建
requests.request(method, url, **kwargs)
```

更多requests模块相关的文档见：http://cn.python-requests.org/zh_CN/latest/

##### 3、Http请求和XML实例

实例：检测QQ账号是否在线

```python
import urllib
import requests
from xml.etree import ElementTree as ET

# 使用内置模块urllib发送HTTP请求，或者XML格式内容
"""
f = urllib.request.urlopen('http://www.webxml.com.cn//webservices/qqOnlineWebService.asmx/qqCheckOnline?qqCode=424662508')
result = f.read().decode('utf-8')
"""


# 使用第三方模块requests发送HTTP请求，或者XML格式内容
r = requests.get('http://www.webxml.com.cn//webservices/qqOnlineWebService.asmx/qqCheckOnline?qqCode=424662508')
result = r.text

# 解析XML格式内容
node = ET.XML(result)

# 获取内容
if node.text == "Y":
    print("在线")
else:
    print("离线")
```

实例：查看火车停靠信息

```python
import urllib
import requests
from xml.etree import ElementTree as ET

# 使用内置模块urllib发送HTTP请求，或者XML格式内容
"""
f = urllib.request.urlopen('http://www.webxml.com.cn/WebServices/TrainTimeWebService.asmx/getDetailInfoByTrainCode?TrainCode=G666&UserID=')
result = f.read().decode('utf-8')
"""

# 使用第三方模块requests发送HTTP请求，或者XML格式内容
r = requests.get('http://www.webxml.com.cn/WebServices/TrainTimeWebService.asmx/getDetailInfoByTrainCode?TrainCode=G666&UserID=')
result = r.text

# 解析XML格式内容
root = ET.XML(result)
for node in root.iter('TrainDetailInfo'):
    print(node.find('TrainStation').text,node.find('StartTime').text,node.tag,node.attrib)
```

注：更多接口[猛击这里](http://www.cnblogs.com/wupeiqi/archive/2012/11/18/2776014.html)

#### 十、logging

用于便捷记录日志且**线程安全**的模块

##### 1、单文件日志

```python
import logging
  
logging.basicConfig(filename='log.log',
                    format='%(asctime)s - %(name)s - %(levelname)s -%(module)s:  %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S %p',
                    level=10)
  
logging.debug('debug')
logging.info('info')
logging.warning('warning')
logging.error('error')
logging.critical('critical')
logging.log(10,'log')
```

日志等级：

```
CRITICAL = 50
FATAL = CRITICAL
ERROR = 40
WARNING = 30
WARN = WARNING
INFO = 20
DEBUG = 10
NOTSET = 0
```

> 注：只有【当前写等级】大于【日志等级】时，日志文件才被记录。

日志记录格式：

<img src="https://i.loli.net/2017/07/14/596817a40dc51.png">

##### 2、多文件日志

对于上述记录日志的功能，只能将日志记录在单文件中，如果想要设置多个日志文件，logging.basicConfig将无法完成，需要自定义文件和日志操作对象。

日志一

```python
# 定义文件
file_1_1 = logging.FileHandler('l1_1.log', 'a', encoding='utf-8')
fmt = logging.Formatter(fmt="%(asctime)s - %(name)s - %(levelname)s -%(module)s:  %(message)s")
file_1_1.setFormatter(fmt)

file_1_2 = logging.FileHandler('l1_2.log', 'a', encoding='utf-8')
fmt = logging.Formatter()
file_1_2.setFormatter(fmt)

# 定义日志
logger1 = logging.Logger('s1', level=logging.ERROR)
logger1.addHandler(file_1_1)
logger1.addHandler(file_1_2)


# 写日志
logger1.critical('1111')
```

日志（二）

```python
# 定义文件
file_2_1 = logging.FileHandler('l2_1.log', 'a')
fmt = logging.Formatter()
file_2_1.setFormatter(fmt)

# 定义日志
logger2 = logging.Logger('s2', level=logging.INFO)
logger2.addHandler(file_2_1)
```

如上述创建的两个日志对象

- 当使用【logger1】写日志时，会将相应的内容写入 l1_1.log 和 l1_2.log 文件中
- 当使用【logger2】写日志时，会将相应的内容写入 l2_1.log 文件中

#### 十一、系统命令

- os.system
- os.spawn*
- os.popen*          --废弃
- popen2.*           --废弃
- commands.*      --废弃，3.x中被移除

```python
import commands

result = commands.getoutput('cmd')
result = commands.getstatus('cmd')
result = commands.getstatusoutput('cmd')
```

-  subprocess 模块:以上执行shell命令的相关的模块和函数的功能均在 subprocess 模块中实现，并提供了更丰富的功能。

##### call

执行命令，返回状态码

```python
ret = subprocess.call(["ls", "-l"], shell=False)
ret = subprocess.call("ls -l", shell=True)
```

##### check_call

执行命令，如果执行状态码是 0 ，则返回0，否则抛异常

```python
subprocess.check_call(["ls", "-l"])
subprocess.check_call("exit 1", shell=True)
```

##### check_output

执行命令，如果状态码是 0 ，则返回执行结果，否则抛异常

```python
subprocess.check_output(["echo", "Hello World!"])
subprocess.check_output("exit 1", shell=True)
```

##### subprocess.Popen(...)

用于执行复杂的系统命令

参数：

- args：shell命令，可以是字符串或者序列类型（如：list，元组）
- bufsize：指定缓冲。0 无缓冲,1 行缓冲,其他 缓冲区大小,负值 系统缓冲
- stdin, stdout, stderr：分别表示程序的标准输入、输出、错误句柄
- preexec_fn：只在Unix平台下有效，用于指定一个可执行对象（callable object），它将在子进程运行之前被调用
- close_sfs：在windows平台下，如果close_fds被设置为True，则新创建的子进程将不会继承父进程的输入、输出、错误管道。
  所以不能将close_fds设置为True同时重定向子进程的标准输入、输出与错误(stdin, stdout, stderr)。
- shell：同上
- cwd：用于设置子进程的当前目录
- env：用于指定子进程的环境变量。如果env = None，子进程的环境变量将从父进程中继承。
- universal_newlines：不同系统的换行符不同，True -> 同意使用 \n
- startupinfo与createionflags只在windows下有效
  将被传递给底层的CreateProcess()函数，用于设置子进程的一些属性，如：主窗口的外观，进程的优先级等等 

执行普通命令

```python
import subprocess
ret1 = subprocess.Popen(["mkdir","t1"])
ret2 = subprocess.Popen("mkdir t2", shell=True)
```

终端输入的命令分为两种：

- 输入即可得到输出，如：ifconfig
- 输入进行某环境，依赖再输入，如：python

```python
import subprocess

obj = subprocess.Popen("mkdir t3", shell=True, cwd='/home/dev',)
#######################
obj = subprocess.Popen(["python"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
obj.stdin.write("print(1)\n")
obj.stdin.write("print(2)")
obj.stdin.close()

cmd_out = obj.stdout.read()
obj.stdout.close()
cmd_error = obj.stderr.read()
obj.stderr.close()

print(cmd_out)
print(cmd_error)
###################
obj = subprocess.Popen(["python"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
obj.stdin.write("print(1)\n")
obj.stdin.write("print(2)")

out_error_list = obj.communicate()
print(out_error_list)
###############
obj = subprocess.Popen(["python"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
out_error_list = obj.communicate('print("hello")')
print(out_error_list)
```

#### 十二、shutil

高级的 文件、文件夹、压缩包 处理模块

##### shutil.copyfileobj(fsrc, fdst[, length])

将文件内容拷贝到另一个文件中

```python
import shutil
shutil.copyfileobj(open('old.xml','r'), open('new.xml', 'w'))
```

##### shutil.copyfile(src, dst)

拷贝文件

```python
shutil.copyfile('f1.log', 'f2.log')
```

##### shutil.copymode(src, dst)

仅拷贝权限。内容、组、用户均不变

```python
shutil.copymode('f1.log', 'f2.log')
```

##### shutil.copystat(src, dst)

仅拷贝状态的信息，包括：mode bits, atime, mtime, flags

```python
shutil.copystat('f1.log', 'f2.log')
```

##### shutil.copy(src, dst)

拷贝文件和权限

```python
import shutil
shutil.copy('f1.log', 'f2.log')
```

##### shutil.copy2(src, dst)

拷贝文件和状态信息

```python
shutil.copy2('f1.log', 'f2.log')
```

##### shutil.ignore_patterns(*patterns)

##### shutil.copytree(src, dst, symlinks=False, ignore=None)

递归的去拷贝文件夹

```python
shutil.copytree('folder1', 'folder2', ignore=shutil.ignore_patterns('*.pyc', 'tmp*'))
# 实例
shutil.copytree('f1', 'f2', symlinks=True, ignore=shutil.ignore_patterns('*.pyc', 'tmp*'))
```

##### shutil.rmtree(path[, ignore_errors[, onerror]])

递归的去删除文件

```python
shutil.rmtree('folder1')
```

##### shutil.move(src, dst)

递归的去移动文件，它类似mv命令，其实就是重命名。

```python
shutil.move('folder1', 'folder3')
```

##### shutil.make_archive(base_name, format,...)

创建压缩包并返回文件路径，例如：zip、tar

创建压缩包并返回文件路径，例如：zip、tar

- base_name： 压缩包的文件名，也可以是压缩包的路径。只是文件名时，则保存至当前目录，否则保存至指定路径，
  如：www                        =>保存至当前路径
  如：/Users/wupeiqi/www =>保存至/Users/wupeiqi/
- format：	压缩包种类，“zip”, “tar”, “bztar”，“gztar”
- root_dir：	要压缩的文件夹路径（默认当前目录）
- owner：	用户，默认当前用户
- group：	组，默认当前组
- logger：	用于记录日志，通常是logging.Logger对象

```python
#将 /Users/wupeiqi/Downloads/test 下的文件打包放置当前程序目录
import shutil
ret = shutil.make_archive("wwwwwwwwww", 'gztar', root_dir='/Users/wupeiqi/Downloads/test')
  
#将 /Users/wupeiqi/Downloads/test 下的文件打包放置 /Users/wupeiqi/目录
ret = shutil.make_archive("/Users/wupeiqi/wwwwwwwwww", 'gztar', root_dir='/Users/wupeiqi/Downloads/test')
```

shutil 对压缩包的处理是调用 ZipFile 和 TarFile 两个模块来进行的，详细：

zipfile解压缩

```python
import zipfile

# 压缩
z = zipfile.ZipFile('laxi.zip', 'w')
z.write('a.log')
z.write('data.data')
z.close()

# 解压
z = zipfile.ZipFile('laxi.zip', 'r')
z.extractall()
z.close()
```

tarfile解压缩

```python
import tarfile

# 压缩
tar = tarfile.open('your.tar','w')
tar.add('/Users/wupeiqi/PycharmProjects/bbs2.log', arcname='bbs2.log')
tar.add('/Users/wupeiqi/PycharmProjects/cmdb.log', arcname='cmdb.log')
tar.close()

# 解压
tar = tarfile.open('your.tar','r')
tar.extractall()  # 可设置解压地址
tar.close()
```

#### 十三、paramiko

paramiko是一个用于做远程控制的模块，使用该模块可以对远程服务器进行命令或文件操作，值得一说的是，fabric和ansible内部的远程管理就是使用的paramiko来现实。

##### 1、下载安装

```python
pycrypto，由于 paramiko 模块内部依赖pycrypto，所以先下载安装pycrypto
pip3 install pycrypto
pip3 install paramiko
```

##### 2、模块使用

执行命令 - 用户名+密码

```python
#!/usr/bin/env python
#coding:utf-8

import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect('192.168.1.108', 22, 'alex', '123')
stdin, stdout, stderr = ssh.exec_command('df')
print stdout.read()
ssh.close();
```

执行命令 - 密钥

```python
import paramiko

private_key_path = '/home/auto/.ssh/id_rsa'
key = paramiko.RSAKey.from_private_key_file(private_key_path)

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect('主机名 ', 端口, '用户名', key)

stdin, stdout, stderr = ssh.exec_command('df')
print stdout.read()
ssh.close()
```

上传或下载文件 - 用户名+密码

```python
import os,sys
import paramiko

t = paramiko.Transport(('182.92.219.86',22))
t.connect(username='wupeiqi',password='123')
sftp = paramiko.SFTPClient.from_transport(t)
sftp.put('/tmp/test.py','/tmp/test.py') 
t.close()

import os,sys
import paramiko

t = paramiko.Transport(('182.92.219.86',22))
t.connect(username='wupeiqi',password='123')
sftp = paramiko.SFTPClient.from_transport(t)
sftp.get('/tmp/test.py','/tmp/test2.py')
t.close()
```

上传或下载文件 - 密钥

```python
import paramiko

pravie_key_path = '/home/auto/.ssh/id_rsa'
key = paramiko.RSAKey.from_private_key_file(pravie_key_path)

t = paramiko.Transport(('182.92.219.86',22))
t.connect(username='wupeiqi',pkey=key)

sftp = paramiko.SFTPClient.from_transport(t)
sftp.put('/tmp/test3.py','/tmp/test3.py') 

t.close()

import paramiko

pravie_key_path = '/home/auto/.ssh/id_rsa'
key = paramiko.RSAKey.from_private_key_file(pravie_key_path)

t = paramiko.Transport(('182.92.219.86',22))
t.connect(username='wupeiqi',pkey=key)

sftp = paramiko.SFTPClient.from_transport(t)
sftp.get('/tmp/test3.py','/tmp/test4.py') 

t.close()
```

#### 十四、time

时间相关的操作，时间有三种表示方式：

- 时间戳               1970年1月1日之后的秒，即：time.time()
- 格式化的字符串    2014-11-11 11:11，    即：time.strftime('%Y-%m-%d')
- 结构化时间          元组包含了：年、日、星期等... time.struct_time    即：time.localtime()

```python
print time.time()
print time.mktime(time.localtime())
   
print time.gmtime()    #可加时间戳参数
print time.localtime() #可加时间戳参数
print time.strptime('2014-11-11', '%Y-%m-%d')
   
print time.strftime('%Y-%m-%d') #默认当前时间
print time.strftime('%Y-%m-%d',time.localtime()) #默认当前时间
print time.asctime()
print time.asctime(time.localtime())
print time.ctime(time.time())
   
import datetime
'''
datetime.date：表示日期的类。常用的属性有year, month, day
datetime.time：表示时间的类。常用的属性有hour, minute, second, microsecond
datetime.datetime：表示日期时间
datetime.timedelta：表示时间间隔，即两个时间点之间的长度
timedelta([days[, seconds[, microseconds[, milliseconds[, minutes[, hours[, weeks]]]]]]])
strftime("%Y-%m-%d")
'''
import datetime
print datetime.datetime.now()
print datetime.datetime.now() - datetime.timedelta(days=5)
```

格式化占位符

```python
	%Y  Year with century as a decimal number.
    %m  Month as a decimal number [01,12].
    %d  Day of the month as a decimal number [01,31].
    %H  Hour (24-hour clock) as a decimal number [00,23].
    %M  Minute as a decimal number [00,59].
    %S  Second as a decimal number [00,61].
    %z  Time zone offset from UTC.
    %a  Locale's abbreviated weekday name.
    %A  Locale's full weekday name.
    %b  Locale's abbreviated month name.
    %B  Locale's full month name.
    %c  Locale's appropriate date and time representation.
    %I  Hour (12-hour clock) as a decimal number [01,12].
    %p  Locale's equivalent of either AM or PM.
```

### 练习题：

1、通过HTTP请求和XML实现获取电视节目

​     API：http://www.webxml.com.cn/webservices/ChinaTVprogramWebService.asmx  

2、通过HTTP请求和JSON实现获取天气状况

​     API：http://wthrcdn.etouch.cn/weather_mini?city=北京