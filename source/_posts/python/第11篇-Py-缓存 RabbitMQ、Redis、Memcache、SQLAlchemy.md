---
title: 第11篇-Py-缓存 RabbitMQ、Redis、Memcache、SQLAlchemy
tags:
- python
---
### Memcached

Memcached 是一个高性能的分布式内存对象缓存系统，用于动态Web应用以减轻数据库负载。它通过在内存中缓存数据和对象来减少读取数据库的次数，从而提高动态、数据库驱动网站的速度。Memcached基于一个存储键/值对的hashmap。其守护进程（daemon ）是用C写的，但是客户端可以用任何语言来编写，并通过memcached协议与守护进程通信。

#### Memcached安装和基本使用

##### Memcached安装：

```sh
wget http://memcached.org/latest
tar -zxvf memcached-1.x.x.tar.gz
cd memcached-1.x.x
./configure && make && make test && sudo make install
 
PS：依赖libevent
       yum install libevent-devel
       apt-get install libevent-dev
```

<!-- more -->

##### 启动Memcached

```
memcached -d -m 10    -u root -l 10.211.55.4 -p 12000 -c 256 -P /tmp/memcached.pid
 
参数说明:
    -d 是启动一个守护进程
    -m 是分配给Memcache使用的内存数量，单位是MB
    -u 是运行Memcache的用户
    -l 是监听的服务器IP地址
    -p 是设置Memcache监听的端口,最好是1024以上的端口
    -c 选项是最大运行的并发连接数，默认是1024，按照你服务器的负载量来设定
    -P 是设置保存Memcache的pid文件
```

##### Memcached命令

```
存储命令: set/add/replace/append/prepend/cas
获取命令: get/gets
其他命令: delete/stats..
```

#### Python操作Memcached

##### 安装API

```
python操作Memcached使用Python-memcached模块
下载安装：https://pypi.python.org/pypi/python-memcached
```

##### 1、第一次操作

```python
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
mc.set("foo", "bar")
ret = mc.get('foo')
print ret
```

Ps：debug = True 表示运行出现错误时，现实错误信息，上线后移除该参数。

##### 2、天生支持集群

python-memcached模块原生支持集群操作，其原理是在内存维护一个主机列表，且集群中主机的权重值和主机在列表中重复出现的次数成正比

```
     主机    权重
    1.1.1.1   1
    1.1.1.2   2
    1.1.1.3   1
 
那么在内存中主机列表为：
    host_list = ["1.1.1.1", "1.1.1.2", "1.1.1.2", "1.1.1.3", ]
```

如果用户根据如果要在内存中创建一个键值对（如：k1 = "v1"），那么要执行一下步骤：

- 根据算法将 k1 转换成一个数字
- 将数字和主机列表长度求余数，得到一个值 N（ 0 <= N < 列表长度 ）
- 在主机列表中根据 第2步得到的值为索引获取主机，例如：host_list[N]
- 连接 将第3步中获取的主机，将 k1 = "v1" 放置在该服务器的内存中

代码实现如下：

```python
mc = memcache.Client([('1.1.1.1:12000', 1), ('1.1.1.2:12000', 2), ('1.1.1.3:12000', 1)], debug=True)
mc.set('k1', 'v1')
```

##### 3、add

添加一条键值对，如果已经存在的 key，重复执行add操作异常

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
mc.add('k1', 'v1')
# mc.add('k1', 'v2') # 报错，对已经存在的key重复添加，失败！！！
```

##### 4、replace

replace 修改某个key的值，如果key不存在，则异常

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
# 如果memcache中存在kkkk，则替换成功，否则一场
mc.replace('kkkk','999')
```

##### 5、set 和 set_multi

set            设置一个键值对，如果key不存在，则创建，如果key存在，则修改
set_multi   设置多个键值对，如果key不存在，则创建，如果key存在，则修改

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
mc.set('key0', 'wupeiqi')
mc.set_multi({'key1': 'val1', 'key2': 'val2'})
```

##### 6、delete 和 delete_multi

delete             在Memcached中删除指定的一个键值对
delete_multi    在Memcached中删除指定的多个键值对

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
 
mc.delete('key0')
mc.delete_multi(['key1', 'key2'])
```

##### 7、get 和 get_multi

get            获取一个键值对
get_multi   获取多一个键值对

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
 
val = mc.get('key0')
item_dict = mc.get_multi(["key1", "key2", "key3"])
```

##### 8、append 和 prepend

append    修改指定key的值，在该值 后面 追加内容
prepend   修改指定key的值，在该值 前面 插入内容

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
# k1 = "v1"
 
mc.append('k1', 'after')
# k1 = "v1after"
 
mc.prepend('k1', 'before')
# k1 = "beforev1after"
```

##### 9、decr 和 incr　　

incr  自增，将Memcached中的某一个值增加 N （ N默认为1 ）
decr 自减，将Memcached中的某一个值减少 N （ N默认为1 ）

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
 
mc = memcache.Client(['10.211.55.4:12000'], debug=True)
mc.set('k1', '777')
 
mc.incr('k1')
# k1 = 778
 
mc.incr('k1', 10)
# k1 = 788
 
mc.decr('k1')
# k1 = 787
 
mc.decr('k1', 10)
# k1 = 777
```

##### 10、gets 和 cas

如商城商品剩余个数，假设改值保存在memcache中，product_count = 900
A用户刷新页面从memcache中读取到product_count = 900
B用户刷新页面从memcache中读取到product_count = 900

如果A、B用户均购买商品

A用户修改商品剩余个数 product_count＝899
B用户修改商品剩余个数 product_count＝899

如此一来缓存内的数据便不在正确，两个用户购买商品后，商品剩余还是 899
如果使用python的set和get来操作以上过程，那么程序就会如上述所示情况！

如果想要避免此情况的发生，只要使用 gets 和 cas 即可，如：

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import memcache
mc = memcache.Client(['10.211.55.4:12000'], debug=True, cache_cas=True)
 
v = mc.gets('product_count')
# ...
# 如果有人在gets之后和cas之前修改了product_count，那么，下面的设置将会执行失败，剖出异常，从而避免非正常数据的产生
mc.cas('product_count', "899")
```

Ps：本质上每次执行gets时，会从memcache中获取一个自增的数字，通过cas去修改gets的值时，会携带之前获取的自增值和memcache中的自增值进行比较，如果相等，则可以提交，如果不想等，那表示在gets和cas执行之间，又有其他人执行了gets（获取了缓冲的指定值）， 如此一来有可能出现非正常数据，则不允许修改。

[Memcached 真的过时了吗？](http://www.oschina.net/news/26691/memcached-timeout)

### Redis

redis是一个key-value存储系统。和Memcached类似，它支持存储的value类型相对更多，包括string(字符串)、list(链表)、set(集合)、zset(sorted set --有序集合)和hash（哈希类型）。这些数据类型都支持push/pop、add/remove及取交集并集和差集及更丰富的操作，而且这些操作都是原子性的。在此基础上，redis支持各种不同方式的排序。与memcached一样，为了保证效率，数据都是缓存在内存中。区别的是redis会周期性的把更新的数据写入磁盘或者把修改操作写入追加的记录文件，并且在此基础上实现了master-slave(主从)同步。

#### 一、Redis安装和基本使用

```sh
wget http://download.redis.io/releases/redis-3.0.6.tar.gz
tar xzf redis-3.0.6.tar.gz
cd redis-3.0.6
make

#启动服务端
src/redis-server

#启动客户端
src/redis-cli
redis> set foo bar
OK
redis> get foo
"bar"
```

#### 二、Python操作Redis

```sh
#安装
sudo pip install redis
or
sudo easy_install redis
or
源码安装
 
详见：https://github.com/WoLpH/redis-py
```

API使用

redis-py 的API的使用可以分类为：

```markdown
- 连接方式
- 连接池
- 操作
  - String 操作
  - Hash 操作
  - List 操作
  - Set 操作
  - Sort Set 操作
- 管道
- 发布订阅
```

##### 1、操作模式

redis-py提供两个类Redis和StrictRedis用于实现Redis的命令，StrictRedis用于实现大部分官方的命令，并使用官方的语法和命令，Redis是StrictRedis的子类，用于向后兼容旧版本的redis-py。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import redis
 
r = redis.Redis(host='10.211.55.4', port=6379)
r.set('foo', 'Bar')
print r.get('foo')
```

##### 2、连接池

redis-py使用connection pool来管理对一个redis server的所有连接，避免每次建立、释放连接的开销。默认，每个Redis实例都会维护一个自己的连接池。可以直接建立一个连接池，然后作为参数Redis，这样就可以实现多个Redis实例共享一个连接池。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import redis
 
pool = redis.ConnectionPool(host='10.211.55.4', port=6379)
 
r = redis.Redis(connection_pool=pool)
r.set('foo', 'Bar')
print r.get('foo')
```

##### 3、操作

###### String操作

redis中的String在在内存中按照一个name对应一个value来存储。如图：

<img src="https://i.loli.net/2017/07/15/59699586b67bd.png" width="400px">

```python
set(name, value, ex=None, px=None, nx=False, xx=False)
#在Redis中设置值，默认，不存在则创建，存在则修改
#参数：
#     ex，过期时间（秒）
#     px，过期时间（毫秒）
#     nx，如果设置为True，则只有name不存在时，当前set操作才执行
#     xx，如果设置为True，则只有name存在时，岗前set操作才执行

setnx(name, value)
#设置值，只有name不存在时，执行设置操作（添加）

setex(name, value, time)
# 设置值
# 参数：
    # time，过期时间（数字秒 或 timedelta对象）

psetex(name, time_ms, value)
# 设置值
# 参数：
    # time_ms，过期时间（数字毫秒 或 timedelta对象）

mset(*args, **kwargs)
#批量设置值
#如：
    mset(k1='v1', k2='v2')
#    或
    mget({'k1': 'v1', 'k2': 'v2'})

get(name)
#获取值

mget(keys, *args)
#批量获取
#如：
    mget('ylr', 'wupeiqi')
#    或
    r.mget(['ylr', 'wupeiqi'])

getset(name, value)
#设置新值并获取原来的值

getrange(key, start, end)
# 获取子序列（根据字节获取，非字符）
# 参数：
    # name，Redis 的 name
    # start，起始位置（字节）
    # end，结束位置（字节）
# 如： "武沛齐" ，0-3表示 "武"

setrange(name, offset, value)
# 修改字符串内容，从指定字符串索引开始向后替换（新值太长时，则向后添加）
# 参数：
    # offset，字符串的索引，字节（一个汉字三个字节）
    # value，要设置的值


setbit(name, offset, value)
# 对name对应值的二进制表示的位进行操作
 
# 参数：
    # name，redis的name
    # offset，位的索引（将值变换成二进制后再进行索引）
    # value，值只能是 1 或 0
 
# 注：如果在Redis中有一个对应： n1 = "foo"，
#     那么字符串foo的二进制表示为：01100110 01101111 01101111
#     所以，如果执行 setbit('n1', 7, 1)，则就会将第7位设置为1，
#     那么最终二进制则变成 01100111 01101111 01101111，即："goo"
 
# 扩展，转换二进制表示：
 
    # source = "武沛齐"
    source = "foo"
 
    for i in source:
        num = ord(i)
        print bin(num).replace('b','')
 
    特别的，如果source是汉字 "武沛齐"怎么办？
    答：对于utf-8，每一个汉字占 3 个字节，那么 "武沛齐" 则有 9个字节
       对于汉字，for循环时候会按照 字节 迭代，那么在迭代时，将每一个字节转换 十进制数，然后再将十进制数转换成二进制
        11100110 10101101 10100110 11100110 10110010 10011011 11101001 10111101 10010000
        -------------------------- ----------------------------- -----------------------------
                    武                         沛                           齐


getbit(name, offset)
# 获取name对应的值的二进制表示中的某位的值 （0或1）

bitcount(key, start=None, end=None)
# 获取name对应的值的二进制表示中 1 的个数
# 参数：
    # key，Redis的name
    # start，位起始位置
    # end，位结束位置


bitop(operation, dest, *keys)
# 获取多个值，并将值做位运算，将最后的结果保存至新的name对应的值
 
# 参数：
    # operation,AND（并） 、 OR（或） 、 NOT（非） 、 XOR（异或）
    # dest, 新的Redis的name
    # *keys,要查找的Redis的name
 
# 如：
    bitop("AND", 'new_name', 'n1', 'n2', 'n3')
    # 获取Redis中n1,n2,n3对应的值，然后讲所有的值做位运算（求并集），然后将结果保存 new_name 对应的值中


strlen(name)
# 返回name对应值的字节长度（一个汉字3个字节）

incr(self, name, amount=1)
# 自增 name对应的值，当name不存在时，则创建name＝amount，否则，则自增。
# 参数：
    # name,Redis的name
    # amount,自增数（必须是整数）
# 注：同incrby

incrbyfloat(self, name, amount=1.0)
# 自增 name对应的值，当name不存在时，则创建name＝amount，否则，则自增。
# 参数：
    # name,Redis的name
    # amount,自增数（浮点型）

decr(self, name, amount=1)
# 自减 name对应的值，当name不存在时，则创建name＝amount，否则，则自减。
# 参数：
    # name,Redis的name
    # amount,自减数（整数）

append(key, value)
# 在redis name对应的值后面追加内容
# 参数：
    key, redis的name
    value, 要追加的字符串
```

###### Hash操作

redis中Hash在内存中的存储格式如下图：

<img src="https://i.loli.net/2017/07/15/596998070c641.png" width="400px">

```python
hset(name, key, value)

# name对应的hash中设置一个键值对（不存在，则创建；否则，修改）
# 参数：
    # name，redis的name
    # key，name对应的hash中的key
    # value，name对应的hash中的value
# 注：
    # hsetnx(name, key, value),当name对应的hash中不存在当前key时则创建（相当于添加）

hmset(name, mapping)
# 在name对应的hash中批量设置键值对
# 参数：
    # name，redis的name
    # mapping，字典，如：{'k1':'v1', 'k2': 'v2'}
# 如：
    # r.hmset('xx', {'k1':'v1', 'k2': 'v2'})

hget(name,key)
# 在name对应的hash中获取根据key获取value

hmget(name, keys, *args)
# 在name对应的hash中获取多个key的值
# 参数：
    # name，reids对应的name
    # keys，要获取key集合，如：['k1', 'k2', 'k3']
    # *args，要获取的key，如：k1,k2,k3
# 如：
    # r.mget('xx', ['k1', 'k2'])
    # 或
    # print r.hmget('xx', 'k1', 'k2')

hgetall(name)
#获取name对应hash的所有键值

hlen(name)
# 获取name对应的hash中键值对的个数

hkeys(name)
# 获取name对应的hash中所有的key的值

hvals(name)
# 获取name对应的hash中所有的value的值

hexists(name, key)
# 检查name对应的hash是否存在当前传入的key

hdel(name,*keys)
# 将name对应的hash中指定key的键值对删除

hincrby(name, key, amount=1)
# 自增name对应的hash中的指定key的值，不存在则创建key=amount
# 参数：
    # name，redis中的name
    # key， hash对应的key
    # amount，自增数（整数）

hincrbyfloat(name, key, amount=1.0)
# 自增name对应的hash中的指定key的值，不存在则创建key=amount
# 参数：
    # name，redis中的name
    # key， hash对应的key
    # amount，自增数（浮点数）
# 自增name对应的hash中的指定key的值，不存在则创建key=amount

hscan(name, cursor=0, match=None, count=None)
# 增量式迭代获取，对于数据大的数据非常有用，hscan可以实现分片的获取数据，并非一次性将数据全部获取完，从而放置内存被撑爆
# 参数：
    # name，redis的name
    # cursor，游标（基于游标分批取获取数据）
    # match，匹配指定key，默认None 表示所有的key
    # count，每次分片最少获取个数，默认None表示采用Redis的默认分片个数
# 如：
    # 第一次：cursor1, data1 = r.hscan('xx', cursor=0, match=None, count=None)
    # 第二次：cursor2, data1 = r.hscan('xx', cursor=cursor1, match=None, count=None)
    # ...
    # 直到返回值cursor的值为0时，表示数据已经通过分片获取完毕

hscan_iter(name, match=None, count=None)
# 利用yield封装hscan创建生成器，实现分批去redis中获取数据
# 参数：
    # match，匹配指定key，默认None 表示所有的key
    # count，每次分片最少获取个数，默认None表示采用Redis的默认分片个数
# 如：
    # for item in r.hscan_iter('xx'):
    #     print item
```

###### List操作

redis中的List在在内存中按照一个name对应一个List来存储。如图：

<img src="https://i.loli.net/2017/07/15/5969991be606a.jpg" width="400px">

```python
lpush(name,values)
# 在name对应的list中添加元素，每个新的元素都添加到列表的最左边
# 如：
    # r.lpush('oo', 11,22,33)
    # 保存顺序为: 33,22,11
# 扩展：
    # rpush(name, values) 表示从右向左操作

lpushx(name,value)
# 在name对应的list中添加元素，只有name已经存在时，值添加到列表的最左边
# 更多：
    # rpushx(name, value) 表示从右向左操作

llen(name)
# name对应的list元素的个数

linsert(name, where, refvalue, value))
# 在name对应的列表的某一个值前或后插入一个新值
# 参数：
    # name，redis的name
    # where，BEFORE或AFTER
    # refvalue，标杆值，即：在它前后插入数据
    # value，要插入的数据

r.lset(name, index, value)
# 对name对应的list中的某一个索引位置重新赋值
# 参数：
    # name，redis的name
    # index，list的索引位置
    # value，要设置的值

r.lrem(name, value, num)
# 在name对应的list中删除指定的值
# 参数：
    # name，redis的name
    # value，要删除的值
    # num，  num=0，删除列表中所有的指定值；
           # num=2,从前到后，删除2个；
           # num=-2,从后向前，删除2个

lpop(name)
# 在name对应的列表的左侧获取第一个元素并在列表中移除，返回值则是第一个元素
# 更多：
    # rpop(name) 表示从右向左操作

lindex(name, index)
#在name对应的列表中根据索引获取列表元素

lrange(name, start, end)
# 在name对应的列表分片获取数据
# 参数：
    # name，redis的name
    # start，索引的起始位置
    # end，索引结束位置

ltrim(name, start, end)
# 在name对应的列表中移除没有在start-end索引之间的值
# 参数：
    # name，redis的name
    # start，索引的起始位置
    # end，索引结束位置

rpoplpush(src, dst)
# 从一个列表取出最右边的元素，同时将其添加至另一个列表的最左边
# 参数：
    # src，要取数据的列表的name
    # dst，要添加数据的列表的name

blpop(keys, timeout)
# 将多个列表排列，按照从左到右去pop对应列表的元素
# 参数：
    # keys，redis的name的集合
    # timeout，超时时间，当元素所有列表的元素获取完之后，阻塞等待列表内有数据的时间（秒）, 0 表示永远阻塞
# 更多：
    # r.brpop(keys, timeout)，从右向左获取数据

brpoplpush(src, dst, timeout=0)
# 从一个列表的右侧移除一个元素并将其添加到另一个列表的左侧
# 参数：
    # src，取出并要移除元素的列表对应的name
    # dst，要插入元素的列表对应的name
    # timeout，当src对应的列表中没有数据时，阻塞等待其有数据的超时时间（秒），0 表示永远阻塞

=============
自定义增量迭代

# 由于redis类库中没有提供对列表元素的增量迭代，如果想要循环name对应的列表的所有元素，那么就需要：
    # 1、获取name对应的所有列表
    # 2、循环列表
# 但是，如果列表非常大，那么就有可能在第一步时就将程序的内容撑爆，所有有必要自定义一个增量迭代的功能：
 
def list_iter(name):
    """
    自定义redis列表增量迭代
    :param name: redis中的name，即：迭代name对应的列表
    :return: yield 返回 列表元素
    """
    list_count = r.llen(name)
    for index in xrange(list_count):
        yield r.lindex(name, index)
 
# 使用
for item in list_iter('pp'):
    print item
=============
```

###### Set操作

Set集合就是不允许重复的列表

```python
sadd(name,values)
# name对应的集合中添加元素

scard(name)
#获取name对应的集合中元素个数

sdiff(keys, *args)
#在第一个name对应的集合中且不在其他name对应的集合的元素集合

sdiffstore(dest, keys, *args)
# 获取第一个name对应的集合中且不在其他name对应的集合，再将其新加入到dest对应的集合中

sinter(keys, *args)
# 获取多一个name对应集合的并集

sinterstore(dest, keys, *args)
# 获取多一个name对应集合的并集，再讲其加入到dest对应的集合中

sismember(name, value)
# 检查value是否是name对应的集合的成员

smembers(name)
# 获取name对应的集合的所有成员

smove(src, dst, value)
# 将某个成员从一个集合中移动到另外一个集合

spop(name)
# 从集合的右侧（尾部）移除一个成员，并将其返回

srandmember(name, numbers)
# 从name对应的集合中随机获取 numbers 个元素

srem(name, values)
# 在name对应的集合中删除某些值

sunion(keys, *args)
# 获取多一个name对应的集合的并集

sunionstore(dest,keys, *args)
# 获取多一个name对应的集合的并集，并将结果保存到dest对应的集合中

sscan(name, cursor=0, match=None, count=None)
sscan_iter(name, match=None, count=None)
# 同字符串的操作，用于增量迭代分批获取元素，避免内存消耗太大
```

###### 有序集合

在集合的基础上，为每元素排序；元素的排序需要根据另外一个值来进行比较，所以，对于有序集合，每一个元素有两个值，即：值和分数，分数专门用来做排序。

```python
zadd(name, *args, **kwargs)
# 在name对应的有序集合中添加元素
# 如：
     # zadd('zz', 'n1', 1, 'n2', 2)
     # 或
     # zadd('zz', n1=11, n2=22)

zcard(name)
# 获取name对应的有序集合元素的数量

zcount(name, min, max)
# 获取name对应的有序集合中分数 在 [min,max] 之间的个数

zincrby(name, value, amount)
# 自增name对应的有序集合的 name 对应的分数

r.zrange( name, start, end, desc=False, withscores=False, score_cast_func=float)
# 按照索引范围获取name对应的有序集合的元素
# 参数：
    # name，redis的name
    # start，有序集合索引起始位置（非分数）
    # end，有序集合索引结束位置（非分数）
    # desc，排序规则，默认按照分数从小到大排序
    # withscores，是否获取元素的分数，默认只获取元素的值
    # score_cast_func，对分数进行数据转换的函数
# 更多：
    # 从大到小排序
    # zrevrange(name, start, end, withscores=False, score_cast_func=float)
 
    # 按照分数范围获取name对应的有序集合的元素
    # zrangebyscore(name, min, max, start=None, num=None, withscores=False, score_cast_func=float)
    # 从大到小排序
    # zrevrangebyscore(name, max, min, start=None, num=None, withscores=False, score_cast_func=float)

zrank(name, value)
# 获取某个值在 name对应的有序集合中的排行（从 0 开始）
# 更多：
    # zrevrank(name, value)，从大到小排序

zrangebylex(name, min, max, start=None, num=None)
# 当有序集合的所有成员都具有相同的分值时，有序集合的元素会根据成员的 值 （lexicographical ordering）来进行排序，而这个命令则可以返回给定的有序集合键 key 中， 元素的值介于 min 和 max 之间的成员
# 对集合中的每个成员进行逐个字节的对比（byte-by-byte compare）， 并按照从低到高的顺序， 返回排序后的集合成员。 如果两个字符串有一部分内容是相同的话， 那么命令会认为较长的字符串比较短的字符串要大
# 参数：
    # name，redis的name
    # min，左区间（值）。 + 表示正无限； - 表示负无限； ( 表示开区间； [ 则表示闭区间
    # min，右区间（值）
    # start，对结果进行分片处理，索引位置
    # num，对结果进行分片处理，索引后面的num个元素
# 如：
    # ZADD myzset 0 aa 0 ba 0 ca 0 da 0 ea 0 fa 0 ga
    # r.zrangebylex('myzset', "-", "[ca") 结果为：['aa', 'ba', 'ca']
# 更多：
    # 从大到小排序
    # zrevrangebylex(name, max, min, start=None, num=None)

zrem(name, values)
# 删除name对应的有序集合中值是values的成员
# 如：zrem('zz', ['s1', 's2'])

zremrangebyrank(name, min, max)
# 根据排行范围删除

zremrangebyscore(name, min, max)
# 根据分数范围删除

zremrangebylex(name, min, max)
# 根据值返回删除

zscore(name, value)
# 获取name对应有序集合中 value 对应的分数

zinterstore(dest, keys, aggregate=None)
# 获取两个有序集合的交集，如果遇到相同值不同分数，则按照aggregate进行操作
# aggregate的值为:  SUM  MIN  MAX

zunionstore(dest, keys, aggregate=None)
# 获取两个有序集合的并集，如果遇到相同值不同分数，则按照aggregate进行操作
# aggregate的值为:  SUM  MIN  MAX

zscan(name, cursor=0, match=None, count=None, score_cast_func=float)
zscan_iter(name, match=None, count=None,score_cast_func=float)
# 同字符串相似，相较于字符串新增score_cast_func，用来对分数进行操作
```

###### 其他常用操作

```python
delete(*names)
# 根据删除redis中的任意数据类型

exists(name)
# 检测redis的name是否存在

keys(pattern='*')
# 根据模型获取redis的name
# 更多：
    # KEYS * 匹配数据库中所有 key 。
    # KEYS h?llo 匹配 hello ， hallo 和 hxllo 等。
    # KEYS h*llo 匹配 hllo 和 heeeeello 等。
    # KEYS h[ae]llo 匹配 hello 和 hallo ，但不匹配 hillo

expire(name ,time)
# 为某个redis的某个name设置超时时间

rename(src, dst)
# 对redis的name重命名为

move(name, db))
# 将redis的某个值移动到指定的db下

randomkey()
# 随机获取一个redis的name（不删除）

type(name)
# 获取name对应值的类型

scan(cursor=0, match=None, count=None)
scan_iter(match=None, count=None)
# 同字符串操作，用于增量迭代获取key
```

##### 4、管道

redis-py默认在执行每次请求都会创建（连接池申请连接）和断开（归还连接池）一次连接操作，如果想要在一次请求中指定多个命令，则可以使用pipline实现一次请求指定多个命令，并且默认情况下一次pipline 是原子性操作。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import redis
 
pool = redis.ConnectionPool(host='10.211.55.4', port=6379)
 
r = redis.Redis(connection_pool=pool)
 
# pipe = r.pipeline(transaction=False)
pipe = r.pipeline(transaction=True)
 
pipe.set('name', 'alex')
pipe.set('role', 'sb')
 
pipe.execute()
```

##### 5、发布订阅

<img src="https://i.loli.net/2017/07/15/59699c1eb5cbc.png" width="450px">

发布者：服务器

订阅者：Dashboad和数据处理

Demo如下：

RedisHelper

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import redis

class RedisHelper:
    def __init__(self):
        self.__conn = redis.Redis(host='10.211.55.4')
        self.chan_sub = 'fm104.5'
        self.chan_pub = 'fm104.5'

    def public(self, msg):
        self.__conn.publish(self.chan_pub, msg)
        return True

    def subscribe(self):
        pub = self.__conn.pubsub()
        pub.subscribe(self.chan_sub)
        pub.parse_response()
        return pub
```

订阅者：

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from monitor.RedisHelper import RedisHelper
 
obj = RedisHelper()
redis_sub = obj.subscribe()
 
while True:
    msg= redis_sub.parse_response()
    print msg
```

发布者：

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from monitor.RedisHelper import RedisHelper
 
obj = RedisHelper()
obj.public('hello')
```

更多参见：https://github.com/andymccurdy/redis-py/

http://doc.redisfans.com/

### RabbitMQ

RabbitMQ是一个在AMQP基础上完整的，可复用的企业消息系统。他遵循Mozilla Public License开源协议。

MQ全称为Message Queue, 消息队列（MQ）是一种应用程序对应用程序的通信方法。应用程序通过读写出入队列的消息（针对应用程序的数据）来通信，而无需专用连接来链接它们。消 息传递指的是程序之间通过在消息中发送数据进行通信，而不是通过直接调用彼此来通信，直接调用通常是用于诸如远程过程调用的技术。排队指的是应用程序通过 队列来通信。队列的使用除去了接收和发送应用程序同时执行的要求。

#### RabbitMQ安装

```sh
安装配置epel源
   $ rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
 
安装erlang
   $ yum -y install erlang
 
安装RabbitMQ
   $ yum -y install rabbitmq-server
```

注意：service rabbitmq-server start/stop

#### 安装API

```sh
pip install pika
or
easy_install pika
or
源码
 
https://pypi.python.org/pypi/pika
```

#### 使用API操作RabbitMQ

##### 基于Queue实现生产者消费者模型

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import Queue
import threading

message = Queue.Queue(10)

def producer(i):
    while True:
        message.put(i)

def consumer(i):
    while True:
        msg = message.get()

for i in range(12):
    t = threading.Thread(target=producer, args=(i,))
    t.start()

for i in range(10):
    t = threading.Thread(target=consumer, args=(i,))
    t.start()
```

对于RabbitMQ来说，生产和消费不再针对内存里的一个Queue对象，而是某台服务器上的RabbitMQ Server实现的消息队列。

```python
#!/usr/bin/env python
import pika
# ######################### 生产者 #########################
connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()
 
channel.queue_declare(queue='hello')
 
channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print(" [x] Sent 'Hello World!'")
connection.close()
```

```python
#!/usr/bin/env python
import pika
# ########################## 消费者 ##########################
connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()
 
channel.queue_declare(queue='hello')
 
def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
 
channel.basic_consume(callback,
                      queue='hello',
                      no_ack=True)
 
print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
```

##### 1、acknowledgment 消息不丢失

no-ack ＝ False，如果消费者遇到情况(its channel is closed, connection is closed, or TCP connection is lost)挂掉了，那么，RabbitMQ会重新将该任务添加到队列中。

消费者

```python
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='10.211.55.4'))
channel = connection.channel()

channel.queue_declare(queue='hello')

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    import time
    time.sleep(10)
    print 'ok'
    ch.basic_ack(delivery_tag = method.delivery_tag)

channel.basic_consume(callback,
                      queue='hello',
                      no_ack=False)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
```

##### 2、durable   消息不丢失

生产者：

```python
#!/usr/bin/env python
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='10.211.55.4'))
channel = connection.channel()

# make message persistent
channel.queue_declare(queue='hello', durable=True)

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!',
                      properties=pika.BasicProperties(
                          delivery_mode=2, # make message persistent
                      ))
print(" [x] Sent 'Hello World!'")
connection.close()
```

消费者：

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='10.211.55.4'))
channel = connection.channel()

# make message persistent
channel.queue_declare(queue='hello', durable=True)


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    import time
    time.sleep(10)
    print 'ok'
    ch.basic_ack(delivery_tag = method.delivery_tag)

channel.basic_consume(callback,
                      queue='hello',
                      no_ack=False)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
```

##### 3、消息获取顺序

默认消息队列里的数据是按照顺序被消费者拿走，例如：消费者1 去队列中获取 奇数 序列的任务，消费者1去队列中获取 偶数 序列的任务。

channel.basic_qos(prefetch_count=1) 表示谁来谁取，不再按照奇偶数排列

消费者：

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='10.211.55.4'))
channel = connection.channel()

# make message persistent
channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    import time
    time.sleep(10)
    print 'ok'
    ch.basic_ack(delivery_tag = method.delivery_tag)

channel.basic_qos(prefetch_count=1)

channel.basic_consume(callback,
                      queue='hello',
                      no_ack=False)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
```

##### 4、发布订阅

<img src="https://i.loli.net/2017/07/15/59699d9cba93d.png" width="500px">

发布订阅和简单的消息队列区别在于，发布订阅会将消息发送给所有的订阅者，而消息队列中的数据被消费一次便消失。所以，RabbitMQ实现发布和订阅时，会为每一个订阅者创建一个队列，而发布者发布消息时，会将消息放置在所有相关队列中。

 exchange type = fanout

发布者：

```python
#!/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='logs',
                         type='fanout')

message = ' '.join(sys.argv[1:]) or "info: Hello World!"
channel.basic_publish(exchange='logs',
                      routing_key='',
                      body=message)
print(" [x] Sent %r" % message)
connection.close()
```

订阅者：

```python
#!/usr/bin/env python
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='logs',
                         type='fanout')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

channel.queue_bind(exchange='logs',
                   queue=queue_name)

print(' [*] Waiting for logs. To exit press CTRL+C')

def callback(ch, method, properties, body):
    print(" [x] %r" % body)

channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()
```

##### 5、关键字发送

<img src="https://i.loli.net/2017/07/15/59699df4b893d.png" width="500px">

 exchange type = direct

之前事例，发送消息时明确指定某个队列并向其中发送消息，RabbitMQ还支持根据关键字发送，即：队列绑定关键字，发送者将数据根据关键字发送到消息exchange，exchange根据 关键字 判定应该将数据发送至指定队列。

消费者：

```python
#!/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='direct_logs',
                         type='direct')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

severities = sys.argv[1:]
if not severities:
    sys.stderr.write("Usage: %s [info] [warning] [error]\n" % sys.argv[0])
    sys.exit(1)

for severity in severities:
    channel.queue_bind(exchange='direct_logs',
                       queue=queue_name,
                       routing_key=severity)

print(' [*] Waiting for logs. To exit press CTRL+C')

def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))

channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()
```

生产者：

```python
#!/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='direct_logs',
                         type='direct')

severity = sys.argv[1] if len(sys.argv) > 1 else 'info'
message = ' '.join(sys.argv[2:]) or 'Hello World!'
channel.basic_publish(exchange='direct_logs',
                      routing_key=severity,
                      body=message)
print(" [x] Sent %r:%r" % (severity, message))
connection.close()
```

##### 6、模糊匹配

<img src="https://i.loli.net/2017/07/15/59699e3d62436.png" width="500px">

 exchange type = topic

在topic类型下，可以让队列绑定几个模糊的关键字，之后发送者将数据发送到exchange，exchange将传入”路由值“和 ”关键字“进行匹配，匹配成功，则将数据发送到指定队列。

- \# 表示可以匹配 0 个 或 多个 单词
- \*  表示只能匹配 一个 单词

```
发送者路由值              队列中
old.boy.python          old.*  -- 不匹配
old.boy.python          old.#  -- 匹配
```

消费者：

```python
#!/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='topic_logs',
                         type='topic')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

binding_keys = sys.argv[1:]
if not binding_keys:
    sys.stderr.write("Usage: %s [binding_key]...\n" % sys.argv[0])
    sys.exit(1)

for binding_key in binding_keys:
    channel.queue_bind(exchange='topic_logs',
                       queue=queue_name,
                       routing_key=binding_key)

print(' [*] Waiting for logs. To exit press CTRL+C')

def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))

channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()
```

生产者：

```python
#!/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(
        host='localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='topic_logs',
                         type='topic')

routing_key = sys.argv[1] if len(sys.argv) > 1 else 'anonymous.info'
message = ' '.join(sys.argv[2:]) or 'Hello World!'
channel.basic_publish(exchange='topic_logs',
                      routing_key=routing_key,
                      body=message)
print(" [x] Sent %r:%r" % (routing_key, message))
connection.close()
```

注意：

```python
sudo rabbitmqctl add_user alex 123
# 设置用户为administrator角色
sudo rabbitmqctl set_user_tags alex administrator
# 设置权限
sudo rabbitmqctl set_permissions -p "/" alex '.''.''.'

# 然后重启rabbiMQ服务
sudo /etc/init.d/rabbitmq-server restart
 
# 然后可以使用刚才的用户远程连接rabbitmq server了。
------------------------------
credentials = pika.PlainCredentials("alex","123")

connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.14.47',credentials=credentials))
```

### SQLAlchemy

SQLAlchemy是Python编程语言下的一款ORM框架，该框架建立在数据库API之上，使用关系对象映射进行数据库操作，简言之便是：将对象转换成SQL，然后使用数据API执行SQL并获取执行结果。

<img src="https://i.loli.net/2017/07/15/59699f5e30338.png" width="">

Dialect用于和数据API进行交流，根据配置文件的不同调用不同的数据库API，从而实现对数据库的操作，如：

```
MySQL-Python
    mysql+mysqldb://<user>:<password>@<host>[:<port>]/<dbname>
 
pymysql
    mysql+pymysql://<username>:<password>@<host>/<dbname>[?<options>]
 
MySQL-Connector
    mysql+mysqlconnector://<user>:<password>@<host>[:<port>]/<dbname>
 
cx_Oracle
    oracle+cx_oracle://user:pass@host:port/dbname[?key=value&key=value...]
 
更多详见：http://docs.sqlalchemy.org/en/latest/dialects/index.html
```

#### 步骤一：

使用 Engine/ConnectionPooling/Dialect 进行数据库操作，Engine使用ConnectionPooling连接数据库，然后再通过Dialect执行SQL语句。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
 
from sqlalchemy import create_engine
 
 
engine = create_engine("mysql+mysqldb://root:123@127.0.0.1:3306/s11", max_overflow=5)
 
engine.execute(
    "INSERT INTO ts_test (a, b) VALUES ('2', 'v1')"
)
 
engine.execute(
     "INSERT INTO ts_test (a, b) VALUES (%s, %s)",
    ((555, "v1"),(666, "v1"),)
)
engine.execute(
    "INSERT INTO ts_test (a, b) VALUES (%(id)s, %(name)s)",
    id=999, name="v1"
)
 
result = engine.execute('select * from ts_test')
result.fetchall()
```

事务操作

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-

from sqlalchemy import create_engine

engine = create_engine("mysql+mysqldb://root:123@127.0.0.1:3306/s11", max_overflow=5)

# 事务操作
with engine.begin() as conn:
    conn.execute("insert into table (x, y, z) values (1, 2, 3)")
    conn.execute("my_special_procedure(5)")
    
conn = engine.connect()
# 事务操作 
with conn.begin():
       conn.execute("some statement", {'x':5, 'y':10})
```

*注：查看数据库连接：show status like 'Threads%';*

#### 步骤二：

使用 Schema Type/SQL Expression Language/Engine/ConnectionPooling/Dialect 进行数据库操作。Engine使用Schema Type创建一个特定的结构对象，之后通过SQL Expression Language将该对象转换成SQL语句，然后通过 ConnectionPooling 连接数据库，再然后通过 Dialect 执行SQL，并获取结果。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
 
from sqlalchemy import create_engine, Table, Column, Integer, String, MetaData, ForeignKey
 
metadata = MetaData()
 
user = Table('user', metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(20)),
)
 
color = Table('color', metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(20)),
)
engine = create_engine("mysql+mysqldb://root:123@127.0.0.1:3306/s11", max_overflow=5)
 
metadata.create_all(engine)
# metadata.clear()
# metadata.remove()
```

增删改查

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-

from sqlalchemy import create_engine, Table, Column, Integer, String, MetaData, ForeignKey

metadata = MetaData()

user = Table('user', metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(20)),
)

color = Table('color', metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(20)),
)
engine = create_engine("mysql+mysqldb://root:123@127.0.0.1:3306/s11", max_overflow=5)

conn = engine.connect()

# 创建SQL语句，INSERT INTO "user" (id, name) VALUES (:id, :name)
conn.execute(user.insert(),{'id':7,'name':'seven'})
conn.close()

# sql = user.insert().values(id=123, name='wu')
# conn.execute(sql)
# conn.close()

# sql = user.delete().where(user.c.id > 1)

# sql = user.update().values(fullname=user.c.name)
# sql = user.update().where(user.c.name == 'jack').values(name='ed')

# sql = select([user, ])
# sql = select([user.c.id, ])
# sql = select([user.c.name, color.c.name]).where(user.c.id==color.c.id)
# sql = select([user.c.name]).order_by(user.c.name)
# sql = select([user]).group_by(user.c.name)

# result = conn.execute(sql)
# print result.fetchall()
# conn.close()
```

更多内容详见：

​    http://www.jianshu.com/p/e6bba189fcbd

​    http://docs.sqlalchemy.org/en/latest/core/expression_api.html

注：SQLAlchemy无法修改表结构，如果需要可以使用SQLAlchemy开发者开源的另外一个软件Alembic来完成。

#### 步骤三：

使用 ORM/Schema Type/SQL Expression Language/Engine/ConnectionPooling/Dialect 所有组件对数据进行操作。根据类创建对象，对象转换成SQL，执行SQL。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
 
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
 
engine = create_engine("mysql+mysqldb://root:123@127.0.0.1:3306/s11", max_overflow=5)
 
Base = declarative_base()
 
 
class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    name = Column(String(50))
 
# 寻找Base的所有子类，按照子类的结构在数据库中生成对应的数据表信息
# Base.metadata.create_all(engine)
 
Session = sessionmaker(bind=engine)
session = Session()
 
 
# ########## 增 ##########
# u = User(id=2, name='sb')
# session.add(u)
# session.add_all([
#     User(id=3, name='sb'),
#     User(id=4, name='sb')
# ])
# session.commit()
 
# ########## 删除 ##########
# session.query(User).filter(User.id > 2).delete()
# session.commit()
 
# ########## 修改 ##########
# session.query(User).filter(User.id > 2).update({'cluster_id' : 0})
# session.commit()
# ########## 查 ##########
# ret = session.query(User).filter_by(name='sb').first()
 
# ret = session.query(User).filter_by(name='sb').all()
# print ret
 
# ret = session.query(User).filter(User.name.in_(['sb','bb'])).all()
# print ret
 
# ret = session.query(User.name.label('name_label')).all()
# print ret,type(ret)
 
# ret = session.query(User).order_by(User.id).all()
# print ret
 
# ret = session.query(User).order_by(User.id)[1:3]
# print ret
# session.commit()
```

更多功能参见文档，[猛击这里](http://files.cnblogs.com/files/wupeiqi/sqlalchemy.pdf.zip)下载PDF