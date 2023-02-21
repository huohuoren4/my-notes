## 前端内容
#### 1. HTML
##### 1.1 html-5 的模板
- 模板示例
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- 定义文档关键词，用于搜索引擎 -->
        <meta name="keywords" content="w3cschool,HTML,CSS">
        <!-- 定义web页面描述 -->
        <meta name="description" content="菜鸟教程(www.runoob.com)提供了编程的基础技术教程">
        <!-- 网页标签的图标 -->
        <link rel="icon" href="https://static.runoob.com/images/favicon.ico">

        <!-- CSS脚本 -->
        <!-- font-awesome4 css脚本 -->
        <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css"/>	
        <!-- bootstrap4 css脚本 -->
        <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
        <!-- 自定义 css脚本 -->
        <style>
            


        </style>
        <!-- 网页标题 -->
        <title>测试脚本</title>
    </head>
    <body>
        <!-- 网页正文 -->




        <!-- JS 脚本 -->
        <!-- jquery 脚本 -->
        <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
        <!-- bootstrap4 js脚本 -->
        <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
        <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <!-- 自定义 js脚本 -->
        <script>
            


        </script>
    </body>
    </html>
    ```
---
#### 2. CSS
##### 2.1 常用样式
- 常用样式示例
    ```css
    <style>
        h1{
            /* 背景 */
            background-color: aliceblue;

            /* 字体 */
            /* 1em和当前字体大小相等。在浏览器中默认的文字大小是16px */
            color: red;
            font-size: 1.5em;
            font-weight: bold;
            font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
            text-align: center;
            text-decoration: underline;

            /* !important 与优先级无关，但它与最终的结果直接相关 */
            background-color: red !important;
            
            /* 光标 */
            cursor: pointer;  /* 光标显示为手 */
        }

        /* 链接样式 */
        a:link {color:#000000;}      /* 未访问链接*/
        a:visited {color:#00FF00;}  /* 已访问链接 */
        a:hover {color:#FF00FF;}  /* 鼠标移动到链接上 */
        a:active {color:#0000FF;}  /* 鼠标点击时 */
        a:first-child {} /* 第一个 a 元素 */

        /* 列表样式 */
        ul {
            list-style-type: disc;
            margin: 0;
            padding: 0;
        }

        /* 盒子模型 */
        div {
            width: 70%;
            padding: 10px;
            border: 5px solid gray;
            margin: auto; 
            vertical-align:bottom
        }
        
        li {
            /* 显示 */
            display: block;   /* 值为 none, 隐藏元素不占空间 */
            visibility: visible;    /* 值为 hidden, 隐藏元素占空间 */

            /* 位置 */
            position: sticky;  /* 基于用户的滚动位置来定位 */
            position: relative;  /* 相对定位元素的定位是相对其正常位置 */
            position: absolute;  /* 绝对定位的元素的位置相对于最近的已定位父元素 */
            /* z-index属性指定了一个元素的堆叠顺序（哪个元素应该放在前面，或后面 */
            z-index:-1;
        }

        /* 选择器 */
        p#marked{ }  /* 为所有 p 元素 id="marked" 指定一个样式 */
        .marked{ } /* 为所有 class="marked" 的元素指定一个样式。*/
        .marked p{ }  /* 为所有 class="marked" 元素内的 p 元素指定一个样式 */
        p.marked{ }  /* 为所有 class="marked" 的 p 元素指定一个样 */
        p[name="weoewo"] {}  /* 属性选择器 */
        /* 后代选择器(以空格分隔)
        子元素选择器(以大于 > 号分隔）
        相邻兄弟选择器（以加号 + 分隔）
        普通兄弟选择器（以波浪号 ～ 分隔） */

        /* 布局 */
        p {
            /* 要水平居中对齐一个元素(如 <div>), 可以使用 margin: auto; */
            margin: auto;
            /* 浮动, 左对齐 */
            float: left;
        }
        /* 在父元素上添加 overflow: auto; 来解决子元素溢出的问题 */
        .clearfix {
            margin: auto;
        }

        /* 响应式布局 -屏幕尺寸小于 400px 时，导航等布局改为上下布局 */
        @media screen and (max-width: 400px) {
            .topnav a {
                float: none;
                width: 100%;
            }
        }
    </style>
    ```
---
#### 3. Javascript
##### 3.1 javascript 的基本知识
- 基础知识示例
    ```javascript
    // 输出
    console.log("hello, world")  // 控制台中输出信息
    document.write("hello")  // html 实体中输出内容

    // 数据类型: 字符串, 整数, 浮点型, 对象, 布尔(true/false), 函数
    var str= "wangxi"  // 定义变量
    typeof "John"  // string 
    var obj={    // 对象
        name: "wangxi",
        age: 23
    }
    function index(a, b) {   // 函数
        return "hello"
    }

    // JSON 对象
    obj={
        name: "wangix",
        age: 35
    }
    str= JSON.stringify(obj)   // json 对象转字符串
    obj01= JSON.parse(str)    // 字符串转 json 对象

    // Location 对象
    location.hostname // 返回 web 主机的域名
    location.pathname  // 返回当前页面的路径和文件名
    location.href  // 返回 url
    location.port   // 返回 web 主机的端口 （80 或 443）
    location.protocol   // 返回所使用的 web 协议（http: 或 https:）

    // history 对象
    history.back()  // 后退
    history.forward()   // 前进

    // navigator 对象
    // 浏览器代号: navigator.appCodeName
    // 浏览器名称: navigator.appName
    // 浏览器版本: navigator.appVersion
    // 启用Cookies: navigator.cookieEnabled
    // 硬件平台: navigator.platform
    // 用户代理: navigator.userAgent
    // 用户代理语言: navigator.language

    // document 对象
    // 元素定位
    document.getElementById("para").innerHTML="wewewewewe1245"
    document.cookie   // 获取 cookie

    // 弹窗
    alert("hellow, world 001")
    confirm("hellow, world 002")
    prompt("hellow, world 003", "请输入...") 

    // 计时事件
    var time01= setInterval(function () { console.log(123) }, 1000)  // 循环执行
    clearInterval(time01)      // 取消计时事件
    var time02= setTimeout(function () { console.log(456) }, 1000)  // 一次执行
    clearTimeout(time02)        // 取消计时事件

    ```
- 函数
    ```javascript
    // 字符串函数
    var str="hello, world"
    // 字符串的长度
    str1= str.length
    // 返回字符串中检索指定字符第一次出现的位置
    str.indexOf('l')
    // 检索与正则表达式相匹配的值
    str.search('\w*?') 
    // 把字符串分割为子字符串数组
    str.split(',')
    // 替换与正则表达式匹配的子串
    str.replace('ll', "00")
    // 字符串转化成大写
    str.toUpperCase()
    // 字符串转化成小写
    str.toLowerCase()
    // 提取字符串的片断，并在新的字符串中返回被提取的部分
    str.slice(1, 2)
    // 返回字符串对象值
    var val= 123
    val.toString()
    // 移除字符串首尾空白
    str.trim()
    // 返回下标的字符
    str.charAt(2)

    // 数组函数
    var a= [1, 45, 8, 90, "weweew"]
    var b= [3, 45]
    a.length  //数组长度
    a.concat(b)  // 合并数组
    a.indexOf(1)  // 获取元素的下标
    a.join(',')  // 数组合并为字符串
    a.pop()   // 删除数组最后一个元素
    a.push(23)  // 向数组尾部追加一个元素
    a.shift()   // 移除数组的第一个元素
    a.unshift()  // 向数组头部插入一个元素
    a.slice(2,4)  // 截取数组的一部分
    a.reverse()  // 反转数组
    a.sort()   // 排序

    ```
##### 3.2 jquery
- jquery 重点知识
    ```javascript
    // jquery 事件
    // 鼠标事件: clickdbl click	mouseenter mouseleave
    // 键盘事件: keypress keydown  keyup 	
    // 表单事件: submit change focus blur hover
    // 文档/窗口事件: load resize scroll unload
    $('#para').click(function (param) { console.log('点击事件') })
    // 阻止表单的提交
    $("form").submit(function(event){
        event.preventDefault();
        alert("阻止表单提交");
    });

    // jquery HTML
    // 设置或获取值
    // text() - 设置或返回所选元素的文本内容
    // html() - 设置或返回所选元素的内容（包括 HTML 标签）
    // val() - 设置或返回表单字段的值
    // attr() - 设置或获取属性值

    // 元素
    // 插入元素
    // append() - 在被选元素的结尾插入内容
    // prepend() - 在被选元素的开头插入内容
    // after() - 在被选元素之后插入内容
    // before() - 在被选元素之前插入内容

    // 删除元素
    // remove() - 删除被选元素（及其子元素）
    $("p").remove(".italic");  // 移除选定元素
    // empty() - 从被选元素中删除子元素

    // 标签的类
    // addClass() - 向被选元素添加一个或多个类
    // removeClass() - 从被选元素删除一个或多个类
    // css() - 设置或返回样式属性
    $("p").css({"background-color":"yellow","font-size":"200%"});

    // 元素遍历
    // 父元素
    parent() 方法返回被选元素的直接父元素
    // 子类或者后代元素
    children() 方法返回被选元素的所有直接子元素
    find() 方法返回被选元素的后代元素，一路向下直到最后一个后代
    // 同级元素
    siblings() 方法返回被选元素的所有同胞元素
    next(),nextAll(),nextUntil(),prev(),prevAll(),prevUntil()
    //元素过滤
    // first(), last() 和 eq(index)，它们允许您基于其在一组元素中的位置来选择一个特定的元素
    // filter() 和 not() 允许您选取匹配或不匹配某项指定标准的元素

    // ajax
    $.ajax({
        type: "method", // get 或者 post
        url: "https://www.baidu.com",
        headers: {  // http 请求头
            Accept: "application/json; charset=utf-8",
        },
        data: "data",  // 请求数据: 字符串
        timeout: 120,
        success: function (data, status_code) {
            console.log("响应的数据:", data)
            console.log("响应的状态码:", status_code)
        }
    });

    ```
---
#### 5. Vue2
- npm 的常用指令
    ```shell
    # node.js 的常用版本: 14.16.0
    # 安装 package.json 中的依赖
    npm install 
    # 运行程序, 编译文件
    npm run dev
    npm run build
    # 初始化项目, 直接默认生成一个 package.json 文件
    npm init -y
    # 安装依赖记录在 package.json 中
    npm install 包名@0.27.2 --save-dev/-D  # 记录在开发依赖中, @后面是版本
    npm install 包名 --save/-S      # 记录在生产依赖中
    npm install 包名 -g       # 全局安装依赖
    # 指定代理安装依赖, 使用淘宝代理
    npm install 包名 --registry=https://registry.npm.taobao.org      
    npm view 包名 versions       # 查看包的所有版本
    # 卸载依赖
    npm uninstall 包名
    # 更新依赖
    npm update       # npm 可以通过 ‘--save|--save-dev’ 指定升级哪类依赖
    # 查看 npm 配置信息
    npm config list
    # 强制清理缓存
    yarn cache clean -f

    ###################################
    # npm 的配置文件: ~/.npmrc
    registry=https://registry.npm.taobao.org/
    sass_binary_site=https://npm.taobao.org/mirrors/node-sass/
    phantomjs_cdnurl=https://npm.taobao.org/mirrors/phantomjs/
    electron_mirror=https://npm.taobao.org/mirrors/electron/
    always-auth = false

    # 安装 vue@2.6.10, @vue/cli@5.0.8
    npm install -g vue@2.6.10  @vue/cli@5.0.8
    # 创建项目
    vue --version     # 查看 vue 的版本
    vue create 项目名 # 创建项目
    vue ui            # 打开图形化界面

    ```
##### vue2 的基本语法
    ```javascript
    
    ```


