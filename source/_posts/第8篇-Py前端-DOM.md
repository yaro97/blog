---
title: 第8篇-Py前端-DOM
date: 2017-07-15 15:22:47
tags:
- python
---

文档对象模型（Document Object Model，DOM）是一种用于HTML和XML文档的编程接口。它给文档提供了一种结构化的表示方法，可以改变文档的内容和呈现方式。我们最为关心的是，DOM把网页和脚本以及其他的编程语言联系了起来。DOM属于浏览器，而不是JavaScript语言规范里的规定的核心内容。

### 一、查找元素

1、直接查找

```javascript
document.getElementById             根据ID获取一个标签
document.getElementsByName          根据name属性获取标签集合
document.getElementsByClassName     根据class属性获取标签集合
document.getElementsByTagName       根据标签名获取标签集合
```

<!-- more -->

2、间接查找

```javascript
parentNode          // 父节点
childNodes          // 所有子节点
firstChild          // 第一个子节点
lastChild           // 最后一个子节点
nextSibling         // 下一个兄弟节点
previousSibling     // 上一个兄弟节点
 
parentElement           // 父节点标签元素
children                // 所有子标签
firstElementChild       // 第一个子标签元素
lastElementChild        // 最后一个子标签元素
nextElementtSibling     // 下一个兄弟标签元素
previousElementSibling  // 上一个兄弟标签元素
```

### 二、操作

#### 1、内容

```javascript
innerText   文本
outerText
innerHTML   HTML内容
innerHTML  
value       值
```

#### 2、属性

```javascript
attributes                // 获取所有标签属性
setAttribute(key,value)   // 设置标签属性
getAttribute(key)         // 获取指定标签属性
 
/*
var atr = document.createAttribute("class");
atr.nodeValue="democlass";
document.getElementById('n1').setAttributeNode(atr);
*/
```

#### 3、class操作

```javascript
className                // 获取所有类名
classList.remove(cls)    // 删除指定类
classList.add(cls)       // 添加类
```

#### 4、标签操作

##### a.创建标签

```javascript
// 方式一
var tag = document.createElement('a')
tag.innerText = "wupeiqi"
tag.className = "c1"
tag.href = "http://www.cnblogs.com/wupeiqi"
 
// 方式二
var tag = "<a class='c1' href='http://www.cnblogs.com/wupeiqi'>wupeiqi</a>"
```

##### b.操作标签

```javascript
// 方式一
var obj = "<input type='text' />";
xxx.insertAdjacentHTML("beforeEnd",obj);
xxx.insertAdjacentElement('afterBegin',document.createElement('p'))
 
//注意：第一个参数只能是'beforeBegin'、 'afterBegin'、 'beforeEnd'、 'afterEnd'
 
// 方式二
var tag = document.createElement('a')
xxx.appendChild(tag)
xxx.insertBefore(tag,xxx[1])
```

#### 5、样式操作

```javascript
var obj = document.getElementById('i1')
 
obj.style.fontSize = "32px";
obj.style.backgroundColor = "red";
```

Demo

```javascript
<input onfocus="Focus(this);" onblur="Blur(this);" id="search" value="请输入关键字" style="color: gray;" />

    <script>
        function Focus(ths){
            ths.style.color = "black";
            if(ths.value == '请输入关键字' || ths.value.trim() == ""){

                ths.value = "";
            }
        }

        function Blur(ths){
            if(ths.value.trim() == ""){
                ths.value = '请输入关键字';
                ths.style.color = 'gray';
            }else{
                ths.style.color = "black";
            }
        }
    </script>
```

#### 6、位置操作

```javascript
总文档高度
document.documentElement.offsetHeight
  
当前文档占屏幕高度
document.documentElement.clientHeight
  
自身高度
tag.offsetHeight
  
距离上级定位高度
tag.offsetTop
  
父定位标签
tag.offsetParent
  
滚动高度
tag.scrollTop
 
/*
    clientHeight -> 可见区域：height + padding
    clientTop    -> border高度
    offsetHeight -> 可见区域：height + padding + border
    offsetTop    -> 上级定位标签的高度
    scrollHeight -> 全文高：height + padding
    scrollTop    -> 滚动高度
    特别的：
        document.documentElement代指文档根节点
*/
```

Test

```javascript
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body style="margin: 0;">
    <div style="height: 900px;">

    </div>
    <div style="padding: 10px;">
        <div id="i1" style="height:190px;padding: 2px;border: 1px solid red;margin: 8px;">
                <p>asdf</p>
                <p>asdf</p>
                <p>asdf</p>
                <p>asdf</p>
                <p>asdf</p>
        </div>
    </div>

    <script>
        var i1 = document.getElementById('i1');

        console.log(i1.clientHeight); // 可见区域：height + padding
        console.log(i1.clientTop);    // border高度
        console.log('=====');
        console.log(i1.offsetHeight); // 可见区域：height + padding + border
        console.log(i1.offsetTop);    // 上级定位标签的高度
        console.log('=====');
        console.log(i1.scrollHeight);   //全文高：height + padding
        console.log(i1.scrollTop);      // 滚动高度
        console.log('=====');

    </script>
</body>
</html>
```

#### 7、提交表单

```javascript
document.geElementById('form').submit()
```

#### 8、其他操作

```javascript
console.log                 输出框
alert                       弹出框
confirm                     确认框
  
// URL和刷新
location.href               获取URL
location.href = "url"       重定向
location.reload()           重新加载
  
// 定时器
setInterval                 多次定时器
clearInterval               清除多次定时器
setTimeout                  单次定时器
clearTimeout                清除单次定时器
```

### 三、 事件

<img src="https://i.loli.net/2017/07/14/5968982d3fbf2.png">

对于事件需要注意的要点：

- this
- event
- 事件链以及跳出

this标签当前正在操作的标签，event封装了当前事件的内容。

实例：

```javascript
<!DOCTYPE html>
<html>
    <head>
        <meta charset='utf-8' />
        <title></title>
        
        <style>
            .gray{
                color:gray;
            }
            .black{
                color:black;
            }
        </style>
        <script type="text/javascript">
            function Enter(){
               var id= document.getElementById("tip")
               id.className = 'black';
               if(id.value=='请输入关键字'||id.value.trim()==''){
                    id.value = ''
               }
            }
            function Leave(){
                var id= document.getElementById("tip")
                var val = id.value;
                if(val.length==0||id.value.trim()==''){
                    id.value = '请输入关键字'
                    id.className = 'gray';
                }else{
                    id.className = 'black';
                }
            }
        </script>
    </head>
    <body>
        <input type='text' class='gray' id='tip' value='请输入关键字' onfocus='Enter();'  onblur='Leave();'/>
    </body>
</html>
```

跑马灯

```javascript
<!DOCTYPE html>
<html>
    <head>
        <meta charset='utf-8' >
        <title>欢迎blue shit莅临指导&nbsp;&nbsp;</title>
        <script type='text/javascript'>
            function Go(){
                var content = document.title;
                var firstChar = content.charAt(0)
                var sub = content.substring(1,content.length)
                document.title = sub + firstChar;
            }
            setInterval('Go()',1000);
        </script>
    </head>
    <body>    
    </body>
</html>

```