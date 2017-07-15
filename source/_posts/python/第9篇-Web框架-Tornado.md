---
title: 第9篇-Web框架-Tornado
tags:
- python
---
### 概述

Tornado 是 FriendFeed 使用的可扩展的非阻塞式 web 服务器及其相关工具的开源版本。这个 Web 框架看起来有些像web.py 或者 Google 的 webapp，不过为了能有效利用非阻塞式服务器环境，这个 Web 框架还包含了一些相关的有用工具 和优化。

Tornado 和现在的主流 Web 服务器框架（包括大多数 Python 的框架）有着明显的区别：它是非阻塞式服务器，而且速度相当快。得利于其 非阻塞的方式和对 [epoll](http://www.kernel.org/doc/man-pages/online/pages/man4/epoll.4.html) 的运用，Tornado 每秒可以处理数以千计的连接，这意味着对于实时 Web 服务来说，Tornado 是一个理想的 Web 框架。我们开发这个 Web 服务器的主要目的就是为了处理 FriendFeed 的实时功能 ——在 FriendFeed 的应用里每一个活动用户都会保持着一个服务器连接。（关于如何扩容 服务器，以处理数以千计的客户端的连接的问题，请参阅 [C10K problem](http://www.kegel.com/c10k.html)。）

下载安装：

```python
pip3 install tornado
# 源码安装
https://pypi.python.org/packages/source/t/tornado/tornado-4.3.tar.gz
```

<!-- more -->

### 框架使用

#### 一、快速上手

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
   
import tornado.ioloop
import tornado.web
   
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")
   
application = tornado.web.Application([
    (r"/index", MainHandler),
])
   
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```

执行过程：

- 第一步：执行脚本，监听 8888 端口
- 第二步：浏览器客户端访问 /index  -->  http://127.0.0.1:8888/index
- 第三步：服务器接受请求，并交由对应的类处理该请求
- 第四步：类接受到请求之后，根据请求方式（post / get / delete ...）的不同调用并执行相应的方法
- 第五步：方法返回值的字符串内容发送浏览器

异步非阻塞实例

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
from tornado import httpclient
from tornado.web import asynchronous
from tornado import gen
import uimodules as md
import uimethods as mt

class MainHandler(tornado.web.RequestHandler):
        @asynchronous
        @gen.coroutine
        def get(self):
            print 'start get '
            http = httpclient.AsyncHTTPClient()
            http.fetch("http://127.0.0.1:8008/post/", self.callback)
            self.write('end')

        def callback(self, response):
            print response.body

settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'ui_methods': mt,
    'ui_modules': md,
}

application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)

if __name__ == "__main__":
    application.listen(8009)
    tornado.ioloop.IOLoop.instance().start()
```

#### 二、路由系统

路由系统其实就是 url 和 类 的对应关系，这里不同于其他框架，其他很多框架均是 url 对应 函数，Tornado中每个url对应的是一个类。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
   
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")
   
class StoryHandler(tornado.web.RequestHandler):
    def get(self, story_id):
        self.write("You requested the story " + story_id)
   
class BuyHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("buy.wupeiqi.com/index")
   
application = tornado.web.Application([
    (r"/index", MainHandler),
    (r"/story/([0-9]+)", StoryHandler),
])
   
application.add_handlers('buy.wupeiqi.com$', [
    (r'/index',BuyHandler),
])
   
if __name__ == "__main__":
    application.listen(80)
    tornado.ioloop.IOLoop.instance().start()
```

ornado中原生支持二级域名的路由，如：

<img src="https://i.loli.net/2017/07/15/59695134de7f8.png" width="400px">

#### 三、模板引擎

Tornao中的模板语言和django中类似，模板引擎将模板文件载入内存，然后将数据嵌入其中，最终获取到一个完整的字符串，再将字符串返回给请求者。

Tornado 的模板支持“控制语句”和“表达语句”，控制语句是使用 `{%` 和 `%}` 包起来的 例如 `{% if len(items) > 2 %}`。表达语句是使用 `{{` 和 `}}` 包起来的，例如 `{{ items[0] }}`。

控制语句和对应的 Python 语句的格式基本完全相同。我们支持 `if`、`for`、`while` 和 `try`，这些语句逻辑结束的位置需要用 `{% end %}` 做标记。还通过 `extends` 和 `block` 语句实现了模板继承。这些在 [`template` 模块](http://github.com/facebook/tornado/blob/master/tornado/template.py) 的代码文档中有着详细的描述。

注：在使用模板前需要在setting中设置模板路径："template_path" : "tpl"

##### 1、基本使用

app.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
  
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("index.html", list_info = [11,22,33])
  
application = tornado.web.Application([
    (r"/index", MainHandler),
])
  
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```

index.html

```html
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>老男孩</title>
    <link href="{{static_url("css/common.css")}}" rel="stylesheet" />
</head>
<body>
    <div>
        <ul>
            {% for item in list_info %}
                <li>{{item}}</li>
            {% end %}
        </ul>
    </div>
    <script src="{{static_url("js/jquery-1.8.2.min.js")}}"></script>
</body>
</html>
```

其他方法

```
在模板中默认提供了一些函数、字段、类以供模板使用：

escape: tornado.escape.xhtml_escape 的別名
xhtml_escape: tornado.escape.xhtml_escape 的別名
url_escape: tornado.escape.url_escape 的別名
json_encode: tornado.escape.json_encode 的別名
squeeze: tornado.escape.squeeze 的別名
linkify: tornado.escape.linkify 的別名
datetime: Python 的 datetime 模组
handler: 当前的 RequestHandler 对象
request: handler.request 的別名
current_user: handler.current_user 的別名
locale: handler.locale 的別名
_: handler.locale.translate 的別名
static_url: for handler.static_url 的別名
xsrf_form_html: handler.xsrf_form_html 的別名
```

##### 2、母版

layout.html

```html
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>老男孩</title>
    <link href="{{static_url("css/common.css")}}" rel="stylesheet" />
    {% block CSS %}{% end %}
</head>
<body>
    <div class="pg-header">
    </div>
    {% block RenderBody %}{% end %}
    <script src="{{static_url("js/jquery-1.8.2.min.js")}}"></script>
    {% block JavaScript %}{% end %}
</body>
</html>
```

index.html

```python
{% extends 'layout.html'%}
{% block CSS %}
    <link href="{{static_url("css/index.css")}}" rel="stylesheet" />
{% end %}
{% block RenderBody %}
    <h1>Index</h1>
    <ul>
    {%  for item in li %}
        <li>{{item}}</li>
    {% end %}
    </ul>
{% end %}
{% block JavaScript %}
{% end %}
```

##### 3、导入

header.html

```html
<div>
    <ul>
        <li>1024</li>
        <li>42区</li>
    </ul>
</div>
```

index.html

```html
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Yaro</title>
    <link href="{{static_url("css/common.css")}}" rel="stylesheet" />
</head>
<body>
    <div class="pg-header">
        {% include 'header.html' %}
    </div>
    <script src="{{static_url("js/jquery-1.8.2.min.js")}}"></script>
</body>
</html>
```

##### 4、自定义UIMethod以UIModule

a. 定义

uimethods.py

```python
def tab(self):
    return 'UIMethod'
```

uimodules.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from tornado.web import UIModule
from tornado import escape

class custom(UIModule):

    def render(self, *args, **kwargs):
        return escape.xhtml_escape('<h1>wupeiqi</h1>')
        #return escape.xhtml_escape('<h1>wupeiqi</h1>')
```

b. 注册

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
#!/usr/bin/env python
# -*- coding:utf-8 -*-

import tornado.ioloop
import tornado.web
from tornado.escape import linkify
import uimodules as md
import uimethods as mt

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')

settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'ui_methods': mt,
    'ui_modules': md,
}

application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)


if __name__ == "__main__":
    application.listen(8009)
    tornado.ioloop.IOLoop.instance().start()
```

c. 使用

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link href="{{static_url("commons.css")}}" rel="stylesheet" />
</head>
<body>
    <h1>hello</h1>
    {% module custom(123) %}
    {{ tab() }}
</body>
```

#### 四、静态文件

对于静态文件，可以配置静态文件的目录和前段使用时的前缀，并且Tornaodo还支持静态文件缓存。

app.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
 
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('home/index.html')
 
settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
}
 
application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)
 
if __name__ == "__main__":
    application.listen(80)
    tornado.ioloop.IOLoop.instance().start()
```

index.html

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link href="{{static_url("commons.css")}}" rel="stylesheet" />
</head>
<body>
    <h1>hello</h1>
</body>
</html>
```

注：静态文件缓存的实现

```python
def get_content_version(cls, abspath):
        """Returns a version string for the resource at the given path.

        This class method may be overridden by subclasses.  The
        default implementation is a hash of the file's contents.

        .. versionadded:: 3.1
        """
        data = cls.get_content(abspath)
        hasher = hashlib.md5()
        if isinstance(data, bytes):
            hasher.update(data)
        else:
            for chunk in data:
                hasher.update(chunk)
        return hasher.hexdigest()
```

#### 五、cookie

Tornado中可以对cookie进行操作，并且还可以对cookie进行签名以放置伪造。

##### 1、基本操作

```python
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        if not self.get_cookie("mycookie"):
            self.set_cookie("mycookie", "myvalue")
            self.write("Your cookie was not set yet!")
        else:
            self.write("Your cookie was set!")
```

##### 2、加密cookie（签名）

Cookie 很容易被恶意的客户端伪造。加入你想在 cookie 中保存当前登陆用户的 id 之类的信息，你需要对 cookie 作签名以防止伪造。Tornado 通过 set_secure_cookie 和 get_secure_cookie 方法直接支持了这种功能。 要使用这些方法，你需要在创建应用时提供一个密钥，名字为 cookie_secret。 你可以把它作为一个关键词参数传入应用的设置中：

```python
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        if not self.get_secure_cookie("mycookie"):
            self.set_secure_cookie("mycookie", "myvalue")
            self.write("Your cookie was not set yet!")
        else:
            self.write("Your cookie was set!")
             
application = tornado.web.Application([
    (r"/", MainHandler),
], cookie_secret="61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=")
```

内部算法

```python
def _create_signature_v1(secret, *parts):
    hash = hmac.new(utf8(secret), digestmod=hashlib.sha1)
    for part in parts:
        hash.update(utf8(part))
    return utf8(hash.hexdigest())

# 加密
def _create_signature_v2(secret, s):
    hash = hmac.new(utf8(secret), digestmod=hashlib.sha256)
    hash.update(utf8(s))
    return utf8(hash.hexdigest())

def create_signed_value(secret, name, value, version=None, clock=None,
                        key_version=None):
    if version is None:
        version = DEFAULT_SIGNED_VALUE_VERSION
    if clock is None:
        clock = time.time

    timestamp = utf8(str(int(clock())))
    value = base64.b64encode(utf8(value))
    if version == 1:
        signature = _create_signature_v1(secret, name, value, timestamp)
        value = b"|".join([value, timestamp, signature])
        return value
    elif version == 2:
        # The v2 format consists of a version number and a series of
        # length-prefixed fields "%d:%s", the last of which is a
        # signature, all separated by pipes.  All numbers are in
        # decimal format with no leading zeros.  The signature is an
        # HMAC-SHA256 of the whole string up to that point, including
        # the final pipe.
        #
        # The fields are:
        # - format version (i.e. 2; no length prefix)
        # - key version (integer, default is 0)
        # - timestamp (integer seconds since epoch)
        # - name (not encoded; assumed to be ~alphanumeric)
        # - value (base64-encoded)
        # - signature (hex-encoded; no length prefix)
        def format_field(s):
            return utf8("%d:" % len(s)) + utf8(s)
        to_sign = b"|".join([
            b"2",
            format_field(str(key_version or 0)),
            format_field(timestamp),
            format_field(name),
            format_field(value),
            b''])

        if isinstance(secret, dict):
            assert key_version is not None, 'Key version must be set when sign key dict is used'
            assert version >= 2, 'Version must be at least 2 for key version support'
            secret = secret[key_version]

        signature = _create_signature_v2(secret, to_sign)
        return to_sign + signature
    else:
        raise ValueError("Unsupported version %d" % version)

# 解密
def _decode_signed_value_v1(secret, name, value, max_age_days, clock):
    parts = utf8(value).split(b"|")
    if len(parts) != 3:
        return None
    signature = _create_signature_v1(secret, name, parts[0], parts[1])
    if not _time_independent_equals(parts[2], signature):
        gen_log.warning("Invalid cookie signature %r", value)
        return None
    timestamp = int(parts[1])
    if timestamp < clock() - max_age_days * 86400:
        gen_log.warning("Expired cookie %r", value)
        return None
    if timestamp > clock() + 31 * 86400:
        # _cookie_signature does not hash a delimiter between the
        # parts of the cookie, so an attacker could transfer trailing
        # digits from the payload to the timestamp without altering the
        # signature.  For backwards compatibility, sanity-check timestamp
        # here instead of modifying _cookie_signature.
        gen_log.warning("Cookie timestamp in future; possible tampering %r",
                        value)
        return None
    if parts[1].startswith(b"0"):
        gen_log.warning("Tampered cookie %r", value)
        return None
    try:
        return base64.b64decode(parts[0])
    except Exception:
        return None

def _decode_fields_v2(value):
    def _consume_field(s):
        length, _, rest = s.partition(b':')
        n = int(length)
        field_value = rest[:n]
        # In python 3, indexing bytes returns small integers; we must
        # use a slice to get a byte string as in python 2.
        if rest[n:n + 1] != b'|':
            raise ValueError("malformed v2 signed value field")
        rest = rest[n + 1:]
        return field_value, rest

    rest = value[2:]  # remove version number
    key_version, rest = _consume_field(rest)
    timestamp, rest = _consume_field(rest)
    name_field, rest = _consume_field(rest)
    value_field, passed_sig = _consume_field(rest)
    return int(key_version), timestamp, name_field, value_field, passed_sig

def _decode_signed_value_v2(secret, name, value, max_age_days, clock):
    try:
        key_version, timestamp, name_field, value_field, passed_sig = _decode_fields_v2(value)
    except ValueError:
        return None
    signed_string = value[:-len(passed_sig)]

    if isinstance(secret, dict):
        try:
            secret = secret[key_version]
        except KeyError:
            return None

    expected_sig = _create_signature_v2(secret, signed_string)
    if not _time_independent_equals(passed_sig, expected_sig):
        return None
    if name_field != utf8(name):
        return None
    timestamp = int(timestamp)
    if timestamp < clock() - max_age_days * 86400:
        # The signature has expired.
        return None
    try:
        return base64.b64decode(value_field)
    except Exception:
        return None

def get_signature_key_version(value):
    value = utf8(value)
    version = _get_version(value)
    if version < 2:
        return None
    try:
        key_version, _, _, _, _ = _decode_fields_v2(value)
    except ValueError:
        return None

    return key_version
```

签名Cookie的本质是：

```
写cookie过程：

将值进行base64加密
对除值以外的内容进行签名，哈希算法（无法逆向解析）
拼接 签名 + 加密值
读cookie过程：

读取 签名 + 加密值
对签名进行验证
base64解密，获取值内容
```

注：许多API验证机制和安全cookie的实现机制相同。

 基于Cookie实现用户验证-Demo

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
 
class MainHandler(tornado.web.RequestHandler):
 
    def get(self):
        login_user = self.get_secure_cookie("login_user", None)
        if login_user:
            self.write(login_user)
        else:
            self.redirect('/login')
 
class LoginHandler(tornado.web.RequestHandler):
    def get(self):
        self.current_user()
 
        self.render('login.html', **{'status': ''})
 
    def post(self, *args, **kwargs):
 
        username = self.get_argument('name')
        password = self.get_argument('pwd')
        if username == 'wupeiqi' and password == '123':
            self.set_secure_cookie('login_user', '武沛齐')
            self.redirect('/')
        else:
            self.render('login.html', **{'status': '用户名或密码错误'})
 
settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh'
}
 
application = tornado.web.Application([
    (r"/index", MainHandler),
    (r"/login", LoginHandler),
], **settings)
 
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```

 基于签名Cookie实现用户验证-Demo

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
 
class BaseHandler(tornado.web.RequestHandler):
 
    def get_current_user(self):
        return self.get_secure_cookie("login_user")
 
class MainHandler(BaseHandler):
 
    @tornado.web.authenticated
    def get(self):
        login_user = self.current_user
        self.write(login_user)
 
class LoginHandler(tornado.web.RequestHandler):
    def get(self):
        self.current_user()
 
        self.render('login.html', **{'status': ''})
 
    def post(self, *args, **kwargs):
 
        username = self.get_argument('name')
        password = self.get_argument('pwd')
        if username == 'wupeiqi' and password == '123':
            self.set_secure_cookie('login_user', '武沛齐')
            self.redirect('/')
        else:
            self.render('login.html', **{'status': '用户名或密码错误'})
 
settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh',
    'login_url': '/login'
}
 
application = tornado.web.Application([
    (r"/index", MainHandler),
    (r"/login", LoginHandler),
], **settings)
 
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```

##### 3、JavaScript操作Cookie

由于Cookie保存在浏览器端，所以在浏览器端也可以使用JavaScript来操作Cookie。

```javascript
/*
设置cookie，指定秒数过期
 */
function setCookie(name,value,expires){
    var temp = [];
    var current_date = new Date();
    current_date.setSeconds(current_date.getSeconds() + 5);
    document.cookie = name + "= "+ value +";expires=" + current_date.toUTCString();
}
```

对于参数：

- domain   指定域名下的cookie
- path       域名下指定url中的cookie
- secure    https使用

注：jQuery中也有指定的插件 jQuery Cookie 专门用于操作cookie，[猛击这里](http://plugins.jquery.com/cookie/)

#### 六、CSRF

ornado中的夸张请求伪造和Django中的相似，[跨站伪造请求(Cross-site request forgery)](http://en.wikipedia.org/wiki/Cross-site_request_forgery)

 配置

```python
settings = {
    "xsrf_cookies": True,
}
application = tornado.web.Application([
    (r"/", MainHandler),
    (r"/login", LoginHandler),
], **settings)
```

 使用 - 普通表单

```html
<form action="/new_message" method="post">
  {{ xsrf_form_html() }}
  <input type="text" name="message"/>
  <input type="submit" value="Post"/>
</form>
```

 使用 - AJAX

```javascript
function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

jQuery.postJSON = function(url, args, callback) {
    args._xsrf = getCookie("_xsrf");
    $.ajax({url: url, data: $.param(args), dataType: "text", type: "POST",
        success: function(response) {
        callback(eval("(" + response + ")"));
    }});
};
```

注：Ajax使用时，本质上就是去获取本地的cookie，携带cookie再来发送请求

#### 七、上传文件

##### 1、Form表单上传

html

```html
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>上传文件</title>
</head>
<body>
    <form id="my_form" name="form" action="/index" method="POST"  enctype="multipart/form-data" >
        <input name="fff" id="my_file"  type="file" />
        <input type="submit" value="提交"  />
    </form>
</body>
</html>
```

python

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):

        self.render('index.html')

    def post(self, *args, **kwargs):
        file_metas = self.request.files["fff"]
        # print(file_metas)
        for meta in file_metas:
            file_name = meta['filename']
            with open(file_name,'wb') as up:
                up.write(meta['body'])

settings = {
    'template_path': 'template',
}

application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)

if __name__ == "__main__":
    application.listen(8000)
    tornado.ioloop.IOLoop.instance().start()
```

##### 2、AJAX上传

 HTML - XMLHttpRequest

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
    <input type="file" id="img" />
    <input type="button" onclick="UploadFile();" />
    <script>
        function UploadFile(){
            var fileObj = document.getElementById("img").files[0];

            var form = new FormData();
            form.append("k1", "v1");
            form.append("fff", fileObj);

            var xhr = new XMLHttpRequest();
            xhr.open("post", '/index', true);
            xhr.send(form);
        }
    </script>
</body>
</html>
```

 HTML - jQuery

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
    <input type="file" id="img" />
    <input type="button" onclick="UploadFile();" />
    <script>
        function UploadFile(){
            var fileObj = $("#img")[0].files[0];
            var form = new FormData();
            form.append("k1", "v1");
            form.append("fff", fileObj);

            $.ajax({
                type:'POST',
                url: '/index',
                data: form,
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                success: function(arg){
                    console.log(arg);
                }
            })
        }
    </script>
</body>
</html>
```

 HTML - iframe

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
    <form id="my_form" name="form" action="/index" method="POST"  enctype="multipart/form-data" >
        <div id="main">
            <input name="fff" id="my_file"  type="file" />
            <input type="button" name="action" value="Upload" onclick="redirect()"/>
            <iframe id='my_iframe' name='my_iframe' src=""  class="hide"></iframe>
        </div>
    </form>

    <script>
        function redirect(){
            document.getElementById('my_iframe').onload = Testt;
            document.getElementById('my_form').target = 'my_iframe';
            document.getElementById('my_form').submit();

        }
        
        function Testt(ths){
            var t = $("#my_iframe").contents().find("body").text();
            console.log(t);
        }
    </script>
</body>
</html>
```

 Python

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import tornado.ioloop
import tornado.web
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')
        
    def post(self, *args, **kwargs):
        file_metas = self.request.files["fff"]
        # print(file_metas)
        for meta in file_metas:
            file_name = meta['filename']
            with open(file_name,'wb') as up:
                up.write(meta['body'])
settings = {
    'template_path': 'template',
}

application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)

if __name__ == "__main__":
    application.listen(8000)
    tornado.ioloop.IOLoop.instance().start()
```

 扩展：基于iframe实现Ajax上传示例

```html
<script type="text/javascript">
    $(document).ready(function () {
        $("#formsubmit").click(function () {
            var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none"></iframe>');
 
            $("body").append(iframe);
 
            var form = $('#theuploadform');
            form.attr("action", "/upload.aspx");
            form.attr("method", "post");
 
            form.attr("encoding", "multipart/form-data");
            form.attr("enctype", "multipart/form-data");
 
            form.attr("target", "postiframe");
            form.attr("file", $('#userfile').val());
            form.submit();
 
            $("#postiframe").load(function () {
                iframeContents = this.contentWindow.document.body.innerHTML;
                $("#textarea").html(iframeContents);
            });
            return false;
        });
    });
 
</script>
 
<form id="theuploadform">
    <input id="userfile" name="userfile" size="50" type="file" />
    <input id="formsubmit" type="submit" value="Send File" />
</form>
 
<div id="textarea">
</div>
```

```javascript
 $('#upload_iframe').load(function(){
                    var iframeContents = this.contentWindow.document.body.innerText;
                    iframeContents = JSON.parse(iframeContents);
                })
```

 其他

```javascript
		function bindChangeAvatar1() {
            $('#avatarImg').change(function () {
                var file_obj = $(this)[0].files[0];
                $('#prevViewImg')[0].src = window.URL.createObjectURL(file_obj)
            })
        }

        function bindChangeAvatar2() {
            $('#avatarImg').change(function () {
                var file_obj = $(this)[0].files[0];
                var reader = new FileReader();
                reader.readAsDataURL(file_obj);
                reader.onload = function (e) {
                    $('#previewImg')[0].src = this.result;
                };
            })
        }

        function bindChangeAvatar3() {
            $('#avatarImg').change(function () {
                var file_obj = $(this)[0].files[0];
                var form = new FormData();
                form.add('img_upload', file_obj);

                $.ajax({
                    url: '',
                    data: form,
                    processData: false,  // tell jQuery not to process the data
                    contentType: false,  // tell jQuery not to set contentType
                    success: function (arg) {

                    }
                })
            })
        }

        function bindChangeAvatar4() {
            $('#avatarImg').change(function () {
                $(this).parent().submit();

                $('#upload_iframe').load(function () {
                    var iframeContents = this.contentWindow.document.body.innerText;
                    iframeContents = JSON.parse(iframeContents);
                    if (iframeContents.status) {
                        $('#previewImg').attr('src', '/' + iframeContents.data);
                    }
                })

            })
        }
```

#### 八、验证码

验证码原理在于后台自动创建一张带有随机内容的图片，然后将内容通过img标签输出到页面。

安装图像处理模块：

```python
pip3 install pillow
```

实例截图

<img src="https://i.loli.net/2017/07/15/596956834858c.png" width="400px">

验证码Demo源码下载：猛击这里

#### 九、异步非阻塞

##### 1、基本使用

装饰器 + Future 从而实现Tornado的异步非阻塞

```python
class AsyncHandler(tornado.web.RequestHandler):
 
    @gen.coroutine
    def get(self):
        future = Future()
        future.add_done_callback(self.doing)
        yield future
        # 或
        # tornado.ioloop.IOLoop.current().add_future(future,self.doing)
        # yield future
 
    def doing(self,*args, **kwargs):
        self.write('async')
        self.finish()
```

当发送GET请求时，由于方法被@gen.coroutine装饰且yield 一个 Future对象，那么Tornado会等待，等待用户向future对象中放置数据或者发送信号，如果获取到数据或信号之后，就开始执行doing方法。

异步非阻塞体现在当在Tornaod等待用户向future对象中放置数据时，还可以处理其他请求。

注意：在等待用户向future对象中放置数据或信号时，此连接是不断开的。

##### 2、同步阻塞和异步非阻塞对比

 同步阻塞

```python
class SyncHandler(tornado.web.RequestHandler):

    def get(self):
        self.doing()
        self.write('sync')

    def doing(self):
        time.sleep(10)
```

 异步非阻塞

```python
class AsyncHandler(tornado.web.RequestHandler):
    @gen.coroutine
    def get(self):
        future = Future()
        tornado.ioloop.IOLoop.current().add_timeout(time.time() + 5, self.doing)
        yield future

    def doing(self, *args, **kwargs):
        self.write('async')
        self.finish()
```

##### 3、httpclient类库

Tornado提供了httpclient类库用于发送Http请求，其配合Tornado的异步非阻塞使用。

```python
class AsyncHandler(tornado.web.RequestHandler):
    @gen.coroutine
    def get(self):
        from tornado import httpclient
 
        http = httpclient.AsyncHTTPClient()
        yield http.fetch("http://www.google.com", self.endding)
 
    def endding(self, response):
        print(len(response.body))
        self.write('ok')
        self.finish()
```

### 自定义Web组件

#### 一、Session

##### 1、面向对象基础

面向对象中通过索引的方式访问对象，需要内部实现 __getitem__ 、__delitem__、__setitem__方法

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
class Foo(object):
   
    def __getitem__(self, key):
        print  '__getitem__',key
   
    def __setitem__(self, key, value):
        print '__setitem__',key,value
   
    def __delitem__(self, key):
        print '__delitem__',key
   
obj = Foo()
result = obj['k1']
#obj['k2'] = 'wupeiqi'
#del obj['k1']
```

##### 2、Tornado扩展

Tornado框架中，默认执行Handler的get/post等方法之前默认会执行 initialize方法，所以可以通过自定义的方式使得所有请求在处理前执行操作...

```python
class BaseHandler(tornado.web.RequestHandler):
   
    def initialize(self):
        self.xxoo = "wupeiqi"
   
class MainHandler(BaseHandler):
   
    def get(self):
        print(self.xxoo)
        self.write('index')
 
class IndexHandler(BaseHandler):
   
    def get(self):
        print(self.xxoo)
        self.write('index')
```

##### 3、session

session其实就是定义在服务器端用于保存用户回话的容器，其必须依赖cookie才能实现。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import config
from hashlib import sha1
import os
import time

create_session_id = lambda: sha1(bytes('%s%s' % (os.urandom(16), time.time()), encoding='utf-8')).hexdigest()

class SessionFactory:

    @staticmethod
    def get_session_obj(handler):
        obj = None

        if config.SESSION_TYPE == "cache":
            obj = CacheSession(handler)
        elif config.SESSION_TYPE == "memcached":
            obj = MemcachedSession(handler)
        elif config.SESSION_TYPE == "redis":
            obj = RedisSession(handler)
        return obj

class CacheSession:
    session_container = {}
    session_id = "__sessionId__"

    def __init__(self, handler):
        self.handler = handler
        client_random_str = handler.get_cookie(CacheSession.session_id, None)
        if client_random_str and client_random_str in CacheSession.session_container:
            self.random_str = client_random_str
        else:
            self.random_str = create_session_id()
            CacheSession.session_container[self.random_str] = {}

        expires_time = time.time() + config.SESSION_EXPIRES
        handler.set_cookie(CacheSession.session_id, self.random_str, expires=expires_time)

    def __getitem__(self, key):
        ret = CacheSession.session_container[self.random_str].get(key, None)
        return ret

    def __setitem__(self, key, value):
        CacheSession.session_container[self.random_str][key] = value

    def __delitem__(self, key):
        if key in CacheSession.session_container[self.random_str]:
            del CacheSession.session_container[self.random_str][key]

class RedisSession:
    def __init__(self, handler):
        pass

class MemcachedSession:
    def __init__(self, handler):
        pass
```

##### 4、分布式Session

 一致性哈希

```python
#!/usr/bin/env python
#coding:utf-8

import sys
import math
from bisect import bisect

if sys.version_info >= (2, 5):
    import hashlib
    md5_constructor = hashlib.md5
else:
    import md5
    md5_constructor = md5.new

class HashRing(object):
    """一致性哈希"""
    
    def __init__(self,nodes):
        '''初始化
        nodes : 初始化的节点，其中包含节点已经节点对应的权重
                默认每一个节点有32个虚拟节点
                对于权重，通过多创建虚拟节点来实现
                如：nodes = [
                        {'host':'127.0.0.1:8000','weight':1},
                        {'host':'127.0.0.1:8001','weight':2},
                        {'host':'127.0.0.1:8002','weight':1},
                    ]
        '''
        self.ring = dict()
        self._sorted_keys = []

        self.total_weight = 0
        
        self.__generate_circle(nodes)
        
    def __generate_circle(self,nodes):
        for node_info in nodes:
            self.total_weight += node_info.get('weight',1)
            
        for node_info in nodes:
            weight = node_info.get('weight',1)
            node = node_info.get('host',None)
                
            virtual_node_count = math.floor((32*len(nodes)*weight) / self.total_weight)
            for i in xrange(0,int(virtual_node_count)):
                key = self.gen_key_thirty_two( '%s-%s' % (node, i) )
                if self._sorted_keys.__contains__(key):
                    raise Exception('该节点已经存在.')
                self.ring[key] = node
                self._sorted_keys.append(key)
            
    def add_node(self,node):
        ''' 新建节点
        node : 要添加的节点，格式为：{'host':'127.0.0.1:8002','weight':1}，其中第一个元素表示节点，第二个元素表示该节点的权重。
        '''
        node = node.get('host',None)
        if not node:
                raise Exception('节点的地址不能为空.')
                
        weight = node.get('weight',1)
        
        self.total_weight += weight
        nodes_count = len(self._sorted_keys) + 1
        
        virtual_node_count = math.floor((32 * nodes_count * weight) / self.total_weight)
        for i in xrange(0,int(virtual_node_count)):
            key = self.gen_key_thirty_two( '%s-%s' % (node, i) )
            if self._sorted_keys.__contains__(key):
                raise Exception('该节点已经存在.')
            self.ring[key] = node
            self._sorted_keys.append(key)
        
    def remove_node(self,node):
        ''' 移除节点
        node : 要移除的节点 '127.0.0.1:8000'
        '''
        for key,value in self.ring.items():
            if value == node:
                del self.ring[key]
                self._sorted_keys.remove(key)
    
    def get_node(self,string_key):
        '''获取 string_key 所在的节点'''
        pos = self.get_node_pos(string_key)
        if pos is None:
            return None
        return self.ring[ self._sorted_keys[pos]].split(':')
    
    def get_node_pos(self,string_key):
        '''获取 string_key 所在的节点的索引'''
        if not self.ring:
            return None
            
        key = self.gen_key_thirty_two(string_key)
        nodes = self._sorted_keys
        pos = bisect(nodes, key)
        return pos
    
    def gen_key_thirty_two(self, key):
        
        m = md5_constructor()
        m.update(key)
        return long(m.hexdigest(), 16)
        
    def gen_key_sixteen(self,key):
        
        b_key = self.__hash_digest(key)
        return self.__hash_val(b_key, lambda x: x)

    def __hash_val(self, b_key, entry_fn):
        return (( b_key[entry_fn(3)] << 24)|(b_key[entry_fn(2)] << 16)|(b_key[entry_fn(1)] << 8)| b_key[entry_fn(0)] )

    def __hash_digest(self, key):
        m = md5_constructor()
        m.update(key)
        return map(ord, m.digest())

"""
nodes = [
    {'host':'127.0.0.1:8000','weight':1},
    {'host':'127.0.0.1:8001','weight':2},
    {'host':'127.0.0.1:8002','weight':1},
]

ring = HashRing(nodes)
result = ring.get_node('98708798709870987098709879087')
print result

"""
```

 session

```python
from hashlib import sha1
import os, time

create_session_id = lambda: sha1('%s%s' % (os.urandom(16), time.time())).hexdigest()

class Session(object):

    session_id = "__sessionId__"

    def __init__(self, request):
        session_value = request.get_cookie(Session.session_id)
        if not session_value:
            self._id = create_session_id()
        else:
            self._id = session_value
        request.set_cookie(Session.session_id, self._id)

    def __getitem__(self, key):
        # 根据 self._id ，在一致性哈西中找到其对应的服务器IP
        # 找到相对应的redis服务器，如： r = redis.StrictRedis(host='localhost', port=6379, db=0)
        # 使用python redis api 链接
        # 获取数据，即：
        # return self._redis.hget(self._id, name)

    def __setitem__(self, key, value):
        # 根据 self._id ，在一致性哈西中找到其对应的服务器IP
        # 使用python redis api 链接
        # 设置session
        # self._redis.hset(self._id, name, value)

    def __delitem__(self, key):
        # 根据 self._id 找到相对应的redis服务器
        # 使用python redis api 链接
        # 删除，即：
        return self._redis.hdel(self._id, name)
```

#### 二、表单验证

在Web程序中往往包含大量的表单验证的工作，如：判断输入是否为空，是否符合规则。

 HTML

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link href="{{static_url("commons.css")}}" rel="stylesheet" />
</head>
<body>
    <h1>hello</h1>
    <form action="/index" method="post">

        <p>hostname: <input type="text" name="host" /> </p>
        <p>ip: <input type="text" name="ip" /> </p>
        <p>port: <input type="text" name="port" /> </p>
        <p>phone: <input type="text" name="phone" /> </p>
        <input type="submit" />
    </form>
</body>
</html>
```

 Python

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
  
import tornado.ioloop
import tornado.web
from hashlib import sha1
import os, time
import re
  
class MainForm(object):
    def __init__(self):
        self.host = "(.*)"
        self.ip = "^(25[0-5]|2[0-4]\d|[0-1]?\d?\d)(\.(25[0-5]|2[0-4]\d|[0-1]?\d?\d)){3}$"
        self.port = '(\d+)'
        self.phone = '^1[3|4|5|8][0-9]\d{8}$'
  
    def check_valid(self, request):
        form_dict = self.__dict__
        for key, regular in form_dict.items():
            post_value = request.get_argument(key)
            # 让提交的数据 和 定义的正则表达式进行匹配
            ret = re.match(regular, post_value)
            print key,ret,post_value
  
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')
    def post(self, *args, **kwargs):
        obj = MainForm()
        result = obj.check_valid(self)
        self.write('ok')
  
settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh',
    'login_url': '/login'
}
  
application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)
  
  
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```

由于验证规则可以代码重用，所以可以如此定义：

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-

import tornado.ioloop
import tornado.web
import re


class Field(object):

    def __init__(self, error_msg_dict, required):
        self.id_valid = False
        self.value = None
        self.error = None
        self.name = None
        self.error_msg = error_msg_dict
        self.required = required

    def match(self, name, value):
        self.name = name

        if not self.required:
            self.id_valid = True
            self.value = value
        else:
            if not value:
                if self.error_msg.get('required', None):
                    self.error = self.error_msg['required']
                else:
                    self.error = "%s is required" % name
            else:
                ret = re.match(self.REGULAR, value)
                if ret:
                    self.id_valid = True
                    self.value = ret.group()
                else:
                    if self.error_msg.get('valid', None):
                        self.error = self.error_msg['valid']
                    else:
                        self.error = "%s is invalid" % name


class IPField(Field):
    REGULAR = "^(25[0-5]|2[0-4]\d|[0-1]?\d?\d)(\.(25[0-5]|2[0-4]\d|[0-1]?\d?\d)){3}$"

    def __init__(self, error_msg_dict=None, required=True):

        error_msg = {}  # {'required': 'IP不能为空', 'valid': 'IP格式错误'}
        if error_msg_dict:
            error_msg.update(error_msg_dict)

        super(IPField, self).__init__(error_msg_dict=error_msg, required=required)


class IntegerField(Field):
    REGULAR = "^\d+$"

    def __init__(self, error_msg_dict=None, required=True):
        error_msg = {'required': '数字不能为空', 'valid': '数字格式错误'}
        if error_msg_dict:
            error_msg.update(error_msg_dict)

        super(IntegerField, self).__init__(error_msg_dict=error_msg, required=required)


class CheckBoxField(Field):

    def __init__(self, error_msg_dict=None, required=True):
        error_msg = {}  # {'required': 'IP不能为空', 'valid': 'IP格式错误'}
        if error_msg_dict:
            error_msg.update(error_msg_dict)

        super(CheckBoxField, self).__init__(error_msg_dict=error_msg, required=required)

    def match(self, name, value):
        self.name = name

        if not self.required:
            self.id_valid = True
            self.value = value
        else:
            if not value:
                if self.error_msg.get('required', None):
                    self.error = self.error_msg['required']
                else:
                    self.error = "%s is required" % name
            else:
                if isinstance(name, list):
                    self.id_valid = True
                    self.value = value
                else:
                    if self.error_msg.get('valid', None):
                        self.error = self.error_msg['valid']
                    else:
                        self.error = "%s is invalid" % name


class FileField(Field):
    REGULAR = "^(\w+\.pdf)|(\w+\.mp3)|(\w+\.py)$"

    def __init__(self, error_msg_dict=None, required=True):
        error_msg = {}  # {'required': '数字不能为空', 'valid': '数字格式错误'}
        if error_msg_dict:
            error_msg.update(error_msg_dict)

        super(FileField, self).__init__(error_msg_dict=error_msg, required=required)

    def match(self, name, value):
        self.name = name
        self.value = []
        if not self.required:
            self.id_valid = True
            self.value = value
        else:
            if not value:
                if self.error_msg.get('required', None):
                    self.error = self.error_msg['required']
                else:
                    self.error = "%s is required" % name
            else:
                m = re.compile(self.REGULAR)
                if isinstance(value, list):
                    for file_name in value:
                        r = m.match(file_name)
                        if r:
                            self.value.append(r.group())
                            self.id_valid = True
                        else:
                            self.id_valid = False
                            if self.error_msg.get('valid', None):
                                self.error = self.error_msg['valid']
                            else:
                                self.error = "%s is invalid" % name
                            break
                else:
                    if self.error_msg.get('valid', None):
                        self.error = self.error_msg['valid']
                    else:
                        self.error = "%s is invalid" % name

    def save(self, request, upload_path=""):

        file_metas = request.files[self.name]
        for meta in file_metas:
            file_name = meta['filename']
            with open(file_name,'wb') as up:
                up.write(meta['body'])


class Form(object):

    def __init__(self):
        self.value_dict = {}
        self.error_dict = {}
        self.valid_status = True

    def validate(self, request, depth=10, pre_key=""):

        self.initialize()
        self.__valid(self, request, depth, pre_key)

    def initialize(self):
        pass

    def __valid(self, form_obj, request, depth, pre_key):
        """
        验证用户表单请求的数据
        :param form_obj: Form对象（Form派生类的对象）
        :param request: Http请求上下文（用于从请求中获取用户提交的值）
        :param depth: 对Form内容的深度的支持
        :param pre_key: Html中name属性值的前缀（多层Form时，内部递归时设置，无需理会）
        :return: 是否验证通过，True：验证成功；False：验证失败
        """

        depth -= 1
        if depth < 0:
            return None
        form_field_dict = form_obj.__dict__
        for key, field_obj in form_field_dict.items():
            print key,field_obj
            if isinstance(field_obj, Form) or isinstance(field_obj, Field):
                if isinstance(field_obj, Form):
                    # 获取以key开头的所有的值，以参数的形式传至
                    self.__valid(field_obj, request, depth, key)
                    continue
                if pre_key:
                    key = "%s.%s" % (pre_key, key)

                if isinstance(field_obj, CheckBoxField):
                    post_value = request.get_arguments(key, None)
                elif isinstance(field_obj, FileField):
                    post_value = []
                    file_list = request.request.files.get(key, None)
                    for file_item in file_list:
                        post_value.append(file_item['filename'])
                else:
                    post_value = request.get_argument(key, None)

                print post_value
                # 让提交的数据 和 定义的正则表达式进行匹配
                field_obj.match(key, post_value)
                if field_obj.id_valid:
                    self.value_dict[key] = field_obj.value
                else:
                    self.error_dict[key] = field_obj.error
                    self.valid_status = False


class ListForm(object):
    def __init__(self, form_type):
        self.form_type = form_type
        self.valid_status = True
        self.value_dict = {}
        self.error_dict = {}

    def validate(self, request):
        name_list = request.request.arguments.keys() + request.request.files.keys()
        index = 0
        flag = False
        while True:
            pre_key = "[%d]" % index
            for name in name_list:
                if name.startswith(pre_key):
                    flag = True
                    break
            if flag:
                form_obj = self.form_type()
                form_obj.validate(request, depth=10, pre_key="[%d]" % index)
                if form_obj.valid_status:
                    self.value_dict[index] = form_obj.value_dict
                else:
                    self.error_dict[index] = form_obj.error_dict
                    self.valid_status = False
            else:
                break

            index += 1
            flag = False


class MainForm(Form):

    def __init__(self):
        # self.ip = IPField(required=True)
        # self.port = IntegerField(required=True)
        # self.new_ip = IPField(required=True)
        # self.second = SecondForm()
        self.fff = FileField(required=True)
        super(MainForm, self).__init__()

#
# class SecondForm(Form):
#
#     def __init__(self):
#         self.ip = IPField(required=True)
#         self.new_ip = IPField(required=True)
#
#         super(SecondForm, self).__init__()


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')
    def post(self, *args, **kwargs):
        # for i in  dir(self.request):
        #     print i
        # print self.request.arguments
        # print self.request.files
        # print self.request.query
        # name_list = self.request.arguments.keys() + self.request.files.keys()
        # print name_list

        # list_form = ListForm(MainForm)
        # list_form.validate(self)
        #
        # print list_form.valid_status
        # print list_form.value_dict
        # print list_form.error_dict

        # obj = MainForm()
        # obj.validate(self)
        #
        # print "验证结果：", obj.valid_status
        # print "符合验证结果：", obj.value_dict
        # print "错误信息:"
        # for key, item in obj.error_dict.items():
        #     print key,item
        # print self.get_arguments('favor'),type(self.get_arguments('favor'))
        # print self.get_argument('favor'),type(self.get_argument('favor'))
        # print type(self.get_argument('fff')),self.get_argument('fff')
        # print self.request.files
        # obj = MainForm()
        # obj.validate(self)
        # print obj.valid_status
        # print obj.value_dict
        # print obj.error_dict
        # print self.request,type(self.request)
        # obj.fff.save(self.request)
        # from tornado.httputil import HTTPServerRequest
        # name_list = self.request.arguments.keys() + self.request.files.keys()
        # print name_list
        # print self.request.files,type(self.request.files)
        # print len(self.request.files.get('fff'))
        
        # obj = MainForm()
        # obj.validate(self)
        # print obj.valid_status
        # print obj.value_dict
        # print obj.error_dict
        # obj.fff.save(self.request)
        self.write('ok')


settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh',
    'login_url': '/login'
}

application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```