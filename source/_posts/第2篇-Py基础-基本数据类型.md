---
title: 第2篇-Py基础-基本数据类型
date: 2017-07-15 15:04:47
tags:
- python
---
### 运算符

#### 1、算数运算：

<img src="https://i.loli.net/2017/07/13/5966bff80c78f.png" width="800">

#### 2、比较运算：

<img src="https://i.loli.net/2017/07/13/5966c800998c1.png" width="800">

<!-- more -->

#### 3、赋值运算：

<img src="https://i.loli.net/2017/07/13/5966c86c0b64e.png" width="800">

#### 4、逻辑运算：

<img src="https://i.loli.net/2017/07/13/5966c86bea2c2.png" width="800">

#### 5、成员运算：

<img src="https://i.loli.net/2017/07/13/5966c86c09cc2.png" width="800">

### 基本数据类型

#### 1、数字

int（整型）

在32位机器上，整数的位数为32位，取值范围为-2\*\*31～2\*\*31-1，即-2147483648～2147483647
在64位系统上，整数的位数为64位，取值范围为-2\*\*63～2\*\*63-1，即-9223372036854775808～9223372036854775807

```python
class int(object):
    """
    int(x=0) -> int or long
    int(x, base=10) -> int or long
    
    Convert a number or string to an integer, or return 0 if no arguments
    are given.  If x is floating point, the conversion truncates towards zero.
    If x is outside the integer range, the function returns a long instead.
    
    If x is not a number or if base is given, then x must be a string or
    Unicode object representing an integer literal in the given base.  The
    literal can be preceded by '+' or '-' and be surrounded by whitespace.
    The base defaults to 10.  Valid bases are 0 and 2-36.  Base 0 means to
    interpret the base from the string as an integer literal.
    >>> int('0b100', base=0)
    """
    def bit_length(self): 
        """ 返回表示该数字的时占用的最少位数 """
        """
        int.bit_length() -> int
        
        Number of bits necessary to represent self in binary.
        >>> bin(37)
        '0b100101'
        >>> (37).bit_length()
        """
        return 0

    def conjugate(self, *args, **kwargs): # real signature unknown
        """ 返回该复数的共轭复数 """
        """ Returns self, the complex conjugate of any int. """
        pass

    def __abs__(self):
        """ 返回绝对值 """
        """ x.__abs__() <==> abs(x) """
        pass

    def __add__(self, y):
        """ x.__add__(y) <==> x+y """
        pass

    def __and__(self, y):
        """ x.__and__(y) <==> x&y """
        pass

    def __cmp__(self, y): 
        """ 比较两个数大小 """
        """ x.__cmp__(y) <==> cmp(x,y) """
        pass

    def __coerce__(self, y):
        """ 强制生成一个元组 """ 
        """ x.__coerce__(y) <==> coerce(x, y) """
        pass

    def __divmod__(self, y): 
        """ 相除，得到商和余数组成的元组 """ 
        """ x.__divmod__(y) <==> divmod(x, y) """
        pass

    def __div__(self, y): 
        """ x.__div__(y) <==> x/y """
        pass

    def __float__(self): 
        """ 转换为浮点类型 """ 
        """ x.__float__() <==> float(x) """
        pass

    def __floordiv__(self, y): 
        """ x.__floordiv__(y) <==> x//y """
        pass

    def __format__(self, *args, **kwargs): # real signature unknown
        pass

    def __getattribute__(self, name): 
        """ x.__getattribute__('name') <==> x.name """
        pass

    def __getnewargs__(self, *args, **kwargs): # real signature unknown
        """ 内部调用 __new__方法或创建对象时传入参数使用 """ 
        pass

    def __hash__(self): 
        """如果对象object为哈希表类型，返回对象object的哈希值。哈希值为整数。在字典查找中，哈希值用于快速比较字典的键。两个数值如果相等，则哈希值也相等。"""
        """ x.__hash__() <==> hash(x) """
        pass

    def __hex__(self): 
        """ 返回当前数的 十六进制 表示 """ 
        """ x.__hex__() <==> hex(x) """
        pass

    def __index__(self): 
        """ 用于切片，数字无意义 """
        """ x[y:z] <==> x[y.__index__():z.__index__()] """
        pass

    def __init__(self, x, base=10): # known special case of int.__init__
        """ 构造方法，执行 x = 123 或 x = int(10) 时，自动调用，暂时忽略 """ 
        """
        int(x=0) -> int or long
        int(x, base=10) -> int or long
        
        Convert a number or string to an integer, or return 0 if no arguments
        are given.  If x is floating point, the conversion truncates towards zero.
        If x is outside the integer range, the function returns a long instead.
        
        If x is not a number or if base is given, then x must be a string or
        Unicode object representing an integer literal in the given base.  The
        literal can be preceded by '+' or '-' and be surrounded by whitespace.
        The base defaults to 10.  Valid bases are 0 and 2-36.  Base 0 means to
        interpret the base from the string as an integer literal.
        >>> int('0b100', base=0)
        # (copied from class doc)
        """
        pass

    def __int__(self): 
        """ 转换为整数 """ 
        """ x.__int__() <==> int(x) """
        pass

    def __invert__(self): 
        """ x.__invert__() <==> ~x """
        pass

    def __long__(self): 
        """ 转换为长整数 """ 
        """ x.__long__() <==> long(x) """
        pass

    def __lshift__(self, y): 
        """ x.__lshift__(y) <==> x<<y """
        pass

    def __mod__(self, y): 
        """ x.__mod__(y) <==> x%y """
        pass

    def __mul__(self, y): 
        """ x.__mul__(y) <==> x*y """
        pass

    def __neg__(self): 
        """ x.__neg__() <==> -x """
        pass

    @staticmethod # known case of __new__
    def __new__(S, *more): 
        """ T.__new__(S, ...) -> a new object with type S, a subtype of T """
        pass

    def __nonzero__(self): 
        """ x.__nonzero__() <==> x != 0 """
        pass

    def __oct__(self): 
        """ 返回改值的 八进制 表示 """ 
        """ x.__oct__() <==> oct(x) """
        pass

    def __or__(self, y): 
        """ x.__or__(y) <==> x|y """
        pass

    def __pos__(self): 
        """ x.__pos__() <==> +x """
        pass

    def __pow__(self, y, z=None): 
        """ 幂，次方 """ 
        """ x.__pow__(y[, z]) <==> pow(x, y[, z]) """
        pass

    def __radd__(self, y): 
        """ x.__radd__(y) <==> y+x """
        pass

    def __rand__(self, y): 
        """ x.__rand__(y) <==> y&x """
        pass

    def __rdivmod__(self, y): 
        """ x.__rdivmod__(y) <==> divmod(y, x) """
        pass

    def __rdiv__(self, y): 
        """ x.__rdiv__(y) <==> y/x """
        pass

    def __repr__(self): 
        """转化为解释器可读取的形式 """
        """ x.__repr__() <==> repr(x) """
        pass

    def __str__(self): 
        """转换为人阅读的形式，如果没有适于人阅读的解释形式的话，则返回解释器课阅读的形式"""
        """ x.__str__() <==> str(x) """
        pass

    def __rfloordiv__(self, y): 
        """ x.__rfloordiv__(y) <==> y//x """
        pass

    def __rlshift__(self, y): 
        """ x.__rlshift__(y) <==> y<<x """
        pass

    def __rmod__(self, y): 
        """ x.__rmod__(y) <==> y%x """
        pass

    def __rmul__(self, y): 
        """ x.__rmul__(y) <==> y*x """
        pass

    def __ror__(self, y): 
        """ x.__ror__(y) <==> y|x """
        pass

    def __rpow__(self, x, z=None): 
        """ y.__rpow__(x[, z]) <==> pow(x, y[, z]) """
        pass

    def __rrshift__(self, y): 
        """ x.__rrshift__(y) <==> y>>x """
        pass

    def __rshift__(self, y): 
        """ x.__rshift__(y) <==> x>>y """
        pass

    def __rsub__(self, y): 
        """ x.__rsub__(y) <==> y-x """
        pass

    def __rtruediv__(self, y): 
        """ x.__rtruediv__(y) <==> y/x """
        pass

    def __rxor__(self, y): 
        """ x.__rxor__(y) <==> y^x """
        pass

    def __sub__(self, y): 
        """ x.__sub__(y) <==> x-y """
        pass

    def __truediv__(self, y): 
        """ x.__truediv__(y) <==> x/y """
        pass

    def __trunc__(self, *args, **kwargs): 
        """ 返回数值被截取为整形的值，在整形中无意义 """
        pass

    def __xor__(self, y): 
        """ x.__xor__(y) <==> x^y """
        pass

    denominator = property(lambda self: object(), lambda self, v: None, lambda self: None)  # default
    """ 分母 = 1 """
    """the denominator of a rational number in lowest terms"""

    imag = property(lambda self: object(), lambda self, v: None, lambda self: None)  # default
    """ 虚数，无意义 """
    """the imaginary part of a complex number"""

    numerator = property(lambda self: object(), lambda self, v: None, lambda self: None)  # default
    """ 分子 = 数字大小 """
    """the numerator of a rational number in lowest terms"""

    real = property(lambda self: object(), lambda self, v: None, lambda self: None)  # default
    """ 实属，无意义 """
    """the real part of a complex number"""

int
```

#### 2、布尔值

真或假
1 或 0

#### 3、字符串

"hello world"

字符串常用功能：

- 移除空白
- 分割
- 长度
- 索引
- 切片

```python
class str(basestring):
    """
    str(object='') -> string
    
    Return a nice string representation of the object.
    If the argument is a string, the return value is the same object.
    """
    def capitalize(self):  
        """ 首字母变大写 """
        """
        S.capitalize() -> string
        
        Return a copy of the string S with only its first character
        capitalized.
        """
        return ""

    def center(self, width, fillchar=None):  
        """ 内容居中，width：总长度；fillchar：空白处填充内容，默认无 """
        """
        S.center(width[, fillchar]) -> string
        
        Return S centered in a string of length width. Padding is
        done using the specified fill character (default is a space)
        """
        return ""

    def count(self, sub, start=None, end=None):  
        """ 子序列个数 """
        """
        S.count(sub[, start[, end]]) -> int
        
        Return the number of non-overlapping occurrences of substring sub in
        string S[start:end].  Optional arguments start and end are interpreted
        as in slice notation.
        """
        return 0

    def decode(self, encoding=None, errors=None):  
        """ 解码 """
        """
        S.decode([encoding[,errors]]) -> object
        
        Decodes S using the codec registered for encoding. encoding defaults
        to the default encoding. errors may be given to set a different error
        handling scheme. Default is 'strict' meaning that encoding errors raise
        a UnicodeDecodeError. Other possible values are 'ignore' and 'replace'
        as well as any other name registered with codecs.register_error that is
        able to handle UnicodeDecodeErrors.
        """
        return object()

    def encode(self, encoding=None, errors=None):  
        """ 编码，针对unicode """
        """
        S.encode([encoding[,errors]]) -> object
        
        Encodes S using the codec registered for encoding. encoding defaults
        to the default encoding. errors may be given to set a different error
        handling scheme. Default is 'strict' meaning that encoding errors raise
        a UnicodeEncodeError. Other possible values are 'ignore', 'replace' and
        'xmlcharrefreplace' as well as any other name registered with
        codecs.register_error that is able to handle UnicodeEncodeErrors.
        """
        return object()

    def endswith(self, suffix, start=None, end=None):  
        """ 是否以 xxx 结束 """
        """
        S.endswith(suffix[, start[, end]]) -> bool
        
        Return True if S ends with the specified suffix, False otherwise.
        With optional start, test S beginning at that position.
        With optional end, stop comparing S at that position.
        suffix can also be a tuple of strings to try.
        """
        return False

    def expandtabs(self, tabsize=None):  
        """ 将tab转换成空格，默认一个tab转换成8个空格 """
        """
        S.expandtabs([tabsize]) -> string
        
        Return a copy of S where all tab characters are expanded using spaces.
        If tabsize is not given, a tab size of 8 characters is assumed.
        """
        return ""

    def find(self, sub, start=None, end=None):  
        """ 寻找子序列位置，如果没找到，返回 -1 """
        """
        S.find(sub [,start [,end]]) -> int
        
        Return the lowest index in S where substring sub is found,
        such that sub is contained within S[start:end].  Optional
        arguments start and end are interpreted as in slice notation.
        
        Return -1 on failure.
        """
        return 0

    def format(*args, **kwargs): # known special case of str.format
        """ 字符串格式化，动态参数，将函数式编程时细说 """
        """
        S.format(*args, **kwargs) -> string
        
        Return a formatted version of S, using substitutions from args and kwargs.
        The substitutions are identified by braces ('{' and '}').
        """
        pass

    def index(self, sub, start=None, end=None):  
        """ 子序列位置，如果没找到，报错 """
        S.index(sub [,start [,end]]) -> int
        
        Like S.find() but raise ValueError when the substring is not found.
        """
        return 0

    def isalnum(self):  
        """ 是否是字母和数字 """
        """
        S.isalnum() -> bool
        
        Return True if all characters in S are alphanumeric
        and there is at least one character in S, False otherwise.
        """
        return False

    def isalpha(self):  
        """ 是否是字母 """
        """
        S.isalpha() -> bool
        
        Return True if all characters in S are alphabetic
        and there is at least one character in S, False otherwise.
        """
        return False

    def isdigit(self):  
        """ 是否是数字 """
        """
        S.isdigit() -> bool
        
        Return True if all characters in S are digits
        and there is at least one character in S, False otherwise.
        """
        return False

    def islower(self):  
        """ 是否小写 """
        """
        S.islower() -> bool
        
        Return True if all cased characters in S are lowercase and there is
        at least one cased character in S, False otherwise.
        """
        return False

    def isspace(self):  
        """
        S.isspace() -> bool
        
        Return True if all characters in S are whitespace
        and there is at least one character in S, False otherwise.
        """
        return False

    def istitle(self):  
        """
        S.istitle() -> bool
        
        Return True if S is a titlecased string and there is at least one
        character in S, i.e. uppercase characters may only follow uncased
        characters and lowercase characters only cased ones. Return False
        otherwise.
        """
        return False

    def isupper(self):  
        """
        S.isupper() -> bool
        
        Return True if all cased characters in S are uppercase and there is
        at least one cased character in S, False otherwise.
        """
        return False

    def join(self, iterable):  
        """ 连接 """
        """
        S.join(iterable) -> string
        
        Return a string which is the concatenation of the strings in the
        iterable.  The separator between elements is S.
        """
        return ""

    def ljust(self, width, fillchar=None):  
        """ 内容左对齐，右侧填充 """
        """
        S.ljust(width[, fillchar]) -> string
        
        Return S left-justified in a string of length width. Padding is
        done using the specified fill character (default is a space).
        """
        return ""

    def lower(self):  
        """ 变小写 """
        """
        S.lower() -> string
        
        Return a copy of the string S converted to lowercase.
        """
        return ""

    def lstrip(self, chars=None):  
        """ 移除左侧空白 """
        """
        S.lstrip([chars]) -> string or unicode
        
        Return a copy of the string S with leading whitespace removed.
        If chars is given and not None, remove characters in chars instead.
        If chars is unicode, S will be converted to unicode before stripping
        """
        return ""

    def partition(self, sep):  
        """ 分割，前，中，后三部分 """
        """
        S.partition(sep) -> (head, sep, tail)
        
        Search for the separator sep in S, and return the part before it,
        the separator itself, and the part after it.  If the separator is not
        found, return S and two empty strings.
        """
        pass

    def replace(self, old, new, count=None):  
        """ 替换 """
        """
        S.replace(old, new[, count]) -> string
        
        Return a copy of string S with all occurrences of substring
        old replaced by new.  If the optional argument count is
        given, only the first count occurrences are replaced.
        """
        return ""

    def rfind(self, sub, start=None, end=None):  
        """
        S.rfind(sub [,start [,end]]) -> int
        
        Return the highest index in S where substring sub is found,
        such that sub is contained within S[start:end].  Optional
        arguments start and end are interpreted as in slice notation.
        
        Return -1 on failure.
        """
        return 0

    def rindex(self, sub, start=None, end=None):  
        """
        S.rindex(sub [,start [,end]]) -> int
        
        Like S.rfind() but raise ValueError when the substring is not found.
        """
        return 0

    def rjust(self, width, fillchar=None):  
        """
        S.rjust(width[, fillchar]) -> string
        
        Return S right-justified in a string of length width. Padding is
        done using the specified fill character (default is a space)
        """
        return ""

    def rpartition(self, sep):  
        """
        S.rpartition(sep) -> (head, sep, tail)
        
        Search for the separator sep in S, starting at the end of S, and return
        the part before it, the separator itself, and the part after it.  If the
        separator is not found, return two empty strings and S.
        """
        pass

    def rsplit(self, sep=None, maxsplit=None):  
        """
        S.rsplit([sep [,maxsplit]]) -> list of strings
        
        Return a list of the words in the string S, using sep as the
        delimiter string, starting at the end of the string and working
        to the front.  If maxsplit is given, at most maxsplit splits are
        done. If sep is not specified or is None, any whitespace string
        is a separator.
        """
        return []

    def rstrip(self, chars=None):  
        """
        S.rstrip([chars]) -> string or unicode
        
        Return a copy of the string S with trailing whitespace removed.
        If chars is given and not None, remove characters in chars instead.
        If chars is unicode, S will be converted to unicode before stripping
        """
        return ""

    def split(self, sep=None, maxsplit=None):  
        """ 分割， maxsplit最多分割几次 """
        """
        S.split([sep [,maxsplit]]) -> list of strings
        
        Return a list of the words in the string S, using sep as the
        delimiter string.  If maxsplit is given, at most maxsplit
        splits are done. If sep is not specified or is None, any
        whitespace string is a separator and empty strings are removed
        from the result.
        """
        return []

    def splitlines(self, keepends=False):  
        """ 根据换行分割 """
        """
        S.splitlines(keepends=False) -> list of strings
        
        Return a list of the lines in S, breaking at line boundaries.
        Line breaks are not included in the resulting list unless keepends
        is given and true.
        """
        return []

    def startswith(self, prefix, start=None, end=None):  
        """ 是否起始 """
        """
        S.startswith(prefix[, start[, end]]) -> bool
        
        Return True if S starts with the specified prefix, False otherwise.
        With optional start, test S beginning at that position.
        With optional end, stop comparing S at that position.
        prefix can also be a tuple of strings to try.
        """
        return False

    def strip(self, chars=None):  
        """ 移除两段空白 """
        """
        S.strip([chars]) -> string or unicode
        
        Return a copy of the string S with leading and trailing
        whitespace removed.
        If chars is given and not None, remove characters in chars instead.
        If chars is unicode, S will be converted to unicode before stripping
        """
        return ""

    def swapcase(self):  
        """ 大写变小写，小写变大写 """
        """
        S.swapcase() -> string
        
        Return a copy of the string S with uppercase characters
        converted to lowercase and vice versa.
        """
        return ""

    def title(self):  
        """
        S.title() -> string
        
        Return a titlecased version of S, i.e. words start with uppercase
        characters, all remaining cased characters have lowercase.
        """
        return ""

    def translate(self, table, deletechars=None):  
        """
        转换，需要先做一个对应表，最后一个表示删除字符集合
        intab = "aeiou"
        outtab = "12345"
        trantab = maketrans(intab, outtab)
        str = "this is string example....wow!!!"
        print str.translate(trantab, 'xm')
        """

        """
        S.translate(table [,deletechars]) -> string
        
        Return a copy of the string S, where all characters occurring
        in the optional argument deletechars are removed, and the
        remaining characters have been mapped through the given
        translation table, which must be a string of length 256 or None.
        If the table argument is None, no translation is applied and
        the operation simply removes the characters in deletechars.
        """
        return ""

    def upper(self):  
        """
        S.upper() -> string
        
        Return a copy of the string S converted to uppercase.
        """
        return ""

    def zfill(self, width):  
        """方法返回指定长度的字符串，原字符串右对齐，前面填充0。"""
        """
        S.zfill(width) -> string
        
        Pad a numeric string S with zeros on the left, to fill a field
        of the specified width.  The string S is never truncated.
        """
        return ""

    def _formatter_field_name_split(self, *args, **kwargs): # real signature unknown
        pass

    def _formatter_parser(self, *args, **kwargs): # real signature unknown
        pass

    def __add__(self, y):  
        """ x.__add__(y) <==> x+y """
        pass

    def __contains__(self, y):  
        """ x.__contains__(y) <==> y in x """
        pass

    def __eq__(self, y):  
        """ x.__eq__(y) <==> x==y """
        pass

    def __format__(self, format_spec):  
        """
        S.__format__(format_spec) -> string
        
        Return a formatted version of S as described by format_spec.
        """
        return ""

    def __getattribute__(self, name):  
        """ x.__getattribute__('name') <==> x.name """
        pass

    def __getitem__(self, y):  
        """ x.__getitem__(y) <==> x[y] """
        pass

    def __getnewargs__(self, *args, **kwargs): # real signature unknown
        pass

    def __getslice__(self, i, j):  
        """
        x.__getslice__(i, j) <==> x[i:j]
                   
                   Use of negative indices is not supported.
        """
        pass

    def __ge__(self, y):  
        """ x.__ge__(y) <==> x>=y """
        pass

    def __gt__(self, y):  
        """ x.__gt__(y) <==> x>y """
        pass

    def __hash__(self):  
        """ x.__hash__() <==> hash(x) """
        pass

    def __init__(self, string=''): # known special case of str.__init__
        """
        str(object='') -> string
        
        Return a nice string representation of the object.
        If the argument is a string, the return value is the same object.
        # (copied from class doc)
        """
        pass

    def __len__(self):  
        """ x.__len__() <==> len(x) """
        pass

    def __le__(self, y):  
        """ x.__le__(y) <==> x<=y """
        pass

    def __lt__(self, y):  
        """ x.__lt__(y) <==> x<y """
        pass

    def __mod__(self, y):  
        """ x.__mod__(y) <==> x%y """
        pass

    def __mul__(self, n):  
        """ x.__mul__(n) <==> x*n """
        pass

    @staticmethod # known case of __new__
    def __new__(S, *more):  
        """ T.__new__(S, ...) -> a new object with type S, a subtype of T """
        pass

    def __ne__(self, y):  
        """ x.__ne__(y) <==> x!=y """
        pass

    def __repr__(self):  
        """ x.__repr__() <==> repr(x) """
        pass

    def __rmod__(self, y):  
        """ x.__rmod__(y) <==> y%x """
        pass

    def __rmul__(self, n):  
        """ x.__rmul__(n) <==> n*x """
        pass

    def __sizeof__(self):  
        """ S.__sizeof__() -> size of S in memory, in bytes """
        pass

    def __str__(self):  
        """ x.__str__() <==> str(x) """
        pass
 
 str
```

#### 4、列表

创建列表：

```python
name_list = ['alex', 'seven', 'eric'] 
#或者
name_list ＝ list(['alex', 'seven', 'eric'])
```

基本操作：

- 索引
- 切片
- 追加
- 删除
- 长度
- 切片
- 循环
- 包含

```python
class list(object):
    """
    list() -> new empty list
    list(iterable) -> new list initialized from iterable's items
    """
    def append(self, p_object): # real signature unknown; restored from __doc__
        """ L.append(object) -- append object to end """
        pass

    def count(self, value): # real signature unknown; restored from __doc__
        """ L.count(value) -> integer -- return number of occurrences of value """
        return 0

    def extend(self, iterable): # real signature unknown; restored from __doc__
        """ L.extend(iterable) -- extend list by appending elements from the iterable """
        pass

    def index(self, value, start=None, stop=None): # real signature unknown; restored from __doc__
        """
        L.index(value, [start, [stop]]) -> integer -- return first index of value.
        Raises ValueError if the value is not present.
        """
        return 0

    def insert(self, index, p_object): # real signature unknown; restored from __doc__
        """ L.insert(index, object) -- insert object before index """
        pass

    def pop(self, index=None): # real signature unknown; restored from __doc__
        """
        L.pop([index]) -> item -- remove and return item at index (default last).
        Raises IndexError if list is empty or index is out of range.
        """
        pass

    def remove(self, value): # real signature unknown; restored from __doc__
        """
        L.remove(value) -- remove first occurrence of value.
        Raises ValueError if the value is not present.
        """
        pass

    def reverse(self): # real signature unknown; restored from __doc__
        """ L.reverse() -- reverse *IN PLACE* """
        pass

    def sort(self, cmp=None, key=None, reverse=False): # real signature unknown; restored from __doc__
        """
        L.sort(cmp=None, key=None, reverse=False) -- stable sort *IN PLACE*;
        cmp(x, y) -> -1, 0, 1
        """
        pass

    def __add__(self, y): # real signature unknown; restored from __doc__
        """ x.__add__(y) <==> x+y """
        pass

    def __contains__(self, y): # real signature unknown; restored from __doc__
        """ x.__contains__(y) <==> y in x """
        pass

    def __delitem__(self, y): # real signature unknown; restored from __doc__
        """ x.__delitem__(y) <==> del x[y] """
        pass

    def __delslice__(self, i, j): # real signature unknown; restored from __doc__
        """
        x.__delslice__(i, j) <==> del x[i:j]
                   
                   Use of negative indices is not supported.
        """
        pass

    def __eq__(self, y): # real signature unknown; restored from __doc__
        """ x.__eq__(y) <==> x==y """
        pass

    def __getattribute__(self, name): # real signature unknown; restored from __doc__
        """ x.__getattribute__('name') <==> x.name """
        pass

    def __getitem__(self, y): # real signature unknown; restored from __doc__
        """ x.__getitem__(y) <==> x[y] """
        pass

    def __getslice__(self, i, j): # real signature unknown; restored from __doc__
        """
        x.__getslice__(i, j) <==> x[i:j]
                   
                   Use of negative indices is not supported.
        """
        pass

    def __ge__(self, y): # real signature unknown; restored from __doc__
        """ x.__ge__(y) <==> x>=y """
        pass

    def __gt__(self, y): # real signature unknown; restored from __doc__
        """ x.__gt__(y) <==> x>y """
        pass

    def __iadd__(self, y): # real signature unknown; restored from __doc__
        """ x.__iadd__(y) <==> x+=y """
        pass

    def __imul__(self, y): # real signature unknown; restored from __doc__
        """ x.__imul__(y) <==> x*=y """
        pass

    def __init__(self, seq=()): # known special case of list.__init__
        """
        list() -> new empty list
        list(iterable) -> new list initialized from iterable's items
        # (copied from class doc)
        """
        pass

    def __iter__(self): # real signature unknown; restored from __doc__
        """ x.__iter__() <==> iter(x) """
        pass

    def __len__(self): # real signature unknown; restored from __doc__
        """ x.__len__() <==> len(x) """
        pass

    def __le__(self, y): # real signature unknown; restored from __doc__
        """ x.__le__(y) <==> x<=y """
        pass

    def __lt__(self, y): # real signature unknown; restored from __doc__
        """ x.__lt__(y) <==> x<y """
        pass

    def __mul__(self, n): # real signature unknown; restored from __doc__
        """ x.__mul__(n) <==> x*n """
        pass

    @staticmethod # known case of __new__
    def __new__(S, *more): # real signature unknown; restored from __doc__
        """ T.__new__(S, ...) -> a new object with type S, a subtype of T """
        pass

    def __ne__(self, y): # real signature unknown; restored from __doc__
        """ x.__ne__(y) <==> x!=y """
        pass

    def __repr__(self): # real signature unknown; restored from __doc__
        """ x.__repr__() <==> repr(x) """
        pass

    def __reversed__(self): # real signature unknown; restored from __doc__
        """ L.__reversed__() -- return a reverse iterator over the list """
        pass

    def __rmul__(self, n): # real signature unknown; restored from __doc__
        """ x.__rmul__(n) <==> n*x """
        pass

    def __setitem__(self, i, y): # real signature unknown; restored from __doc__
        """ x.__setitem__(i, y) <==> x[i]=y """
        pass

    def __setslice__(self, i, j, y): # real signature unknown; restored from __doc__
        """
        x.__setslice__(i, j, y) <==> x[i:j]=y
                   
                   Use  of negative indices is not supported.
        """
        pass

    def __sizeof__(self): # real signature unknown; restored from __doc__
        """ L.__sizeof__() -- size of L in memory, in bytes """
        pass

    __hash__ = None

list
```

#### 5、元祖（只读）

创建元祖：

```python
ages = (11, 22, 33, 44, 55)
或
ages = tuple((11, 22, 33, 44, 55))
```

基本操作：

- 索引
- 切片
- 循环
- 长度
- 包含

```python
lass tuple(object):
    """
    tuple() -> empty tuple
    tuple(iterable) -> tuple initialized from iterable's items
    
    If the argument is a tuple, the return value is the same object.
    """
    def count(self, value): # real signature unknown; restored from __doc__
        """ T.count(value) -> integer -- return number of occurrences of value """
        return 0

    def index(self, value, start=None, stop=None): # real signature unknown; restored from __doc__
        """
        T.index(value, [start, [stop]]) -> integer -- return first index of value.
        Raises ValueError if the value is not present.
        """
        return 0

    def __add__(self, y): # real signature unknown; restored from __doc__
        """ x.__add__(y) <==> x+y """
        pass

    def __contains__(self, y): # real signature unknown; restored from __doc__
        """ x.__contains__(y) <==> y in x """
        pass

    def __eq__(self, y): # real signature unknown; restored from __doc__
        """ x.__eq__(y) <==> x==y """
        pass

    def __getattribute__(self, name): # real signature unknown; restored from __doc__
        """ x.__getattribute__('name') <==> x.name """
        pass

    def __getitem__(self, y): # real signature unknown; restored from __doc__
        """ x.__getitem__(y) <==> x[y] """
        pass

    def __getnewargs__(self, *args, **kwargs): # real signature unknown
        pass

    def __getslice__(self, i, j): # real signature unknown; restored from __doc__
        """
        x.__getslice__(i, j) <==> x[i:j]
                   
                   Use of negative indices is not supported.
        """
        pass

    def __ge__(self, y): # real signature unknown; restored from __doc__
        """ x.__ge__(y) <==> x>=y """
        pass

    def __gt__(self, y): # real signature unknown; restored from __doc__
        """ x.__gt__(y) <==> x>y """
        pass

    def __hash__(self): # real signature unknown; restored from __doc__
        """ x.__hash__() <==> hash(x) """
        pass

    def __init__(self, seq=()): # known special case of tuple.__init__
        """
        tuple() -> empty tuple
        tuple(iterable) -> tuple initialized from iterable's items
        
        If the argument is a tuple, the return value is the same object.
        # (copied from class doc)
        """
        pass

    def __iter__(self): # real signature unknown; restored from __doc__
        """ x.__iter__() <==> iter(x) """
        pass

    def __len__(self): # real signature unknown; restored from __doc__
        """ x.__len__() <==> len(x) """
        pass

    def __le__(self, y): # real signature unknown; restored from __doc__
        """ x.__le__(y) <==> x<=y """
        pass

    def __lt__(self, y): # real signature unknown; restored from __doc__
        """ x.__lt__(y) <==> x<y """
        pass

    def __mul__(self, n): # real signature unknown; restored from __doc__
        """ x.__mul__(n) <==> x*n """
        pass

    @staticmethod # known case of __new__
    def __new__(S, *more): # real signature unknown; restored from __doc__
        """ T.__new__(S, ...) -> a new object with type S, a subtype of T """
        pass

    def __ne__(self, y): # real signature unknown; restored from __doc__
        """ x.__ne__(y) <==> x!=y """
        pass

    def __repr__(self): # real signature unknown; restored from __doc__
        """ x.__repr__() <==> repr(x) """
        pass

    def __rmul__(self, n): # real signature unknown; restored from __doc__
        """ x.__rmul__(n) <==> n*x """
        pass

    def __sizeof__(self): # real signature unknown; restored from __doc__
        """ T.__sizeof__() -- size of T in memory, in bytes """
        pass

tuple
```

#### 6、字典（无序，键值对

#### ）

创建字典：

```python
person = {"name": "mr.wu", 'age': 18}
或
person = dict({"name": "mr.wu", 'age': 18})
```

常用操作：

- 索引
- 新增
- 删除
- 键、值、键值对
- 循环
- 长度

```python
class dict(object):
    """
    dict() -> new empty dictionary
    dict(mapping) -> new dictionary initialized from a mapping object's
        (key, value) pairs
    dict(iterable) -> new dictionary initialized as if via:
        d = {}
        for k, v in iterable:
            d[k] = v
    dict(**kwargs) -> new dictionary initialized with the name=value pairs
        in the keyword argument list.  For example:  dict(one=1, two=2)
    """

    def clear(self): # real signature unknown; restored from __doc__
        """ 清除内容 """
        """ D.clear() -> None.  Remove all items from D. """
        pass

    def copy(self): # real signature unknown; restored from __doc__
        """ 浅拷贝 """
        """ D.copy() -> a shallow copy of D """
        pass

    @staticmethod # known case
    def fromkeys(S, v=None): # real signature unknown; restored from __doc__
        """
        dict.fromkeys(S[,v]) -> New dict with keys from S and values equal to v.
        v defaults to None.
        """
        pass

    def get(self, k, d=None): # real signature unknown; restored from __doc__
        """ 根据key获取值，d是默认值 """
        """ D.get(k[,d]) -> D[k] if k in D, else d.  d defaults to None. """
        pass

    def has_key(self, k): # real signature unknown; restored from __doc__
        """ 是否有key """
        """ D.has_key(k) -> True if D has a key k, else False """
        return False

    def items(self): # real signature unknown; restored from __doc__
        """ 所有项的列表形式 """
        """ D.items() -> list of D's (key, value) pairs, as 2-tuples """
        return []

    def iteritems(self): # real signature unknown; restored from __doc__
        """ 项可迭代 """
        """ D.iteritems() -> an iterator over the (key, value) items of D """
        pass

    def iterkeys(self): # real signature unknown; restored from __doc__
        """ key可迭代 """
        """ D.iterkeys() -> an iterator over the keys of D """
        pass

    def itervalues(self): # real signature unknown; restored from __doc__
        """ value可迭代 """
        """ D.itervalues() -> an iterator over the values of D """
        pass

    def keys(self): # real signature unknown; restored from __doc__
        """ 所有的key列表 """
        """ D.keys() -> list of D's keys """
        return []

    def pop(self, k, d=None): # real signature unknown; restored from __doc__
        """ 获取并在字典中移除 """
        """
        D.pop(k[,d]) -> v, remove specified key and return the corresponding value.
        If key is not found, d is returned if given, otherwise KeyError is raised
        """
        pass

    def popitem(self): # real signature unknown; restored from __doc__
        """ 获取并在字典中移除 """
        """
        D.popitem() -> (k, v), remove and return some (key, value) pair as a
        2-tuple; but raise KeyError if D is empty.
        """
        pass

    def setdefault(self, k, d=None): # real signature unknown; restored from __doc__
        """ 如果key不存在，则创建，如果存在，则返回已存在的值且不修改 """
        """ D.setdefault(k[,d]) -> D.get(k,d), also set D[k]=d if k not in D """
        pass

    def update(self, E=None, **F): # known special case of dict.update
        """ 更新
            {'name':'alex', 'age': 18000}
            [('name','sbsbsb'),]
        """
        """
        D.update([E, ]**F) -> None.  Update D from dict/iterable E and F.
        If E present and has a .keys() method, does:     for k in E: D[k] = E[k]
        If E present and lacks .keys() method, does:     for (k, v) in E: D[k] = v
        In either case, this is followed by: for k in F: D[k] = F[k]
        """
        pass

    def values(self): # real signature unknown; restored from __doc__
        """ 所有的值 """
        """ D.values() -> list of D's values """
        return []

    def viewitems(self): # real signature unknown; restored from __doc__
        """ 所有项，只是将内容保存至view对象中 """
        """ D.viewitems() -> a set-like object providing a view on D's items """
        pass

    def viewkeys(self): # real signature unknown; restored from __doc__
        """ D.viewkeys() -> a set-like object providing a view on D's keys """
        pass

    def viewvalues(self): # real signature unknown; restored from __doc__
        """ D.viewvalues() -> an object providing a view on D's values """
        pass

    def __cmp__(self, y): # real signature unknown; restored from __doc__
        """ x.__cmp__(y) <==> cmp(x,y) """
        pass

    def __contains__(self, k): # real signature unknown; restored from __doc__
        """ D.__contains__(k) -> True if D has a key k, else False """
        return False

    def __delitem__(self, y): # real signature unknown; restored from __doc__
        """ x.__delitem__(y) <==> del x[y] """
        pass

    def __eq__(self, y): # real signature unknown; restored from __doc__
        """ x.__eq__(y) <==> x==y """
        pass

    def __getattribute__(self, name): # real signature unknown; restored from __doc__
        """ x.__getattribute__('name') <==> x.name """
        pass

    def __getitem__(self, y): # real signature unknown; restored from __doc__
        """ x.__getitem__(y) <==> x[y] """
        pass

    def __ge__(self, y): # real signature unknown; restored from __doc__
        """ x.__ge__(y) <==> x>=y """
        pass

    def __gt__(self, y): # real signature unknown; restored from __doc__
        """ x.__gt__(y) <==> x>y """
        pass

    def __init__(self, seq=None, **kwargs): # known special case of dict.__init__
        """
        dict() -> new empty dictionary
        dict(mapping) -> new dictionary initialized from a mapping object's
            (key, value) pairs
        dict(iterable) -> new dictionary initialized as if via:
            d = {}
            for k, v in iterable:
                d[k] = v
        dict(**kwargs) -> new dictionary initialized with the name=value pairs
            in the keyword argument list.  For example:  dict(one=1, two=2)
        # (copied from class doc)
        """
        pass

    def __iter__(self): # real signature unknown; restored from __doc__
        """ x.__iter__() <==> iter(x) """
        pass

    def __len__(self): # real signature unknown; restored from __doc__
        """ x.__len__() <==> len(x) """
        pass

    def __le__(self, y): # real signature unknown; restored from __doc__
        """ x.__le__(y) <==> x<=y """
        pass

    def __lt__(self, y): # real signature unknown; restored from __doc__
        """ x.__lt__(y) <==> x<y """
        pass

    @staticmethod # known case of __new__
    def __new__(S, *more): # real signature unknown; restored from __doc__
        """ T.__new__(S, ...) -> a new object with type S, a subtype of T """
        pass

    def __ne__(self, y): # real signature unknown; restored from __doc__
        """ x.__ne__(y) <==> x!=y """
        pass

    def __repr__(self): # real signature unknown; restored from __doc__
        """ x.__repr__() <==> repr(x) """
        pass

    def __setitem__(self, i, y): # real signature unknown; restored from __doc__
        """ x.__setitem__(i, y) <==> x[i]=y """
        pass

    def __sizeof__(self): # real signature unknown; restored from __doc__
        """ D.__sizeof__() -> size of D in memory, in bytes """
        pass

    __hash__ = None

dict
```

> PS：循环，range，continue 和 break

### 其他

#### 1、for循环

用户按照顺序循环可迭代对象中的内容，

> PS：break、continue

```python
li = [11,22,33,44]
for item in li:
    print item
```

#### 2、enumerate

为可迭代的对象添加序号

```python
li = [11,22,33]
for k,v in enumerate(li, 1):
# 序号从1开始，k，v顺序无所谓？
    print(k,v)
```

#### 3、range和xrange

指定范围，生成指定的数字

```python
print range(1, 10)
# 结果：[1, 2, 3, 4, 5, 6, 7, 8, 9]
 
print range(1, 10, 2)
# 结果：[1, 3, 5, 7, 9]
 
print range(30, 0, -2)
# 结果：[30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2]　　
```

> xrange 用法与 range 完全相同，所不同的是生成的不是一个list对象，而是一个生成器。但是在python3中，range默认就是生成器。

### 练习题

#### 1、元素分类

有如下值集合 `[11,22,33,44,55,66,77,88,99,90...]`，将所有大于 66 的值保存至字典的第一个key中，将小于 66 的值保存至第二个key的值中。
即：` {'k1': 大于66的所有值, 'k2': 小于66的所有值}`

#### 2、查找

查找列表中元素，移除每个元素的空格，并查找以 a或A开头 并且以 c 结尾的所有元素。

```python
li = ["alec", " aric", "Alex", "Tony", "rain"]
tu = ("alec", " aric", "Alex", "Tony", "rain") 
 dic = {'k1': "alex", 'k2': ' aric',  "k3": "Alex", "k4": "Tony"}
```

#### 3、输出商品列表，用户输入序号，显示用户选中的商品

​    商品 li = ["手机", "电脑", '鼠标垫', '游艇']

 

#### 4、购物车

功能要求：

- 要求用户输入总资产，例如：2000
- 显示商品列表，让用户根据序号选择商品，加入购物车
- 购买，如果商品总额大于总资产，提示账户余额不足，否则，购买成功。
- 附加：可充值、某商品移除购物车

```python
goods = [
    {"name": "电脑", "price": 1999},
    {"name": "鼠标", "price": 10},
    {"name": "游艇", "price": 20},
    {"name": "美女", "price": 998},
]
```

####  5、用户交互，显示省市县三级联动的选择

```python
dic = {
    "河北": {
        "石家庄": ["鹿泉", "藁城", "元氏"],
        "邯郸": ["永年", "涉县", "磁县"],
    }
    "河南": {
        ...
    }
    "山西": {
        ...
    }
 
}
```