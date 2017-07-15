---
title: 第10篇-MySQL-入门
tags:
- python
---
### 一、概述

#### 1、什么是数据库 ？

　答：数据的仓库，如：在ATM的示例中我们创建了一个 db 目录，称其为数据库

#### 2、什么是 MySQL、Oracle、SQLite、Access、MS SQL Server等 ？

　答：他们均是一个软件，都有两个主要的功能：

- a. 将数据保存到文件或内存
- b. 接收特定的命令，然后对文件进行相应的操作

PS：如果有了以上软件，无须自己再去创建文件和文件夹，而是直接传递 命令 给上述软件，让其来进行文件操作，他们统称为数据库管理系统（DBMS，Database Management System）

<!-- more -->

#### 3、什么是SQL ？

　答：上述提到MySQL等软件可以接受命令，并做出相应的操作，由于命令中可以包含删除文件、获取文件内容等众多操作，对于编写的命令就是是SQL语句。SQL是结构化语言（Structured Query Language）的缩写，SQL是一种专门用来与数据库通信的语言。

### 二、下载安装

MySQL是一个关系型数据库管理系统，由瑞典MySQL AB 公司开发，目前属于 Oracle 旗下公司。MySQL 最流行的关系型数据库管理系统，在 WEB 应用方面MySQL是最好的 RDBMS (Relational Database Management System，关系数据库管理系统) 应用软件之一。

想要使用MySQL来存储并操作数据，则需要做几件事情：

- a. 安装MySQL服务端
- b. 安装MySQL客户端
- b. 【客户端】连接【服务端】
- c. 【客户端】发送命令给【服务端MySQL】服务的接受命令并执行相应操作(增删改查等)

#### Window版本

##### 1、下载

http://dev.mysql.com/downloads/mysql/

##### 2、解压

如果想要让MySQL安装在指定目录，那么就将解压后的文件夹移动到指定目录，如：C:\mysql-5.7.16-winx64

##### 3、初始化

MySQL解压后的 bin 目录下有一大堆的可执行文件，执行如下命令初始化数据：

```sh
cd c:\mysql-5.7.16-winx64\bin
mysqld --initialize-insecure
```

##### 4、启动MySQL服务

执行命令从而启动MySQL服务

```sh
# 进入可执行文件目录
cd c:\mysql-5.7.16-winx64\bin
# 启动MySQL服务
mysqld
```

##### 5、启动MySQL客户端并连接MySQL服务

由于初始化时使用的【mysqld --initialize-insecure】命令，其默认未给root账户设置密码

```sh
# 进入可执行文件目录
cd c:\mysql-5.7.16-winx64\bin
# 连接MySQL服务器
mysql -u root -p
# 提示请输入密码，直接回车
```

到此为止，MySQL服务端已经安装成功并且客户端已经可以连接上，以后再操作MySQL时，只需要重复上述4、5步骤即可。但是，在4、5步骤中重复的进入可执行文件目录比较繁琐，如想日后操作简便，可以做如下操作。

a. 添加环境变量

将MySQL可执行文件添加到环境变量中，从而执行执行命令即可

上一步解决了一些问题，但不够彻底，因为在执行【mysqd】启动MySQL服务器时，当前终端会被hang住，那么做一下设置即可解决此问题：

```sh
# 制作MySQL的Windows服务，在终端执行此命令：
"c:\mysql-5.7.16-winx64\bin\mysqld" --install
 
# 移除MySQL的Windows服务，在终端执行此命令：
"c:\mysql-5.7.16-winx64\bin\mysqld" --remove
```

注册成服务之后，以后再启动和关闭MySQL服务时，仅需执行如下命令：

```sh
# 启动MySQL服务
net start mysql
# 关闭MySQL服务
net stop mysql
```

#### Linux版本

安装：

```sh
yum install mysql-server　
```

服务端启动

```mysql
mysql.server start
```

客户端连接

```mysql
#连接：
mysql -h host -u user -p
 
#常见错误：
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2), it means that the MySQL server daemon (Unix) or service (Windows) is not running.

#退出：
QUIT 或者 Control+D
```

### 三、数据库操作

#### 1、显示数据库

```mysql
SHOW DATABASES;
```

默认数据库：
　　mysql - 用户权限相关数据
　　test - 用于用户测试数据
　　information_schema - MySQL本身架构相关数据

#### 2、创建数据库

```mysql
# utf-8
CREATE DATABASE 数据库名称 DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
 
# gbk
CREATE DATABASE 数据库名称 DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
```

#### 3、使用数据库

```mysql
USE db_name;
```

显示当前使用的数据库中所有表：SHOW TABLES;

#### 4、用户管理

```mysql
创建用户
    create user '用户名'@'IP地址' identified by '密码';
删除用户
    drop user '用户名'@'IP地址';
修改用户
    rename user '用户名'@'IP地址'; to '新用户名'@'IP地址';;
修改密码
    set password for '用户名'@'IP地址' = Password('新密码')
  
PS：用户权限相关数据保存在mysql数据库的user表中，所以也可以直接对其进行操作（不建议）
```

#### 5、授权管理

```mysql
show grants for '用户'@'IP地址'                  -- 查看权限
grant  权限 on 数据库.表 to   '用户'@'IP地址'      -- 授权
revoke 权限 on 数据库.表 from '用户'@'IP地址'      -- 取消权限
```

 对于权限

```mysql
all privileges  除grant外的所有权限
            select          仅查权限
            select,insert   查和插入权限
            ...
            usage                   无访问权限
            alter                   使用alter table
            alter routine           使用alter procedure和drop procedure
            create                  使用create table
            create routine          使用create procedure
            create temporary tables 使用create temporary tables
            create user             使用create user、drop user、rename user和revoke  all privileges
            create view             使用create view
            delete                  使用delete
            drop                    使用drop table
            execute                 使用call和存储过程
            file                    使用select into outfile 和 load data infile
            grant option            使用grant 和 revoke
            index                   使用index
            insert                  使用insert
            lock tables             使用lock table
            process                 使用show full processlist
            select                  使用select
            show databases          使用show databases
            show view               使用show view
            update                  使用update
            reload                  使用flush
            shutdown                使用mysqladmin shutdown(关闭MySQL)
            super                   􏱂􏰈使用change master、kill、logs、purge、master和set global。还允许mysqladmin􏵗􏵘􏲊􏲋调试登陆
            replication client      服务器位置的访问
            replication slave       由复制从属使用
```

 对于数据库

```mysql
 对于目标数据库以及内部其他：
            数据库名.*           数据库中的所有
            数据库名.表          指定数据库中的某张表
            数据库名.存储过程     指定数据库中的存储过程
            *.*                所有数据库
```

 对于用户和IP

```mysql
用户名@IP地址         用户只能在改IP下才能访问
用户名@192.168.1.%   用户只能在改IP段下才能访问(通配符%表示任意)
用户名@%             用户可以再任意IP下访问(默认IP地址为%)
```

 示例

```mysql
grant all privileges on db1.tb1 TO '用户名'@'IP'
grant select on db1.* TO '用户名'@'IP'
grant select,insert on *.* TO '用户名'@'IP'
revoke select on db1.tb1 from '用户名'@'IP'
```

特殊的：

```mysql
flush privileges，将数据读取到内存中，从而立即生效。
```

忘记密码：

```mysql
# 启动免授权服务端
mysqld --skip-grant-tables

# 客户端
mysql -u root -p

# 修改用户名密码
update mysql.user set authentication_string=password('666') where user='root';
flush privileges;
```

### 四、数据表操作

#### 1、创建表

```mysql
create table 表名(
    列名  类型  是否可以为空，
    列名  类型  是否可以为空
)ENGINE=InnoDB DEFAULT CHARSET=utf8
```

 是否可以为空

```
null表示空，非字符串
not null    - 不可空
null        - 可空
```

 默认值

```
默认值，创建列时可以指定默认值，当插入数据时如果未主动设置，则自动添加默认值
create table tb1(
	nid int not null defalut 2,
	num int not null
)
```

 自增

```mysql
# 自增，如果为某列设置自增列，插入数据时无需设置此列，默认将自增（表中只能有一个自增列）
            create table tb1(
                nid int not null auto_increment primary key,
                num int null
            )
            或
            create table tb1(
                nid int not null auto_increment,
                num int null,
                index(nid)
            )
# 注意：1、对于自增列，必须是索引（含主键）。
     # 2、对于自增可以设置步长和起始值
             show session variables like 'auto_inc%';
             set session auto_increment_increment=2;
             set session auto_increment_offset=10;

             shwo global  variables like 'auto_inc%';
             set global auto_increment_increment=2;
             set global auto_increment_offset=10;
```

 主键

```mysql
#主键，一种特殊的唯一索引，不允许有空值，如果主键使用单个列，则它的值必须唯一，如果是多列，则其组合必须唯一。
            create table tb1(
                nid int not null auto_increment primary key,
                num int null
            )
            #或
            create table tb1(
                nid int not null,
                num int not null,
                primary key(nid,num)
            )
```

 外键

```mysql
 #外键，一个特殊的索引，只能是指定内容
            creat table color(
                nid int not null primary key,
                name char(16) not null
            )

            create table fruit(
                nid int not null primary key,
                smt char(32) null ,
                color_id int not null,
                constraint fk_cc foreign key (color_id) references color(nid)
            )
```

#### 2、删除表

```mysql
drop table 表名
```

#### 3、清空表

```mysql
delete from 表名
truncate table 表名
```

#### 4、修改表

```mysql
#添加列：
        alter table 表名 add 列名 类型
#删除列：
        alter table 表名 drop column 列名
#修改列：
        alter table 表名 modify column 列名 类型;  -- 类型
        alter table 表名 change 原列名 新列名 类型; -- 列名，类型
 
#添加主键：
        alter table 表名 add primary key(列名);
#删除主键：
        alter table 表名 drop primary key;
        alter table 表名  modify  列名 int, drop primary key;
 
#添加外键：
        alter table 从表 add constraint 外键名称（形如：FK_从表_主表） foreign key 从表(外键字段) references 主表(主键字段);
#删除外键：
        alter table 表名 drop foreign key 外键名称
 
#修改默认值：
        ALTER TABLE testalter_tbl ALTER i SET DEFAULT 1000;
#删除默认值：
        ALTER TABLE testalter_tbl ALTER i DROP DEFAULT;
```

#### 5、基本数据类型

MySQL的数据类型大致分为：数值、时间和字符串

http://www.runoob.com/mysql/mysql-data-types.html

### 五、表内容基本操作

1、增

```mysql
insert into 表 (列名,列名...) values (值,值,值...)
insert into 表 (列名,列名...) values (值,值,值...),(值,值,值...)
insert into 表 (列名,列名...) select (列名,列名...) from 表
```

2、删

```mysql
delete from 表
delete from 表 where id＝1 and name＝'alex'
```

3、改

```mysql
update 表 set name ＝ 'alex' where id>1
```

4、查

```mysql
select * from 表
select * from 表 where id > 1
select nid,name,gender as gg from 表 where id > 1
```

5、其它

```mysql
a、条件
    select * from 表 where id > 1 and name != 'alex' and num = 12;
 
    select * from 表 where id between 5 and 16;
 
    select * from 表 where id in (11,22,33)
    select * from 表 where id not in (11,22,33)
    select * from 表 where id in (select nid from 表)
 
b、通配符
    select * from 表 where name like 'ale%'  - ale开头的所有（多个字符串）
    select * from 表 where name like 'ale_'  - ale开头的所有（一个字符）
 
c、限制
    select * from 表 limit 5;            - 前5行
    select * from 表 limit 4,5;          - 从第4行开始的5行
    select * from 表 limit 5 offset 4    - 从第4行开始的5行
 
d、排序
    select * from 表 order by 列 asc              - 根据 “列” 从小到大排列
    select * from 表 order by 列 desc             - 根据 “列” 从大到小排列
    select * from 表 order by 列1 desc,列2 asc    - 根据 “列1” 从大到小排列，如果相同则按列2从小到大排序
 
e、分组
    select num from 表 group by num
    select num,nid from 表 group by num,nid
    select num,nid from 表  where nid > 10 group by num,nid order nid desc
    select num,nid,count(*),sum(score),max(score),min(score) from 表 group by num,nid
 
    select num from 表 group by num having max(id) > 10
 
    特别的：group by 必须在where之后，order by之前
 
f、连表
    无对应关系则不显示
    select A.num, A.name, B.name
    from A,B
    Where A.nid = B.nid
 
    无对应关系则不显示
    select A.num, A.name, B.name
    from A inner join B
    on A.nid = B.nid
 
    A表所有显示，如果B中无对应关系，则值为null
    select A.num, A.name, B.name
    from A left join B
    on A.nid = B.nid
 
    B表所有显示，如果B中无对应关系，则值为null
    select A.num, A.name, B.name
    from A right join B
    on A.nid = B.nid
 
g、组合
    组合，自动处理重合
    select nickname
    from A
    union
    select name
    from B
 
    组合，不处理重合
    select nickname
    from A
    union all
    select name
    from B
```

