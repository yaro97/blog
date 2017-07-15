---
title: 第4篇-Py基础-杂货铺
tags:
- python
---
### 字符串格式化

Python的字符串格式化有两种方式: 百分号方式、format方式

百分号的方式相对来说比较老，而format方式则是比较先进的方式，企图替换古老的方式，目前两者并存。[[PEP-3101](http://www.python.org/dev/peps/pep-3101/)]

*This PEP proposes a new system for built-in string formatting operations, intended as a replacement for the existing '%' string formatting operator.*

#### 1、百分号方式

```python
%[(name)][flags][width].[precision]typecode
```

<!-- more -->

- (name)      可选，用于选择指定的key
- flags          可选，可供选择的值有:
  - *+       右对齐；正数前加正好，负数前加负号；*
  - *-        左对齐；正数前无符号，负数前加负号；*
  - *空格    右对齐；正数前加空格，负数前加负号；*
  - *0        右对齐；正数前无符号，负数前加负号；用0填充空白处*
- width         可选，占有宽度
- .precision   可选，小数点后保留的位数
- typecode    必选
  - *s，获取传入对象的__str__方法的返回值，并将其格式化到指定位置*
  - *r，获取传入对象的__repr__方法的返回值，并将其格式化到指定位置*
  - *c，整数：将数字转换成其unicode对应的值，10进制范围为 0 <= i <= 1114111（py27则只支持0-255）；字符：将字符添加到指定位置*
  - *o，将整数转换成 八  进制表示，并将其格式化到指定位置*
  - *x，将整数转换成十六进制表示，并将其格式化到指定位置*
  - *d，将整数、浮点数转换成 十 进制表示，并将其格式化到指定位置*
  - *e，将整数、浮点数转换成科学计数法，并将其格式化到指定位置（小写e）*
  - *E，将整数、浮点数转换成科学计数法，并将其格式化到指定位置（大写E）*
  - *f， 将整数、浮点数转换成浮点数表示，并将其格式化到指定位置（默认保留小数点后6位）*
  - *F，同上*
  - *g，自动调整将整数、浮点数转换成 浮点型或科学计数法表示（超过6位数用科学计数法），并将其格式化到指定位置（如果是科学计数则是e；）*
  - *G，自动调整将整数、浮点数转换成 浮点型或科学计数法表示（超过6位数用科学计数法），并将其格式化到指定位置（如果是科学计数则是E；）*
  - *%，当字符串中存在格式化标志时，需要用 %%表示一个百分号*

> 注：Python中百分号格式化是不存在自动将整数转换成二进制表示的方式

常用格式化：

```python
tpl = "i am %s" % "alex"
tpl = "i am %s age %d" % ("alex", 18)
tpl = "i am %(name)s age %(age)d" % {"name": "alex", "age": 18}
tpl = "percent %.2f" % 99.97623
tpl = "i am %(pp).2f" % {"pp": 123.425556, }
tpl = "i am %.2f %%" % {"pp": 123.425556, }
```

#### 2、Format方式

```python
[[fill]align][sign][#][0][width][,][.precision][type]
```

- fill           【可选】空白处填充的字符

- align        【可选】对齐方式（需配合width使用）

- - *<，内容左对齐*
  - *>，内容右对齐(默认)*
  - *＝，内容右对齐，将符号放置在填充字符的左侧，且只对数字类型有效。 即使：符号+填充物+数字*
  - *^，内容居中*

- sign         【可选】有无符号数字

  - +，正号加正，负号加负；
  - -，正号不变，负号加负；
  - 空格 ，正号空格，负号加负；

- \#            【可选】对于二进制、八进制、十六进制，如果加上#，会显示 0b/0o/0x，否则不显示

- ，            【可选】为数字添加分隔符，如：1,000,000

- width       【可选】格式化位所占宽度

- .precision 【可选】小数位保留精度

- type         【可选】格式化类型

  - *传入” 字符串类型 “的参数*
    - *s，格式化字符串类型数据*
    - *空白，未指定类型，则默认是None，同s*
  - *传入“ 整数类型 ”的参数*
    - *b，将10进制整数自动转换成2进制表示然后格式化*
    - *c，将10进制整数自动转换为其对应的unicode字符*
    - *d，十进制整数*
    - *o，将10进制整数自动转换成8进制表示然后格式化；*
    - *x，将10进制整数自动转换成16进制表示然后格式化（小写x）*
    - *X，将10进制整数自动转换成16进制表示然后格式化（大写X）*
  - *传入“ 浮点型或小数类型 ”的参数*
    - *e， 转换为科学计数法（小写e）表示，然后格式化；*
    - *E， 转换为科学计数法（大写E）表示，然后格式化;*
    - *f ， 转换为浮点型（默认小数点后保留6位）表示，然后格式化；*
    - *F， 转换为浮点型（默认小数点后保留6位）表示，然后格式化；*
    - *g， 自动在e和f中切换*
    - *G， 自动在E和F中切换*
    - *%，显示百分比（默认显示小数点后6位）*

 常用格式化：

```python
tpl = "i am {}, age {}, {}".format("seven", 18, 'alex')
  
tpl = "i am {}, age {}, {}".format(*["seven", 18, 'alex'])
  
tpl = "i am {0}, age {1}, really {0}".format("seven", 18)
  
tpl = "i am {0}, age {1}, really {0}".format(*["seven", 18])
  
tpl = "i am {name}, age {age}, really {name}".format(name="seven", age=18)
  
tpl = "i am {name}, age {age}, really {name}".format(**{"name": "seven", "age": 18})
  
tpl = "i am {0[0]}, age {0[1]}, really {0[2]}".format([1, 2, 3], [11, 22, 33])
  
tpl = "i am {:s}, age {:d}, money {:f}".format("seven", 18, 88888.1)
  
tpl = "i am {:s}, age {:d}".format(*["seven", 18])
  
tpl = "i am {name:s}, age {age:d}".format(name="seven", age=18)
  
tpl = "i am {name:s}, age {age:d}".format(**{"name": "seven", "age": 18})
 
tpl = "numbers: {:b},{:o},{:d},{:x},{:X}, {:%}".format(15, 15, 15, 15, 15, 15.87623, 2)
 
tpl = "numbers: {:b},{:o},{:d},{:x},{:X}, {:%}".format(15, 15, 15, 15, 15, 15.87623, 2)
 
tpl = "numbers: {0:b},{0:o},{0:d},{0:x},{0:X}, {0:%}".format(15)
 
tpl = "numbers: {num:b},{num:o},{num:d},{num:x},{num:X}, {num:%}".format(num=15)
```

更多格式化操作：https://docs.python.org/3/library/string.html

### 迭代器和生成器

#### 1、迭代器

迭代器是访问集合元素的一种方式。迭代器对象从集合的第一个元素开始访问，直到所有的元素被访问完结束。迭代器只能往前不会后退，不过这也没什么，因为人们很少在迭代途中往后退。另外，迭代器的一大优点是不要求事先准备好整个迭代过程中所有的元素。迭代器仅仅在迭代到某个元素时才计算该元素，而在这之前或之后，元素可以不存在或者被销毁。这个特点使得它特别适合用于遍历一些巨大的或是无限的集合，比如几个G的文件

特点：

1. 访问者不需要关心迭代器内部的结构，仅需通过next()方法不断去取下一个内容
2. 不能随机访问集合中的某个值 ，只能从头到尾依次访问
3. 访问到一半时不能往回退
4. 便于循环比较大的数据集合，节省内存

```python
>>> a = iter([1,2,3,4,5])
>>> a
<list_iterator object at 0x101402630>
>>> a.__next__()
>>> a.__next__()
>>> a.__next__()
>>> a.__next__()
>>> a.__next__()
>>> a.__next__()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
```

#### 2、生成器

一个函数调用时返回一个迭代器，那这个函数就叫做生成器（generator）；如果函数中包含yield语法，那这个函数就会变成生成器；

```python
def func():
    yield 1
    yield 2
    yield 3
    yield 4
```

上述代码中：func是函数称为生成器，当执行此函数func()时会得到一个迭代器。

```python
>>> temp = func()
>>> temp.__next__()
>>> temp.__next__()
>>> temp.__next__()
>>> temp.__next__()
>>> temp.__next__()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
```

#### 3、实例

a、利用生成器自定义range

```python
def nrange(num):
    temp = -1
    while True:
        temp = temp + 1
        if temp >= num:
            return
        else:
            yield temp
```

b、利用迭代器访问range

```python
...
```