## Python 
#### 1. Python 
##### 1.1 Python 相关内容
- python 常用指令
    ```shell
    # 创建 python 纯净环境, 首先需要安装 virtualenv
    python -m venv .venv  # 或者 virtualenv venv
    # 打开纯净环境                          
    .venv\Scripts\activate.bat  # source venv/bin/activate
    # 关闭纯净环境                     
    deactivate   
    # 将第三方包导成配置文件                                   
    pip freeze > requirements.txt  
    # 通过配置文件安装第三方包   
    pip install -r requirements.txt --index-url https://repo.huaweicloud.com/repository/pypi/simple  --trusted-host repo.huaweicloud.com
    # 通过配置文件卸载第三方包 
    pip uninstall -r requirements.txt -y
    ```

- flask-demo 镜像打包
    - flask-demo 镜像源码( 下面的 "Flask的路由" > "实现restful-api") 
    ```python
    import logging
    import os
    import threading
    import time
    from logging.handlers import TimedRotatingFileHandler

    from flask import Flask, jsonify, request, send_from_directory
    from werkzeug.utils import secure_filename

    app = Flask(__name__)

    # 使通过jsonify返回的中文显示正常，否则显示为ASCII码
    app.config["JSON_AS_ASCII"] = False
    app.config['UPLOAD_FOLDER'] = './upload'
    app.config['LOG_DIR'] = "/var/python-demo/log"

    def config_log():
        log_tmp = logging.getLogger("python-demo-log")
        formatter = logging.Formatter("[%(asctime)s][%(filename)s:%(lineno)d][%(levelname)s] - %(message)s")
        if not os.path.exists(app.config['LOG_DIR']):
            os.makedirs(app.config['LOG_DIR'])
        filename = os.path.join(app.config['LOG_DIR'], "python-demo.log")
        f_handler = TimedRotatingFileHandler(filename, when="D", backupCount=5, encoding="UTF-8")
        # 格式化日志
        f_handler.setFormatter(formatter)
        # 设置日志等级
        log_tmp.setLevel(logging.INFO)
        # 添加处理器
        log_tmp.addHandler(f_handler)
        return log_tmp

    log = config_log()
    def print_log():
        headers = ''
        for k, v in request.headers.items():
            headers += k + ":" + v + ";"
        log.info("请求接口: %s %s, 请求头: %s, 请求体: %s", request.method, request.url, headers,
                request.data.decode('utf8'))

    def free_log():
        while True:
            log.info("服务器运行正常, 日志正常写入 !!!")
            time.sleep(3)

    # 获取个人用户信息
    @app.route('/hello/<int:id>', methods=['GET'])
    def get_user(id: int):
        print_log()
        return jsonify({
            "code": 200,
            "msg": "查询个人用户信息成功!!!"
        })

    # 获取所有用户信息
    @app.route('/hello', methods=['GET'])
    def get_all_users():
        print_log()
        return jsonify({
            "code": 200,
            "msg": "查询所有用户信息成功!!!"
        })

    # 注册用户
    @app.route('/hello', methods=['POST'])
    def register_user():
        print_log()
        return jsonify({
            "code": 200,
            "msg": "注册用户成功!!!"
        })

    # 上传用户头像
    @app.route('/hello/<int:id>/upload', methods=['POST'])
    def upload_user_icon(id: int):
        print_log()
        for _, f in request.files.items():
            # 使用安全的文件名
            file_name = secure_filename(f.filename)
            if not os.path.exists(app.config['UPLOAD_FOLDER']):
                os.makedirs(app.config['UPLOAD_FOLDER'])
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], file_name))
        return jsonify({
            "code": 200,
            "msg": "上传用户头像成功!!!"
        })

    # 下载文件
    # 带文件夹的路径: /hello/download/123/Snipaste_2023-01-14_14-05-26.png
    @app.route('/hello/download/<path:name>', methods=['GET'])
    def download_files(name: str):
        print_log()
        return send_from_directory(app.config['UPLOAD_FOLDER'], name, as_attachment=True)

    # 修改用户信息
    @app.route('/hello/<int:id>', methods=['PUT'])
    def update_user(id: int):
        print_log()
        return jsonify({
            "code": 200,
            "msg": "修改用户信息成功!!!"
        })

    # 删除用户信息用户信息
    @app.route('/hello/<int:id>', methods=['DELETE'])
    def delete_user(id: int):
        print_log()
        return jsonify({
            "code": 200,
            "msg": "删除用户信息成功!!!"
        })

    if __name__ == '__main__':
        log.info("服务器启动成功, 请访问: http://0.0.0.0:8080")
        threading.Thread(target=free_log, name="t_free_log").start()
        app.run(host="0.0.0.0", port=8080)
    ```

    - dockerfile文件, 放在项目的根目录中
        ```dockerfile
        FROM python:3.10-alpine3.17
        WORKDIR /usr/src/app
        COPY . .
        RUN mkdir ~/.pip && touch ~/.pip/pip.conf; \
            echo -e "[global]\nindex-url = https://repo.huaweicloud.com/repository/pypi/simple\ntrusted-host = repo.huaweicloud.com\ntimeout = 120" > ~/.pip/pip.conf; \
            pip install --no-cache-dir -r requirements.txt; \
            mkdir -p /var/log/python-demo;
        EXPOSE 8080
        CMD python main.py
        ```
    - 打包镜像: `docker build -t swr.cn-north-4.myhuaweicloud.com/wx-2022/python-demo-x86_64:v1.1.0 .`
    - 运行并进入容器: `docker run --name python-demo --entrypoint '/bin/sh' -it 3b8faa9985a3`
    - 运行容器: `docker run --name test -v $PWD/log:/var/log/python-demo -p 8080:8080 -d 容器镜像ID`

##### 1.2 python 的安装与卸载
- python3 的安装
    - 使用pyenv安装python3
        ```shell
        #!/bin/bash
        # -*- coding:utf-8 -*-
        # @Description: 
        # python3.7.9 的源码包安装
        # linux 版本: Centos7.8-x86_x64

        # 安装python的依赖
        yum -y install wget  gcc make tk-devel sqlite-devel zlib-devel readline-devel \
        openssl-devel curl-devel tk-devel gdbm-devel  xz-devel  bzip2-devel net-tools

        # Ubuntu20.04 中安装python3的依赖
        # apt-get install zlib1g-dev libbz2-dev libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev tk-dev libgdbm-dev \
        # libdb-dev libpcap-dev xz-utils libexpat1-dev liblzma-dev libffi-dev libc6-dev


        # 从github下载pyenv, 无法使用git下载就用github压缩包下载, 再上传到服务器
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv

        # 加入环境变量
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc

        # 使配置文件生效
        source ~/.bashrc

        # 查看python可安装的版本
        # pyenv install --list
        # 查看系统存在的版本
        # pyenv versions

        # 利用缓存安装python
        # 下载需要的版本的源码包Python-3.9.13.tar.xz，放到~/.pyenv/cache文件夹下面
        mkdir -p ~/.pyenv/cache
        wget https://repo.huaweicloud.com/python/3.7.9/Python-3.7.9.tar.xz  -O ~/.pyenv/cache/Python-3.7.9.tar.xz
        pyenv install 3.7.9

        # 切换python版本
        pyenv shell 3.7.9

        # 配置pip源
        # 在windows用户目录下创建`~/pip/pip.ini`; 在Linux用户目录下创建`~/.pip/pip.conf`
        mkdir /root/.pip/
        touch /root/.pip/pip.conf
        echo '[global]
        index-url = https://repo.huaweicloud.com/repository/pypi/simple
        trusted-host = repo.huaweicloud.com
        timeout = 120' >> /root/.pip/pip.conf

        echo ""
        python --version
        pip --version
        echo -e "\033[32mSuccess:python 安装成功 (^_^)\033[0m"
        echo ""
        ```
    - 使用源码包安装python3
        - python3 的安装
            ```shell
            #!/bin/bash
            # -*- coding:utf-8 -*-
            # @Description: 
            # python3.9.10 的源码包安装
            # linux 版本: Centos7.8-x86_x64

            # 安装python的依赖
            yum -y install wget  gcc make tk-devel sqlite-devel zlib-devel readline-devel \
            openssl-devel curl-devel tk-devel gdbm-devel  xz-devel  bzip2-devel net-tools

            # 获取 python 的安装包
            wget https://repo.huaweicloud.com/python/3.9.10/Python-3.9.10.tgz -O /root/Python-3.9.10.tgz

            # 解压安装包
            mkdir /usr/local/python-3.9.10
            tar -zxvf /root/Python-3.9.10.tgz -C /usr/local/

            # 编译python3
            cd /usr/local/Python-3.9.10
            ./configure --prefix=/usr/local/python-3.9.10
            make && make install

            # 创建软链接
            rm -rf /usr/local/bin/python3  /usr/local/bin/pip3
            ln -s /usr/local/python-3.9.10/bin/python3 /usr/local/bin/python3
            ln -s /usr/local/python-3.9.10/bin/pip3 /usr/local/bin/pip3

            # 清理安装包
            rm -rf /root/Python-3.9.10.tgz  /usr/local/Python-3.9.10 

            # 配置pip源
            mkdir /root/.pip/
            touch /root/.pip/pip.conf
            echo -e '[global]
            index-url = https://repo.huaweicloud.com/repository/pypi/simple
            trusted-host = repo.huaweicloud.com
            timeout = 120' >> /root/.pip/pip.conf

            # 查看python的版本
            echo ""
            echo "#######################################"
            python3 --version
            echo ""
            echo -e "\033[32mSuccess:python3.9.10安装成功 (^_^)\033[0m"
            echo ""
            ```
        - python3 的卸载
            ```shell
            #!/bin/bash
            # -*- coding:utf-8 -*-
            # @Emoj: （￣︶￣）↗　
            # @Time: DATE TIME
            # @Author: wangxi
            # @Email: 674860357@qq.com
            # @File: python3-uninstall.sh
            # @Description: 
            # python3.9.10 的卸载
            # linux 版本: Centos7.8-x86_x64

            # 解压安装包
            rm -rf /usr/local/python-3.9.10

            # 创建软链接
            rm -rf /usr/local/bin/python3  /usr/local/bin/pip3

            # 配置pip源
            rm -rf  /root/.pip/
            echo ""
            echo -e "\033[32mSuccess:python3.9.10 卸载成功 (^_^)\033[0m"
            echo ""
            ```

##### 1.3 常见的数据类型
- 字符串的操作
    ```python
    # 字符串的截取
    str="hello, world"
    str[:-2]    # 结果: hello, wor
    # 打印字符串不转义
    print(r"hello\nworld")
    # 字符串反转
    str[::-1]   # 结果: dlrow ,olleh
    # 去除两端的空白字符
    strip(str)
    # 字符串的长度
    len(str)
    # 字符在字符串中第一次出现的位置
    str.index('l')  # 结果: 2
    'l' in str
    # 将数组或者元组组合成一个字符串
    '.'.join(str)  # 结果: h.e.l.l.o.,.w.o.r.l.d
    # 将字符串中单个字符替换成另一个字符
    str.replace('l','w')  # 结果: hewwo,worwd
    # 分割字符串
    str.split(',')  # 结果: ['hello', 'world']
    ```

- 列表的操作
    ```python
    arr=[1, 34, 65, 45, 55]
    # 数组的截取
    arr[:-2]    # 结果: [1, 34, 65]
    # 数组的追加
    arr.append(34)   # 结果: [1, 34, 65, 45, 55, 34]
    # 数组的末尾删除元素
    arr.pop()   # 结果: [1, 34, 65, 45]
    # 移除某个元素
    arr.remove(34)   # [1, 65, 45, 55]
    del arr[1]
    # 元素是否存在于列表中
    1 in arr   # true
    # 数组合并
    arr + [1, 2]  #  [1, 34, 65, 45, 55, 1, 2]
    # 数组中指定位置插入一个元素
    arr.insert(2, 78)   # [1, 34, 78, 65, 65, 45, 55]
    # 数组的最大值与最小值
    max(arr), min(arr)
    # 数组中元素的索引
    arr.index(34)   # 1
    # 数组反转
    arr.reverse()  # [55, 45, 65, 65, 34, 1]
    # 数组排序
    arr.sort(reverse=True)  # [65, 65, 55, 45, 34, 1]
    ```

- 字典
    ```python
    dic={ "name": "jwoeoe", "age": 123 }
    # key是否在字典里面
    "name" in dic   # true
    # 获取keys, values, key:value
    dic.keys(), dic.values(), dic.items()
    # 字典的遍历
    for key, value in data.items():
    print(key, value)
    # 删除键值对
    del dic["name"]
    ```
##### 1.4 文件相关 
- 文件函数
    ```python
    # 文件函数
    f=open('./test.yml')
    # 读文件
    f.read(), f.readlines()
    # 写文件
    f.write('wewewwe')
    # 关闭文件
    f.close()
    # 修改文件游标的位置
    seek(x,0)   # 从起始位置即文件首行首字符开始移动 x 个字符
    seek(x,1)   # 表示从当前位置往后移动x个字符
    seek(-x,2)  # 表示从文件的结尾往前移动x个字符
    ```

- yml, json 文件函数
    ```python
    # yml 文件
    # 安装第三方包 PyYAML
    pip install PyYAML
    # 导入第三方包
    import yaml
    # 字典数据写入 yaml 文件
    yaml.dump(data, f)
    # 从 yaml 文件读出字典类型数据
    yaml.load(f, Loader=yaml.FullLoader)

    # json 文件
    # 导入第三方包 json
    import json
    # 字典数据写入 json 文件
    json.dump(dic_data, fp)
    # 从 json 文件读出字典类型数据
    
    # 字典类型转字符串
    json.dumps(dic_data)
    # 字符串转字典类型
    json.loads(str1)

    # MD5 加密
    import hashlib
    # md5 加密, 字符串必须是bytes
    print(hashlib.md5(b'123').hexdigest())
    
    # base64 加密
    import base64
    str = "123".encode('utf8')
    #对字符串进行 base64 编码
    base64_str= base64.b64encode(str)
    print(base64_str.decode('utf8'))  # MTIz
    #输出还原 base64 编码后的字符串
    print(base64.b64decode(base64_str).decode(encoding='utf8')) # 123
    ```

##### 1.5 python 常用库
- sys 模块
    ```python
    # sys 模块
    # 命令参数
    sys.argv
    # 解释器查找路径 
    sys.path

    # 导入包的方法之一
    # 导入包的原则: 
    # 1. 允许导入第三方包
    # 2. 同一个包内, 下一级的包可以导入上一级的包, 上一级的包最好不要导入下一级的包或者同级的包, 避免相互调用, 需要符合依赖倒置原则
    # 通过该方法添加的目录，只能在执行当前文件的窗口中有效，窗口关闭后即失效
    sys.path.append(['./'])
    # python 版本, 操作系统, 程序正常退出 
    sys.version, sys.platform, sys.exit(0)
    ```
- os 模块
    ```python
    import os
    os.system("dir")  # 执行系统指令, 成功返回0, 失败返回非0 
    os.remove('./filename')     # 删除文件
    os.rename(oldname, newname)     # 重命名文件  
    os.chdir('dirname')     # 改变工作目录
    os.mkdir/makedirs('dirname')    # 创建目录/多层目录
    os.rmdir/removedirs('dirname')     # 删除目录/多层空目录
    import shutil
    shutil.rmtree("./allure_reports")   # 删除非空目录

    # 压缩打包文件
    # shutil.make_archive(base_name, format, root_dir=None, base_dir=None, verbose=0,dry_run=0, owner=None, group=None, logger=None)
    # 功能：打包压缩文件
    # 参数：
    # base_name：压缩打包后的文件名或路径名
    # format：压缩或者打包格式。例如：'zip'，'tar', 'bztar', 'gztar'
    # root_dir：将哪个目录或文件压缩打包(也就是源文件)
    # 示例：
    import shutil
    shutil.make_archive('result', 'gztar', root_dir='./lib')
    shutil.unpack_archive("ss.tar", "./ss")  # 解压压缩包

    os.listdir('dirname')     # 列出指定目录的文件
    os.getcwd()     # 取得当前工作目录
    os.chmod()     # 改变目录权限

    # 目录相关函数
    os.path.abspath(__file__)        # 获取当前文件绝对路径
    os.path.basename('./filename')     # 去掉目录路径，返回文件名
    os.path.dirname('./filename')     # 去掉文件名，返回目录路径
    os.path.split('path')     # 返回( dirname(), basename())元组
    os.path.splitext()     # 返回 (filename, extension) 元组
    # os.path.getatime\ctime\mtime     # 分别返回最近访问、创建、修改时间
    os.path.getsize()     # 返回文件大小
    os.path.exists()     # 是否存在
    os.path.isdir()     # 是否为目录
    os.path.isfile()    # 是否为文件  
    ```

- re 模块
    ```python
    import re
    # 正则表达式
    str="hello,world"
    re.findall('l+', str)  # ['ll', 'l']

    # 正则表达式的规则
    # \d, \s, \w ,\D, . : 数字, 空白字符, 字母, 非字母, 除了换行和行结束符
    # +, *, *?, {1,2}, |, () : 1-n 字符, 0-n 字符, 非贪婪模式, 1-2 个字符, 或, 子匹配
    # ^, $, [a-zA-Z0-9\s], [^0-9], Windows(?=95|98|NT|2000) : 开头, 结尾, 字母数字空白字符, 非数字, ?= 后接字符
    # 手机号码: ^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$
    ```

- random 模块
    ```python
    import random
    # random 模块
    # 1-10 随机数
    random.randrange(1, 10)
    # 数组中随机一个数
    random.choice(["wewe", "w23", "3u239"])
    # 获取N位随机数
    random.sample("0123456789abcdefghijklmnopqrstuvwxyz", 5)

    # UUID: 唯一id
    # 版本1: 严格按照 UUID 定义的每个字段的意义来实现，使用的变量因子是时间戳＋时钟序列＋节点信息（Mac地址）
    uuid.uuid1()  # 结果: 9eaffa24-7c82-11ed-8912-95834abff6ed
    ```

- time 模块
    ```python
    import time
    # time 模块
    # 当前时间的时间戳(从1970年1月1日00时00分00秒到现在的浮点秒数)
    time.time()
    # 获取当前时间
    time.localtime(time.time())

    # 暂停 3s
    time.sleep(3)

    # 浮点数转化为格式化时间
    time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(2546635.356))
    # 格式化时间转浮点数
    time.mktime(time.strptime("2021-03-25 11:23:00","%Y-%m-%d %H:%M:%S"))
    ```

- socket 模块
  - socket 基本知识
    ```python
    # socket 模块
    import socket
    # 创建 socket
    # family: 套接字家族可以是 AF_UNIX 或者 AF_INET
    # type: 套接字类型可以根据是面向连接的还是非连接分为SOCK_STREAM或SOCK_DGRAM
    # protocol: 一般不填默认为0
    s=socket.socket([family[, type[, proto]]])

    # 服务端
    # 绑定地址（host,port）到套接字， 在AF_INET下,以元组（host,port）的形式表示地址。
    s.bind((127.0.0.1, 9000))
    # 开始TCP监听。backlog指定在拒绝连接之前，操作系统可以挂起的最大连接数量。该值至少为1，大部分应用程序设为5就可以了。	
    s.listen(10)
    # 被动接受TCP客户端连接,(阻塞式)等待连接的到来. 客户端与服务器建立连接	 
    s.accept()       

    # 客户端
    # 主动初始化TCP服务器连接，。一般address的格式为元组（hostname,port），如果连接出错，返回socket.error错误
    s.connect((127.0.0.1, 9000))	  

    # 公共方法
    # 接收TCP数据，数据以字符串形式返回，bufsize指定要接收的最大数据量。flag提供有关消息的其他信息，通常可以忽略。
    s.recv()
    # 发送TCP数据，将string中的数据发送到连接的套接字。返回值是要发送的字节数量，该数量可能小于string的字节大小。	
    s.send()
    # 接收UDP数据，与recv()类似，但返回值是（data,address）。其中data是包含接收数据的字符串，address是发送数据的套接字地址。	
    s.recvfrom()
    # 发送UDP数据，将数据发送到套接字，address是形式为（ipaddr，port）的元组，指定远程地址。返回值是发送的字节数。
    s.sendto()
    # 关闭套接字	
    s.close()	
    # 设置超时时间
    s.settimeout()  

    # 获取主机名和 ip 地址
    socket.gethostname(), socket.gethostbyname(socket.gethostname())
       
    ```
    - socket 示例
        - 客户端
            ```python
            # 客户端
            # -*- coding:utf-8 -*-
            import socket
            import time

            client=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            host, port="106.13.223.242", 9000
            client.settimeout(10)
            client.connect((host, port))

            while True :
                recv_data = str(client.recv(1024), 'utf8')
                if recv_data:
                    print(recv_data)
                    t=time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))
                    msg=input(t +":" )
                    client.send(msg.encode('utf8'))

            client.close()
            ```
        - 服务端
            ```python
            # 服务端
            # -*- coding:utf-8 -*-
            import socket
            import time

            server=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            host, port="0.0.0.0", 9000
            server.bind((host, port))
            server.listen(10)
            print("服务端成功启动...")
            while True :
                client, addr=server.accept()
                t = time.strftime("[ %Y-%m-%d %H:%M:%S ]:", time.localtime(time.time()))
                print(t)
                print("客户端 "+ addr[0] +" 成功建立连接!!!")
                msg="你已经成功连接服务器!!!"
                client.send(msg.encode('utf8'))
                while True:
                    recv_data = str(client.recv(1024), 'utf8')
                    if recv_data:
                        t = time.strftime("[ %Y-%m-%d %H:%M:%S ]:", time.localtime(time.time()))
                        print(t)
                        print(recv_data)
                        msg="服务器成功收到你的消息: "+ recv_data
                        client.send(msg.encode('utf8'))
                client.close()

            server.close()
            ```

- psutil: 获取系统资源
    ```python
    # psutil通常适用于Linux系统
    ##########################################################
    # CPU相关
    # psutil.cpu_percent(interval=1, percpu=True)
    # 如果 interval=None(默认值), 上一次请求和本次请求的时间内, cpu的使用率. 通常第一次为0.0
    # 如果 percpu=False(默认值), cpu总使用率; 如果 percpu=True(默认值), 单个cpu使用率.
    for _ in range(3):
        print(psutil.cpu_percent())  # 结果: 0.0 2.3 1.3
        time.sleep(1)

    # cpu的逻辑核心数
    print(psutil.cpu_count())
    # cpu的详细使用率
    print(psutil.cpu_times_percent())
    # 结果: scputimes(user=0.5, system=0.8, idle=98.7, interrupt=0.1, dpc=0.0)

    ############################################################
    # 内存相关
    # 内存使用情况
    print(psutil.virtual_memory())
    # 内存的使用率: (total - available) / total.
    # 结果: svmem(total=16849293312, available=8686739456, percent=48.4, used=8162553856, free=8686739456)
    # 物理内存使用情况
    print(psutil.swap_memory())
    # 结果: sswap(total=1073741824, used=172826624, free=900915200, percent=16.1, sin=0, sout=0)

    # 内存大小(byte)转换成可读大小(K, M, G, T, ...)
    def bytes2human(n):
        symbols = ('K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y')
        prefix = {}
        for i, s in enumerate(symbols):
            prefix[s] = 1 << (i + 1) * 10
        for s in reversed(symbols):
            if n >= prefix[s]:
                value = float(n) / prefix[s]
                return '%.1f%s' % (value, s)
        return '%sB' % n

    ###############################################################
    # 磁盘相关
    # 目录路径的磁盘使用率
    print(psutil.disk_usage("/"))
    # 结果: sdiskusage(total=35437142016, used=2935717888, free=32501424128, percent=8.3)

    # 物理磁盘分区使用情况
    # psutil.disk_partitions()
    # 如果all=True, 返回各个物理磁盘分区和其他分区使用情况, 使用`df`可以查询系统分区信息; 默认all=False. 返回各个物理磁盘分区使用情况
    print(psutil.disk_partitions())
    # 结果: [sdiskpart(device='/dev/mapper/centos-root', mountpoint='/', fstype='xfs', opts='rw,seclabel,relatime,attr2,inode64,noquota', maxfile=255, maxpath=4096),
    # sdiskpart(device='/dev/mapper/centos-home', mountpoint='/home', fstype='xfs', opts='rw,seclabel,relatime,attr2,inode64,noquota', maxfile=255, maxpath=4096)
    # , sdiskpart(device='/dev/sda1', mountpoint='/boot', fstype='xfs', opts='rw,seclabel,relatime,attr2,inode64,noquota', maxfile=255, maxpath=4096)]

    # 磁盘io使用情况
    # psutil.disk_io_counters()
    # 如果all=True, 返回读取linux中`/proc/diskstats`文件数据; 默认all=False. 返回系统磁盘使用情况
    # 磁盘读的速度: (第一次读的字节数 - 第二次读的字节数) / 间隔时间; 磁盘写的速度: (第一次写的字节数 - 第二次写的字节数) / 间隔时间
    last_read_bytes, last_write_bytes = 0, 0
    read_io, write_io = 0, 0
    while True:
        disk_io = psutil.disk_io_counters()
        print(disk_io)
        if last_read_bytes != 0:
            read_io = (disk_io.read_bytes - last_read_bytes) / 1
        last_read_bytes = disk_io.read_bytes
        if last_write_bytes != 0:
            write_io = (disk_io.write_bytes - last_write_bytes) / 1
        last_write_bytes = disk_io.write_bytes
        print("磁盘读IO: %s/s, 磁盘写IO: %s/s" % (bytes2human(read_io), bytes2human(write_io)))
        time.sleep(1)
    # 结果:
    # sdiskio(read_count=10591, write_count=3128, read_bytes=295883776, write_bytes=52832768, read_time=3065, write_time=12050,
    # read_merged_count=16, write_merged_count=314, busy_time=5117)
    # 读IO: 32.0K/s, 写IO: 0.0B/s
    # sdiskio(read_count=10591, write_count=3128, read_bytes=295883776, write_bytes=52832768, read_time=3065, write_time=12050,
    # read_merged_count=16, write_merged_count=314, busy_time=5117)
    # 读IO: 0.0B/s, 写IO: 148.5K/s

    #################################################################
    # 网络相关
    # 网卡的io使用情况
    # psutil.net_io_counters(pernic=True)
    # 如果 pernic=True, 返回每个网卡的io使用情况, 也就是`/proc/net/dev`文件的内容: 如果 pernic=False(默认), 返回系统网络io使用情况
    print(psutil.net_io_counters())
    # 结果: snetio(bytes_sent=148656, bytes_recv=163816, packets_sent=1338, packets_recv=1915, errin=0, errout=0, dropin=0, dropout=0)
    # 网络发送的速度: (第一次发送的字节数 - 第二次发送的字节数) / 间隔时间; 网络接受的速度: (第一次接受的字节数 - 第二次接受的字节数) / 间隔时间
    last_bytes_sent, last_bytes_recv = 0, 0
    send_io, recv_io = 0, 0
    while True:
        net_io = psutil.net_io_counters()
        if last_bytes_sent != 0:
            send_io = (net_io.bytes_sent - last_bytes_sent) / 1
        last_bytes_sent = net_io.bytes_sent
        if last_bytes_recv != 0:
            recv_io = (net_io.bytes_recv - last_bytes_recv) / 1
        last_bytes_recv = net_io.bytes_recv
        print("网络发送IO: %s/s, 网络接收IO: %s/s" % (bytes2human(send_io), bytes2human(recv_io)))
        time.sleep(1)

    # 网卡的信息
    print(psutil.net_if_addrs())
    # 结果: {'lo': [snicaddr(family=<AddressFamily.AF_INET: 2>, address='127.0.0.1', netmask='255.0.0.0', broadcast=None, ptp=None), 
    # snicaddr(family=<AddressFamily.AF_INET6: 10>, address='::1', netmask='ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff', broadcast=None, ptp=None), 
    # snicaddr(family=<AddressFamily.AF_PACKET: 17>, address='00:00:00:00:00:00', netmask=None, broadcast=None, ptp=None)], 
    # 'enp0s3': [snicaddr(family=<AddressFamily.AF_INET: 2>, address='192.168.56.201', netmask='255.255.255.0', broadcast='192.168.56.255', ptp=None), ...}

    # 进程管理
    # 通过`cd /proc/{pid}/`可以查看linux进程的信息
    # 获取当前进程的pid, 父进程的pid
    os.getpid(), os.getppid()
    # 获取所有正在运行进程id列表
    psutil.pids()
    # 判断pid对应的进程是否存在
    psutil.pid_exists(1)

    # Process类: 可以获取很多进程的信息, 比如进程id, 内存, cpu,
    # 如果没有设置pid, 获取当前的pid; 如果设置了pid但是pid不存在, 会抛出错误.
    p = psutil.Process()
    # 返回父进程的Process对象或者所有父进程的Process对象列表
    p.parent(), p.parents()
    # 返回父进程的Process对象或者所有父进程的Process对象列表
    p.pid, p.ppid()
    # 进程的执行指令, 运行目录, 创建时间, 用户名, 进程状态
    p.cmdline(), p.cwd(), p.create_time(), p.username(), p.status()
    # 当前进程下的所有线程(包括子进程的线程数)
    p.num_threads()
    # 当前进程的cpu使用情况, cpu使用率
    p.cpu_times(), p.cpu_percent()
    # 结果: pcputimes(user=0.046875, system=0.015625, children_user=0.0, children_system=0.0)
    # 当前进程的内存使用情况, 内存使用率
    p.memory_info(), p.memory_percent()
    # 结果: pmem(rss=15155200, vms=8466432, num_page_faults=4419, peak_wset=15491072, wset=15155200,
    # peak_paged_pool=153392, paged_pool=153392, peak_nonpaged_pool=17080, nonpaged_pool=17080, pagefile=8466432,
    # peak_pagefile=8777728, private=8466432)
    ```

- paramiko: SSH 远程连接和SFTP数据传输
    ```python
    # Paramiko中的几个基础名词:
    # 1、Channel：是一种类Socket，一种安全的SSH传输通道；
    # 2、Transport：是一种加密的会话，使用时会同步创建了一个加密的Tunnels(通道)，这个Tunnels叫做Channel
    # SSHClient, SFTPClient 都是基于Transport类与服务器建立连接.
    class SshUtil:
        """
        使用`ssh`远程登录服务器, 使用`sftp`实现文件的上传与下载
        """

        def __init__(self) -> None:
            self.ssh_client = SSHClient()
            # AutoAddPolicy策略会自动把登录信息保存在本地
            self.ssh_client.set_missing_host_key_policy(AutoAddPolicy())
            self.sftp: Optional[SFTPClient] = None

        def connect_by_password(self, ip: str, pwd: str, port: int = 22, username: str = "root", timeout: float = 10,
                                interval: int = 60):
            """
            `ssh`连接服务器, 通过用户名密码登录, 同时建立`sftp`连接

            :param ip: 主机`ip`地址
            :param pwd: 密码
            :param port: 端口, 默认 22
            :param username: 用户名, 默认`root`用户
            :param timeout: 连接超时时间(s), 默认 10s
            :param interval: 发送数据包的间隔时间(s), 默认 60s. 每过 'interval' 时间向服务器发一个数据包,
                与服务器建立长连接. `interval=0`为关闭长连接
            :return:
            """
            self.ssh_client.connect(hostname=ip, port=port, username=username, password=pwd, timeout=timeout)
            # 初始化 sftp 连接
            self.set_sftp(interval=interval)

        def connect_by_pkey(self, ip: str, pkey_filename: str = r"C:\Users\Administrator\.ssh\id_rsa",
                            pkey_pwd: Optional[str] = None, port: int = 22, username: str = "root", timeout: float = 10,
                            interval: int = 60):
            """
            ssh连接服务器, 通过密钥连接登录, 同时建立`sftp`连接

            `id_rsa` 是私钥(客户端使用)，`id_rsa.pub` 这个是公钥(服务器使用).
            只需要把私钥复制到本地主机路径: `C:\\Users\\Administrator\\.ssh\\id_rsa`

            :param ip: 主机`ip`地址
            :param pkey_filename: 密钥的文件路径, 本地主机默认路径: `C:\\Users\\Administrator\\.ssh\\id_rsa`
            :param pkey_pwd: 如果密钥中输入了密码, `pkey_pwd`需要填写密码, 否则为 None
            :param port: `ssh`端口
            :param username: 用户名, 默认为`root`用户
            :param timeout: 连接超时时间(s), 默认 10s
            :param interval: 发送数据包的间隔时间(s), 默认 60s. 每过 'interval' 时间向服务器发一个数据包,
                与服务器建立长连接. `interval=0`为关闭长连接

            :return:
            """
            pkey = RSAKey.from_private_key_file(filename=pkey_filename, password=pkey_pwd)
            self.ssh_client.connect(hostname=ip, port=port, username=username, pkey=pkey, timeout=timeout)
            # 初始化 sftp 连接
            self.set_sftp(interval=interval)

        def set_sftp(self, interval: int = 60):
            """
            建立 sftp 连接

            :param interval: 发送数据包的间隔时间(s), 默认 60s. 每过 'interval' 时间向服务器发一个数据包,
                与服务器建立长连接. `interval=0`为关闭长连接
            :return:
            """
            transport = self.ssh_client.get_transport()
            # 设置与服务器进行长连接
            transport.set_keepalive(interval)
            self.sftp = SFTPClient.from_transport(transport)

        def push(self, local_file: str, remote_file: str):
            """
            sfpt上传文件

            :param local_file: 本地文件路径
            :param remote_file: 服务器文件路径. 文件存在就覆盖, 不存在就创建. 文件目录不存在就报错. 请注意文件路径
            应该包括文件名. 只指定目录, 可能导致错误.
            :return:
            """
            self.sftp.put(local_file, remote_file)

        def pull(self, remote_file: str, local_file: str):
            """
            sftp下载文件

            :param remote_file: 服务器文件路径.
            :param local_file: 本地文件路径. 文件存在就覆盖, 不存在就创建. 文件目录不存在就报错. 请注意文件路径
            应该包括文件名. 只指定目录, 可能导致错误.
            :return:
            """
            self.sftp.get(remote_file, local_file)

        def exec_cmd(self, cmd: str, timeout=10) -> str:
            """
            执行shell指令

            :param cmd: shell指令
            :param timeout: 执行指令超时时间, 默认 10s
            :return: 执行指令出错返回错误信息, 执行指令正确返回正确信息
            """
            _, stdout, stderr = self.ssh_client.exec_command(cmd, timeout=timeout)
            usual_msg = stdout.read().decode('utf-8').strip()
            err_msg = stderr.read().decode('utf-8').strip()
            if err_msg:
                return err_msg
            return usual_msg

        def close(self):
            """
            关闭ssh连接, sftp连接

            :return:
            """
            self.ssh_client.close()
            self.sftp.close()
    ```
- tqdm: 进度条
    ```python
    import random
    import time

    import tqdm


    def task():
        time.sleep(random.randint(1, 2) * 0.1)


    for i in tqdm.tqdm(range(100), desc="下载图片1"):
        task()

    # 结果如下:
    # 下载图片1: 100%|██████████| 100/100 [00:30<00:00,  3.24it/s]
    ```

- 日志框架
    ```python
    # logging
    class LogUtil:
        """
        日志配置类
        """
        def __init__(self, name: str, log_dir: str, fmt: str, prefix: str = "",
                    log_level: int = logging.INFO) -> None:
            """
            获取`Logger`对象初始化

            :param log_dir: 日志目录, 不存在会自动创建
            :param name: 日志对象名字
            :param fmt: 日志格式, 比如: `%(levelname)s\t%(asctime)s\t[%(filename)s:
                %(lineno)d]\t%(message)s`
            :param log_level: 日志等级, 默认为`INFO`
            :param prefix: 日志文件前缀, 比如: webui_202209.log
            :return: 返回一个`Logger`对象
            """
            self._logger = logging.getLogger(name=name)
            self._stream_handler = logging.StreamHandler()
            if not os.path.exists(log_dir):
                os.makedirs(log_dir)
            log_file01 = os.path.join(log_dir, prefix + self._get_log_filename())
            # 按时间滚动日志
            # self._file_handler = TimedRotatingFileHandler(filename, when="D", backupCount=5, encoding="UTF-8")
            self._file_handler = logging.FileHandler(log_file01, 'a', encoding='utf-8')
            self.set_level(log_level)
            self.set_fmt(fmt)
            self._logger.addHandler(self._file_handler)
            self._logger.addHandler(self._stream_handler)

        def get_logger(self) -> Logger:
            """
            获取`Logger`对象

            :return: 返回一个`Logger`对象
            """
            return self._logger

        def set_level(self, log_level: int = logging.INFO) -> None:
            """
            设置日志等级

            常用的日志等级有: `INFO`, `WARNING`, `DEBUG`, `ERROR`

            :param log_level: 日志等级, 默认为`INFO`
            :return:
            """
            self._logger.setLevel(log_level)
            self._file_handler.setLevel(log_level)
            self._stream_handler.setLevel(log_level)

        def set_filestream(self, log_dir: str, prefix: str = "") -> None:
            """
            修改日志文件的目录

            :param log_dir: 
            :param prefix:
            :return:
            """
            if not os.path.exists(log_dir):
                os.makedirs(log_dir)
            log_file01 = os.path.join(log_dir, prefix + self._get_log_filename())
            self._file_handler.setStream(open(log_file01, "a", encoding='utf-8'))

        def set_fmt(self, fmt: str) -> None:
            """
            日志格式

            :param fmt: 日志格式, 比如: `%(levelname)s\t%(asctime)s\t[" + __file__ +"
                %(filename)s:%(lineno)d]\t%(message)s`
            :return:
            """
            log_fmt = logging.Formatter(fmt)
            self._file_handler.setFormatter(log_fmt)
            self._stream_handler.setFormatter(log_fmt)

        def _get_log_filename(self) -> str:
            """
            按年月生成日志文件名

            :return: 日志文件名
            """
            local_time = time.time()
            return time.strftime("%Y%m", time.localtime(local_time)) + ".log"


    ##########################################
    # loguru: 第三方日志插件
    from loguru import logger

    if __name__ == '__main__':
        # 大于50M以zip形式压缩转储日志, 90天后清理日志, 日志格式: 2023-01-03 00:12:34.630127 ERROR main.py 8: this is an error msg.
        logger.add("./log/test-log.log", rotation="50 MB", retention="90 days", compression="zip", format="{time:YYYY-MM-DD HH:mm:ss.SSSSSS} {level} {file} {line}: {message}", level="INFO") 
        logger.info("this is an info msg.")
        logger.error("this is an error msg.")
    ```

- pymysql
    ```python
    from pymysql import connect, cursors

    class MysqlDB:
        def __init__(self, host='localhost', port=3306, db='', user='root', passwd='root', charset='utf8'):
            # 建立连接
            self.conn = connect(host=host, port=port, db=db, user=user, passwd=passwd, charset=charset)
            # 创建游标，操作设置为字典类型
            self.cur = self.conn.cursor(cursor=cursors.DictCursor)

        def __enter__(self):
            # 返回游标
            return self

        def __exit__(self, exc_type, exc_val, exc_tb):
            # 执行sql语句失败回滚
            self.conn.rollback()
            # 关闭游标
            self.cur.close()
            # 关闭数据库连接
            self.conn.close()

    if __name__ == '__main__':
        with MysqlDB(host="192.168.56.210", user="root", passwd="123456", db="test") as db:
            try:
                db.cur.execute("select * from blog_user;")
                # 提交事务
                db.conn.commit()
                # 获取单条查询结果
                # result = db.fetchone()
                # 结果: {'id': 1, 'username': '小王', 'password': '123456', 'address': '威客网访贫问苦服务'}
                # 获取所有查询结果
                result = db.cur.fetchall()
                # 结果: [{'id': 1, 'username': '小王', 'password': '123456', 'address': '威客网访贫问苦服务'}, ... ]
                print(result)
            except Exception as e:
                print(e)
    ```
- 数据库连接池- dbutils
    ```python
    # 安装: pip install DBUtils
    from typing import Optional
    import pymysql
    from dbutils.pooled_db import PooledDB
    from pymysql import cursors

    class MysqlConnectionPool:
        __pool: Optional[PooledDB] = None

        def __init__(self, host, passwd, db, setsession=None, reset=True, port=3306,
                    user='root', charset='utf8', maxconnections=100, blocking=True,
                    creator=pymysql, mincached =0, maxcached=0, maxshared=0, maxusage=None):
            """数据库连接池初始化

            :param mincached: 连接池中空闲连接的初始数量
            :param maxcached: 共享连接的最大数量
            :param maxshared: 创建连接池的最大数量
            :param maxusage: 单个连接的最大重复使用次数
            :param passwd: 数据库密码
            :param db: 数据库名字
            :param host: 数据库 IP 地址
            :param setsession: 可选的SQL命令列表, 可以用于准备会话, 例如 ["set datestyle to…", "set time zone…"]
            :param reset: 当连接返回到连接池时, 应该如何重置连接 (reset为False或None时, 回滚begin()开始的事务;
                    reset为True时, 为安全起见, 总是发出回滚)
            :param port: 数据库的端口, 默认 3306
            :param user: 数据库登录用户, 默认 root
            :param maxconnections: 连接池的最大连接数
            :param blocking: 超过最大连接数量时候的表现，为True等待连接数量下降，为false直接报错处理
            :param creator: 数据库连接第三方包, 默认 pymysql
            """
            if not self.__pool:
                self.__class__.__pool = PooledDB(creator=creator, mincached=mincached, maxcached=maxcached,
                                                maxshared=maxshared, maxconnections=maxconnections, blocking=blocking,
                                                maxusage=maxusage, setsession=setsession, reset=reset,
                                                host=host, port=port, db=db, user=user, passwd=passwd,
                                                charset=charset)
            self.conn = self.__pool.connection()
            self.cur = self.conn.cursor(cursor=cursors.DictCursor)

        def __enter__(self):
            # 返回游标
            return self

        def __exit__(self, exc_type, exc_val, exc_tb):
            # 执行sql语句失败回滚
            self.conn.rollback()
            # 关闭游标
            self.cur.close()
            # 关闭数据库连接
            self.conn.close()

    if __name__ == "__main__":
        with MysqlConnectionPool(host="192.168.56.210", user="root", passwd="123456", db="test") as db :
            try:
                db.cur.execute("select * from blog_user;")
                # 提交事务
                db.conn.commit()
                # 获取单条查询结果
                # result = db.fetchone()
                # 结果: {'id': 1, 'username': '小王', 'password': '123456', 'address': '威客网访贫问苦服务'}
                # 获取所有查询结果
                result = db.cur.fetchall()
                # 结果: [{'id': 1, 'username': '小王', 'password': '123456', 'address': '威客网访贫问苦服务'}, ... ]
                print(result)
            except Exception as e:
                print(e)
    ```

##### 1.6 python 进阶知识
- 类
    ```python
    # 常用函数
    type() # 查看类型
    id() # 查看内存地址
    is # 比较内存地址, 示例: a is b
    == # 比较数值, 示例: a==b, 调用对象的__eq__() 魔术方法
    in # dict中都指的是键,不是值, 比如: "wew" in { "wew": "123"} -- True
    isinstance() # 判断类的实例, 比如: isinstance("wewew", str) -- True, isinstance(A, type) -- A类是type的类对象
    issubclass() # 判断类的子类, 比如: issubclass(str, object) -- True
    locals() # 返回局部变量的字典, 比如 "ss" in locals, ss 变量是否在局部变量字典中
    glocals() # 返回全局变量的字典, 比如 "ss" in glocals, ss 变量是否在全局变量字典中

    # 类的内置属性
    # __dict___: 获取类或者对象的属性
    # __dir__()与__dict__的区别:
    print(A().__dir__()) # 打印对象的所有属性和方法, 以数组的形式呈现
    print(A.__dict__) # 打印类的当前属性和方法, 以字典的形式呈现
    print(A().__dict__) # 打印对象的当前属性, 以字典的形式呈现

    # __all__变量只在以from 模块名 import *形式导入模块时起作用，而以其他形式，如import 模块名、from 模块名 import 成员时都不起作用
    # __all__也是对于模块公开接口的一种约定，比起下划线，__all__提供了暴露接口用的“白名单”
    __all__=[
        "a",
        "b",
    ]

    # 类的基本方法
    class MyClass:
        '''类名'''
        name= "校长"  # 类属性 => 静态属性
        age= "wewew"
        def __init__(self, name, age) -> None:
            self._name = name  # 实例属性
            self._age = age

        @classmethod   # 类方法
        def hello01(cls) :
            '''类函数'''
            print(cls.name)

        @staticmethod   # 静态方法
        def hello() :
            '''静态函数'''
            print(MyClass.name)

        @abstractmethod   # 抽象方法
        def hello() : ...

        ###########################################
        # @property 实现属性的 getter, setter, delete方法, 主要用来实现实例属性的封装
        @property
        def name(self):  # name_x 是一个托管方法, 托管了属性name, 方法名必须一样
            return self._name  # 属性的调用: MyClass().name

        @name.setter
        def name(self, name):
            self._name= name

        @name.deleter
        def name(self):
            del self._name
    
    #################################################
    # 接口与抽象类
    class MyClass(metaclass=ABCMeta):
        '''抽象基类, 类似于接口'''

        @abstractmethod
        def hello(self, a: int) -> int: ...

        @abstractmethod
        def world(self, a: int) -> int: ...


    class DogClass(MyClass):
        '''抽象类, 不能实例化'''

        @abstractmethod
        def tom(self, a: int) -> int: ...

        def hello(self, a: int) -> int:
            print(self.__class__.__name__)
            return a

        def world(self, a: int) -> int:
            print(self.__class__.__name__)
            return a

    class MyDogClass(DogClass):
        '''一般类, 不重写接口或者抽象类的方法, 实例化会报错'''  
        def tom(self, a: int) -> int:
            print(self.__class__.__name__)
            return a

    ########################################
    # 类的魔术方法(内置方法)
    class MyClass:
        '''类名'''
        # 属性或者方法的修饰符
        # 无下划线, 类似于 public
        # _xxx, 单个下划线类似于 protect
        # __xxx, 双下划线类似于 private

        #############################################
        # 类生命周期
        # __new__() 是一种负责创建类实例的静态方法，它无需使用 staticmethod 装饰器修饰，且该方法会优先 __init__() 初始化方法被调用
        # 一般情况下，覆写 __new__() 的实现将会使用合适的参数调用其超类的 super().__new__()，并在返回之前修改实例
        def __new__(cls, name, age):
            print("__new__", "被调用了")
            return super().__new__(cls)

        # 实例化类被调用
        def __init__(self, name, age) -> None:
            print("__init__", "被调用了")
            self.name= name
            self.age= age

        # 对象实例() 的时候被调用, 比如 cls= MyClass(); cls("你好")
        def __call__(self, *args, **kwargs):
            print("__call__", "被调用了")

        # 析构函数, 对象被销毁是调用
        def __del__(self):
            print("__del__", "被调用了")

        ###############################################
        # 属性相关
        # 使用 "对象实例.属性, 对象实例.方法名()" 被调用
        def __setattr__(self, name: str, value: Any) -> None:
            print("__setattr__", "被调用了")
            super().__setattr__(name, value)

        # 获取 "对象实例.属性" 被调用
        def __getattribute__(self, name: str) -> Any:

        # __getattribute__ 与 __getattr__ 的区别
        # __getattribute__方法优先级比__getattr__高
        # 只有在__getattribute__方法中找不到对应的属性时，才会调用__getattr__
        # 如果是对不存在的属性做处理，尽量把逻辑写在__getattr__方法中
            print("__getattribute__", "被调用了")
            return super().__getattribute__(name)

        # 删除 "对象实例.属性" 被调用
        def __delattr__(self, name: str) -> None:
            print("__delattr__", "被调用了")
            super().__delattr__(name)

        # 获取 obj["name"] 时候调用
        def __getitem__(self, item):
            if hasattr(self, item):
                return getattr(self, item)
            return "数据不存在 !!!"

        # 修改 obj["name"] 时候调用
        def __setitem__(self, key, value):
            pass

        # 删除 obj["name"] 时候调用
        def __delitem__(self, key):
            pass

        #################################################
        # 打印类对象相关
        # 打印类对象, 使用print(对象名), str(对象名)
        def __str__(self):
            print("__str__", "被调用了")
            return "hello, world"

        # 打印类对象, 在 python 命令行中使用: >> cls= MyClass(); cls;
        def __repr__(self):
            print("__repr__", "被调用了")
            '''函数说明'''
            return super().__repr__()
        
        # 打印对象的属性和方法, 使用dir(对象名) 时被调用
        def __dir__(self):
            print("__dir__", "被调用了")
            return super().__dir__()

        ###################################################
        # 迭代器和生成器: 主要用来节约内存
        # 函数迭代器: 使用iter()和next()进行迭代, 主动抛出`raise StopIteration`异常停止迭代.
        i= iter([1, 3, 2]) # 返回一个迭代器
        # 使用`for...in...`或者多个next()进行遍历, for...in...会检测异常, 停止遍历, next()不会.
        # 建议使用for...in...
        next(i)  

        # 类实现迭代器: 实现`__iter__(), __next__()`方法
        class MyIter:
            def __init__(self, data: list):
                self.__data=data
                self.__step=0

            def __iter__(self):  # 使用iter()调用该函数
                return self
            
            def __next__(self):  # 使用next()调用该函数, 返回迭代元素
                if self.__step >= len(self.__data):
                    raise StopIteration  
                data = self.__data[self.__step]
                self.__step += 1
                return data

        # 生成器
        def intNum():
            print("开始执行")
            for i in range(5):
                yield i    # 程序运行到yield会主动让出, 遇到next()会恢复执行yield后面的程序.
                print("继续执行")
        # 返回一个生成器
        num = intNum() 
        # 生成器元素的遍历可以通过for...in...或者next().
        for el in num: 
            print(el)
        # 或者
        # while True:
        #     try:
        #         next(g)  # 如果迭代已经执行完成, 继续使用next()会报错
        #     except StopIteration:
        #         exit(1)

        # 使用场景
        # 读取一个很大的文件, 打印文件内容,同时返回文件内容供其他程序使用.
        # 方案一: 使用数组保存数据, 再返回该数组
        def read_file(fpath): 
            li=[]
            BLOCK_SIZE = 1024 
            with open(fpath, 'rb') as f: 
                while True: 
                    block = f.read(BLOCK_SIZE) 
                    if block: 
                        print(block) 
                        li.append(block)  # 这种方式会导致li的内存占用很高
                    else: 
                        return
            return li

        # 方案二: 使用生成器返回数据
        def read_file(fpath): 
            BLOCK_SIZE = 1024 
            with open(fpath, 'rb') as f: 
                while True: 
                    block = f.read(BLOCK_SIZE) 
                    if block: 
                        print(block) 
                        yield block  # 使用yield可以返回文件的数据供其他程序使用, 内存占用很低
                    else: 
                        return

        # 迭代函数
        # map()、filter() 和 reduce()，通常结合匿名函数 lambda 一起使用
        l = [1, 2, 3]
        l1 = [1, 2, 3, 4, 5]
        new_list = map(lambda (x, y): x * y, l, l1) # 结果: [1, 4, 9]

    #######################################################
    # 反射
    # 类的魔术属性(内置属性)
    # __dict__ : 类的属性
    # __module__ : 类的模块
    # __class__ : 类
    # obj = MyClass()
    # print(obj.__class__ is MyClass)   # True

    # 1.什么是反射：
    #    把字符映射到实例的变量或实例的方法，然后可以去执行调用、修改
    #    反射的本质(核心)：基于字符串的事件驱动，利用字符串的形式去操作对象/模块中成员(方法、属性)
    # 2.反射的四个重要方法
    #    1）getattr获取对象属性/对象方法
    #    2）hasattr判断对象是否有对应的属性及方法
    #    3）delattr删除指定的属性
    #    4）setattr为对象设置内容
    ss = MyClass("小猫", 32)
    eat = getattr(ss, "eat")
    eat()
    setattr(ss, "name", "wangxi")
    delattr(ss, "name")
    print(hasattr(ss, "name"))  # 结果: False

- 装饰器
    ```python
    # 装饰器
    # 定义: 在不修改被装饰器对象源代码以及调用方式的前提下为被装饰对象添加新功能
    # 函数装饰器
    # 使用函数实现的函数装饰器(不带参数)
    def wrapper(func):
        '''装饰器, 包加载的时候就执行, 只执行一次'''
        def inner_wrapper(*args, **kwargs):
            '''内装饰器'''
            print("名字: %s, 年龄: %d" % (name, age))
            res = func(*args, **kwargs)
            return res
        return inner_wrapper

    # 使用函数实现的函数装饰器(带参数)
    def wrapper_out(name, age):
        '''外装饰器, 包加载的时候就执行, 只执行一次'''
        def wrapper(func):
            '''装饰器, 包加载的时候就执行, 只执行一次'''
            def inner_wrapper(*args, **kwargs):
                '''内装饰器'''
                print("名字: %s, 年龄: %d" % (name, age))
                res = func(*args, **kwargs)
                return res
            return inner_wrapper
        return wrapper
    # 装饰器的使用
    @wrapper_out(name="wangxi", age=25)
    def hello(name):
        '''函数说明'''
        time.sleep(5)
        print("hello, " + name)

    # 使用类实现的函数装饰器(带参数)
    class MyPrint:
        '''类名'''
        def __init__(self, name, age) -> None:
            self.name= name
            self.age= age
        def __call__(self, func):
            '''装饰器'''
            def inner_wrapper(*args, **kwargs):
                '''内装饰器'''
                print("名字: %s, 年龄: %d" % (self.name, self.age))
                res = func(*args, **kwargs)
                return res
            return inner_wrapper
        
    @MyPrint("wang", 22)
    def hello(name) :
        '''函数说明'''
        print("hello, " + name)

    # 类装饰器
    # 使用装饰器实现单例模式
    def singleton(cls):
        instance = {}
        def inner(*args, **kwargs):
            if cls is not instance:
                instance[cls] = cls(args, kwargs)
            return instance[cls]
        return inner

    @singleton
    class Singleton:
        pass
    ```

- 函数注解
    ```python
    # 函数注解: typing 类
    # 所有类型: Any | None
    # 字典类型: dict, Dict[str, str]
    # 多种类型: str | int, Union[str, ...]
    # 元组类型: Tuple[int, str]
    # 回调类型: Callable[[int], int]
    def hello(self, a :int) -> None :
        '''函数说明'''
        pass
    ```

- 异常处理
    ```python
    try:
        raise EOFError("EOF异常")
    except (EOFError, ValueError) as e:
        print("捕获异常时执行. 未捕获异常, 向上抛出异常, 直至捕获")
    else:
        print("无异常时候执行")
    finally:
        print("无论异常与否, 都会执行")
    ```

- 上下文管理器
    ```python
    # 上下文管理器: with... as ..., 用来释放资源或者后置处理
    with open(file="1.txt", mode="a+") as f:
        f.write("hello, world!!!")
    # 等于
    # try:
    #     f = open(file="1.txt", mode="a+")
    # finally:
    #     f.close()

    # 基于类实现的上下文管理器
    # 类需要实现`__enter__()`和`__exit__()`方法
    class FileManager(object):
        def __init__(self, filename: str, mode: str) -> None:
            print("调用__init__")
            self.filename = filename
            self.mode = mode
            self.file: Optional[TextIO] = None

        def __enter__(self):
            print("调用__enter__")
            self.file = open(self.filename, self.mode)
            return self.file

        def __exit__(self, exc_type, exc_val, exc_tb):
            """
            退出上下文管理器调用
            :param exc_type:  exception_type -- 异常类型
            :param exc_val: exception_value -- 异常值
            :param exc_tb: traceback -- 追踪信息
            :return:
            """
            print("调用__exit__")
            if self.file:
                print(exc_type, exc_val, exc_tb)
                self.file.close()

    if __name__ == '__main__':
        with FileManager("1.txt", mode="r") as f:
            f.read()
            raise ValueError("值错误!!!")
    # 结果:
    # 调用__init__
    # 调用__enter__
    # 调用__exit__
    # <class 'ValueError'> 值错误!!! <traceback object at 0x000001DEBC753508>

    # 基于生成器实现的上下文管理器: 需要加contextmanager装饰器
    @contextmanager
    def file_manager(filename: str, mode: str):
        f1 = None
        try:
            f1 = open(filename, mode)
            yield f1
        finally:
            f1.close()
            print("关闭文件")


    if __name__ == '__main__':
        with file_manager("1.txt", mode="r") as f:
            print(f.read())
            raise ValueError("值错误!!!")
    ```

---
#### 2. Web 框架: Django
##### 2.1 django指令详情
- django 常用指令
    ```python
    # 创建 django 项目
    django-admin startproject mysite 
    # 进入django项目, 创建 django 应用               
    django-admin startapp app 

    # 运行 django web 服务                   
    # 0.0.0.0 是对内外(IP, 127.0.0.1)开放，说明80端口外面可以访问
    # 127.0.0.1 是只能本机(IP, 127.0.0.1)访问，外面访问不了此端口
    # 192.168.3.15 是内外都能通过 IP 访问
    python manage.py runserver 0.0.0.0:8080  

    # 构造 app 数据库迁移数据                    
    python manage.py makemigrations app       
    # 更新 app 数据库迁移数据   
    python manage.py migrate app 

    ```
##### 2.2 跨域访问
- 跨域访问测试脚本
    ```javascript
    // 打开浏览器，找一个空白文档，然后按下F12进入调试窗口，进入 console tab页输入以下代码，然后回车即可 
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "http://106.13.223.242:8000/");
    xhr.send(null);
    xhr.onload = function(e) {
        var xhr = e.target;
        console.log(xhr.responseText);
    }
    ```
- 允许跨域访问
    ```python

    ```

##### 2.3 django 项目目录
- 项目目录
    ```python
    mysite/
        manage.py
        mysite/
            __init__.py
            settings.py
            urls.py
            asgi.py
            wsgi.py

    # 这些目录和文件的用处是：
    # 最外层的 mysite/ 根目录只是你项目的容器， 根目录名称对 Django 没有影响，你可以将它重命名为任何你喜欢的名称。
    # manage.py: 一个让你用各种方式管理 Django 项目的命令行工具。
    # 里面一层的 mysite/ 目录包含你的项目，它是一个纯 Python 包。它的名字就是当你引用它内部任何东西时需要用到的 Python 包名。 (比如 mysite.urls).
    # mysite/__init__.py：一个空文件，告诉 Python 这个目录应该被认为是一个 Python 包。
    # mysite/settings.py：Django 项目的配置文件。
    # mysite/urls.py：Django 项目的 URL 声明，就像你网站的“目录”。
    # mysite/asgi.py：作为你的项目的运行在 ASGI 兼容的 Web 服务器上的入口。
    # mysite/wsgi.py：作为你的项目的运行在 WSGI 兼容的Web服务器上的入口。

    # 创建app: django-admin startapp myapp
    # 在 mysite/settings.py 中添加 myapp
    INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'myapp'  # 添加 myapp 应用
    ]

    ```
##### 2.4 路由
- django 路由的介绍
    ```python
    # 项目app的路由: mysite/urls.py
    from django.contrib import admin
    from django.urls import path, include

    urlpatterns = [
        path('admin/', admin.site.urls),
        # include(), 引入其他 app 的urls.py
        # 引入 myapp 的路由
        path('myapp/', include("myapp.urls")),
    ]

    # 其他app的路由: polls/urls.py
    from django.urls import path, re_path
    from myapp import views

    urlpatterns = [
        path('index/', views.index),
        # 正则表达式
        re_path(r'^ho\w+$', views.home),
    ]  

    ```
##### 2.5 视图
- django 视图介绍
    ```python
    from django.shortcuts import render, redirect
    from django.http import HttpResponse, JsonResponse
    from django.views.decorators.csrf import csrf_exempt

    def index(req) :
        print(req.GET)
        print(req.POST)
        print(req.body)
        print(req.path)
        print(req.method)
        msg="欢迎来到 app01"
        return HttpResponse(msg)

    def index01(req) :
        return redirect('/myapp01/index')

    # 防止 csrf 攻击
    @csrf_exempt
    def home(req) :
        data={
            "name" : "wango",
            "subject": {
                "password": "123456"
            }
        }
        # 响应 json 格式的数据, 防止中文乱码
        # return HttpResponse(json.dumps(data, ensure_ascii=False),content_type="application/json,charset=utf-8")
        return JsonResponse(data, json_dumps_params={'ensure_ascii':False})
    
    ```
##### 2.6 数据库操作
- 数据类型 
    ```python
    # AutoField:自动增长的IntegerField，通常不用指定，不指定时Django会自动创建属性名为id的自动增长属性    
    # BooleanField: 布尔字段，值为True或False 
    # CharField: 字符串，参数max_length表示最大字符个数 
    # TextField: 大文本字段，一般超过4000个字符时使用
    # IntegerField: 整数 
    # DecimalField: 十进制浮点数， 参数max_digits表示总位数， 参数decimal_places表示小数位数
    # FloatField: 浮点数 
    # DateField: 日期， 参数auto_now表示每次保存对象时，自动设置该字段为当前时间，用于"最后一次修改"的时间戳，它总是使用当前日期，默认为False； 参数auto_now_add: 表示当对象第一次被创建时自动设置当前时间，用于创建的时间戳，它总是使用当前日期，默认为False; 参数auto_now_add和auto_now是相互排斥的, 组合将会发生错误
    # TimeField: 时间，参数同 DateField
    # DateTimeField: 日期时间，参数同 DateField
    # FileField: 上传文件字段
    # ImageField: 继承于FileField，对上传的内容进行校验，确保是有效的图片  
    ```

- 数据类型选项
    ```python
    # null: 如果为True，表示允许为空，默认值是False           
    # blank: 如果为True，则该字段允许为空白，默认值是False 
    # db_column: 字段的名称，如果未指定，则使用属性的名称 
    # db_index: 若值为True, 则在表中会为此字段创建索引，默认值是False 
    # default: 默认 
    # primary_key: 若为True，则该字段会成为模型的主键字段，默认值是False，一般作为AutoField的选项使用
    # unique: 如果为True, 这个字段在表中必须有唯一值，默认值是False 
    ```

- 数据库的配置
   ```python
   # 安装 mysql 第三方包
   pip install PyMySQL

   # 在Django的工程同名子目录的__init__.py文件中添加如下语句
   import pymysql
   pymysql.install_as_MySQLdb()

   # 修改 mysite/settings.py 中DATABASES配置信息
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'HOST': '127.0.0.1',  # 数据库主机
            'PORT': 3306,  # 数据库端口
            'USER': 'root',  # 数据库用户名
            'PASSWORD': 'mysql',  # 数据库用户密码
            'NAME': 'book'  # 数据库名字
        }
    }

    # 数据本地化
    # 设置中文, 开发时一般使用UTC时间
    LANGUAGE_CODE = 'zh-hans'
    TIME_ZONE = 'Asia/Shanghai'
    USE_TZ = True

   ```
- 数据库的定义文件
    ```python
    # 模型类被定义在"应用/models.py"文件中
    from django.db import models

    class BookInfo(models.Model):
        name = models.CharField(max_length=20, verbose_name='名称', default= 'python入门', unique=True)
        create_time= models.DateTimeField(verbose_name='创建日期', auto_now_add=True)
        sell_price= models.DecimalField(max_digits=5, decimal_places=2, default=0, verbose_name= "销售价格")
        update_time= models.DateTimeField(verbose_name='更新日期', auto_now=True)
        read_count= models.IntegerField(default=0, verbose_name='阅读量')
        comment_count= models.IntegerField(default=0, verbose_name='评论数量')
        is_delete= models.BooleanField(default=False, verbose_name='逻辑删除')
        delete= models.BooleanField(default=False, verbose_name='物理删除')

        class Meta:
            db_table= 'book_info'
            verbose_name= '图书'  # django admin中显示
            verbose_name_p= '图书'  # django admin中显示

        def __str__(self):
            return self.name   

    ```
- 数据库的增删改查
    ```python
    # 在"应用/views.py"文件中, 使用数据库类
    # 增加数据
    BookInfo.objects.create( name= 'php 入门' )

    # 修改数据
    BookInfo.objects.filter(id=15).update(name='golang 入门')

    # 删除数据
    BookInfo.objects.filter(id=15).delete()

    # 查询数据
    BookInfo.objects.filter(id=15).all()
    # 过滤查询
    # filter过滤出多(0/1/n)个结果
    # exclude排除掉符合条件剩下的结果
    # get过滤单一结果
    # 模糊查询 -> contains:是否包含, startswith、endswith：以指定值开头或结尾
    # 比较查询 -> gt大于, gte大于等于, lt小于, lte小于等于
    # 范围查询 -> in：是否包含在范围内, BookInfo.objects.filter(id__in=[1,3，5])
    # Q 对象 -> Q(readcount__gt=20)|Q(id__lt=3), &表示逻辑与，|表示逻辑或, ~表示非not
    BookInfo.objects.filter(Q(readcount__gt=20)|Q(id__lt=3))

    # 聚合函数 -> 使用aggregate()过滤器调用聚合函数。聚合函数包括：Avg平均，Count数量，Max最大，Min最小，Sum求和
    # 日期数据类型(DateField)可以用 Max 和 Min
    # 起别名: aggregate(别名 = 聚合函数名("属性名称"))
    BookInfo.objects.aggregate(rc= Sum('readcount'))
    # 使用count时一般不使用aggregate()过滤器
    BookInfo.objects.count()

    # 排序函数 -> 升序: BookInfo.objects.all().order_by('readcount')
    # 降序: BookInfo.objects.all().order_by('-readcount')

    # 查询部分字段: values("pk","price")
    # exists() 方法用于判断查询的结果 QuerySet 列表里是否有数据
    # distinct() 方法用于对数据进行去重

    # 分组查询: BookInfo.objects.values('name').annotate(Sum('sell_price'), Avg('sell_price'))

    ```

#### 3. 单元测试框架: Pytest
##### 3.1 pytest 的基本知识
- pytest 默认规则:
    - `py`文件必须以`test_`开头
    - 类名必须以`Test`开头
    - 测试用例方法必须以`test_`开头

- pytest 查看帮助: `pytest --help`
- pytest 查看所有注册的标志: `pytest --markers`
- pytest 查看所有注册的插件: `pytest --fixtures`
- 自带的marker
  - `@pytest.mark.skip()`: 跳过执行测试用例
  - `@pytest.mark.parametrize(args_name, args_value)`: 数据驱动
  - `@pytest.mark.parametrize(name=None,depends=[],scope='module')`: 用例依赖
    - name: 别名, depends: 依赖, scope: 查找依赖范围, 必须是session,package,module或class,默认为module, 和fixture不一样
    - 首先声明依赖: `@pytest.mark.dependency(name='testUserCheck')`
    - 调用依赖: `@pytest.mark.dependency(depends= ["testUserCheck"], scope='package')`, 可以嵌套; 依赖用例执行失败, 此用例会跳过

- 主函数的运行参数(命令行的方式）
    - `-v` 输出更加详细的运行信息
    - `-s` 输入调试信息
    - `-n` 多线程
    - `-m smoke` 只执行标识用例
    - `--lf` 失败用例重跑
    - `--html` 输出测试报告
    - `--alluredir` 输出测试报告
    - `--count` 每条用例执行次数, 安装插件: `pip install pytest-repeat`
    - `pytest.main(['-vs','--html=report.html'])`

- 启动文件`main.py`:
    ```python
    import pytest

    if __name__ == '__main__':
        pytest.main()
    ```

- 导包的注意事项: 导入包的时候会依次到 sys.path 目录下去寻找, 不存在的目录可以用`sys.path.append()`添加
- 添加pytest.ini配置文件
    ```ini
    [pytest]
    addopts = -vs -n=2 --alluredir=./result/tmp
    testpaths= ./test
    python_files = test_*.py
    python_classes = "Test*"
    python_functions = "test_beta*"
    markers =
        smoke: execute smoke testcases
    ```

##### 3.2 前后置，夹具
- `setup()/teardown()`:每个用例之前或者之后执行一次
- `setup_class()/teardown_class()`:每个类之前或者之后执行一次
- fixture 的定义: `@pytest.fixture(scope='作用域',params='数据驱动',autouse='自动执行')`
  - fixture里面有个scope参数可以控制fixture的作用范围：session>module>class>function
  - function：每一个函数或方法都会调用
  - class：每一个类调用一次，一个类中可以有多个方法
  - module：每一个.py文件调用一次，该文件内又有多个function和class
  - package：单个包调用一次，可以跨.py文件调用，每个.py文件就是module
  - session: 程序整个执行的生命周期

- pytest.fixture 的使用(三种方式)
    - 方法一: 使用装饰器 @pytest.mark.usefixtures("函数名") 修饰需要运行的用例, 一个方法或者一个class用例想要同时调用多个fixture，可以使用@pytest.mark.usefixture()进行叠加. 注意叠加顺序，先执行的放底层，后执行的放上层
        ```python
        ''' pytest.fixture的多层次使用, 注意无法嵌套 '''
        @pytest.fixture()
        def test_home01(self):
            print("打开浏览器")
            yield "层级 01"
            print("关闭浏览器")

        @pytest.fixture()
        def test_home02(self):
            print("打开IEF平台")
            yield " 层级 02"
            print("关闭IEF平台")

        @pytest.mark.usefixtures("test_home02")
        @pytest.mark.usefixtures("test_home01")
        def test_home03(self):
            print("这里是 test_home03")
        
        ```

    - 方法二: 把函数名传到另个函数的参数列表中, 返回值可以作为函数的传参, 而且 pytest.fixture 可以嵌套使用
        ```python
        ''' pytest.fixture的嵌套 '''
        class TestPage01:
        @pytest.fixture()
        def test_home01(self):
            print("打开浏览器") 
            yield "层级 01"  # 后置夹具, request.addfinalizer(函数名) 也可以实现同样的功能
            print("关闭浏览器") # 前置夹具出异常了, 后置夹具不会执行

        @pytest.fixture()
        def test_home02(self, test_home01):
            print("打开IEF平台")
            yield test_home01 + " > 层级 02"
            print("关闭IEF平台")

        def test_home03(self, test_home02):
            print("这里是 test_home03")   # 执行结果: 打开浏览器 > 打开IEF平台 > 这里是 test_home03 > 关闭IEF平台 > 关闭浏览器

        def test_home04(self):
            print("这里是 test_home04")
        ```

    - 方法三: `@pytest.fixture(scope='作用域',params='数据驱动',autouse='自动执行')`, 将 `autouse= True`, fixture会自动执行
    - fixture 中函数参数 params 的使用
      ```python
      @pytest.fixture(params=['password'])
      def test_password(self, request):
          print("hello, world ! ! !", request.param)    
      ```
    - 一般情况下`@pytest.fixture()`会放在`conftest.py`文件中, conftest.py 与 pytest.ini 在同一个目录就好

##### 3.3 插件
- allure
  - allure 装饰器: BDD风格的标签
    - `@allure.epic`：敏捷里面的概念，定义史诗，相当于module级的标签
    - `@allure.feature`：功能点的描述，可以理解成模块，相当于class级的标签
    - `@allure.story`：故事，可以理解为场景，相当于method级的标签
    - 报告显示的层级: `epic > feature > story`  --> `module > class > method`

  - allure-pytest生成测试报告
    - allure2 的下载地址: <https://github.com/allure-framework/allure2/releases>
    - 下载`allure`, 将`bin`文件添加到环境变量中, allure 依赖Java环境, 需要装java
    - 生成报告的指令: `allure generate  ./result/tmp -o ./result/html --clean`, 先在pytest.ini中设置参数 `--alluredir=./result/tmp`, 再使用此命令生成临时文件, `-o ./result/html`输出报告到指定目录

- zmail
- pywin32和pyperclip
    ```python
    # 获取粘贴板的内容
    # pywin32插件, 只能在windows中使用, linux中无法使用, 安装指令: `pip install pywin32`
    # pyperclip插件, 实现了不同系统的兼容, 安装指令: `pip install pyperclip`
    # 获取粘贴板的内容
    # 注意: Ubuntu20.04系统中需要先安装插件`sudo apt-get install xsel xclip`
    pyperclip.paste()
    ```

##### 3.4 常用语句
- `with assume + assert` 与 assert 的区别
    ```python
    # with assume 示例
    def test_home04(self):
        print("==这里是 test_home04==")
        with assume:
            assert 1 == 2  
            assert True  # 断言失败不会执行

        with assume:  # 断言失败继续执行
            assert False

        print("hello, world")  # 断言失败继续执行

    # assert 示例
    def test_home04(self):
        print("==这里是 test_home04==")
        assert False
        assert 1 == 2  # 断言失败不会执行
    ``` 
---
#### 4. UI 自动化测试
##### 4.1 Selenium 的常用方法
- Selenium 基本知识
    ```python
    # Chrome headless 模式
    options= Options()
    # 需要 UI 直接注释这行代码
    # options.add_argument('--headless')
    self.driver: WebDriver = webdriver.Chrome(options=options)

    # 浏览器驱动
    driver: WebDriver = webdriver.Chrome()
    # 页面加载时间, 超时报错, 范围为全局
    driver.set_page_load_timeout(10)
    # 执行Javascript来停止页面加载 window.stop()
    try:
        ele.driver.get("https://element.eleme.cn/#/zh-CN/component/i18n")
    except:
        ele.driver.execute_script('window.stop()')  
        
    driver.maximize_window()
    # 关闭单个页面, 关闭所有页面
    driver.close()
    driver.quit()
    # 页面前进, 刷新, 后退
    driver.forward(), driver.refresh(), driver.back()


    # 三种等待方式
    # 固定等待: time.sleep(3)
    # 显示等待, 轮询查找元素, 在指定的时间内找不到元素报错: TimeoutException
    # 隐式等待, 轮询查找元素, 常用于find_element(), 在指定的时间内找不到元素报错: NoSuchElementException
    # 显式时间和隐式时间不能并存, 使用显示等待, 需要屏蔽隐式等待
    driver.implicitly_wait(5)
    def find_ele(driver: WebDriver, timeout: float = 5, **kwargs) -> WebElement:
        return WebDriverWait(driver, timeout).until(
            expected_conditions.presence_of_element_located((kwargs["by"], kwargs["value"])))

    ####################################
    # 元素操作
    # XPath中的`/`从当前节点开始，`//`从任意节点的子节点开始 
    # XPATH 的模糊定位: "//*contains()", 比如: //a[contains(text(), '退出')]
    # xpath 的父子节点查找
    # . 当前节点, 比如 "xpath=//*[text()="123"]/." , 文本为123节点
    # .. 父节点, 比如 "xpath=//*[text()="123"]/../.." , 文本为123节点的父节点的父节点
    el: WebElement = driver.find_element(by=By.XPATH, value="/html/body/div[2]/div/main/p[4]/a")
    # 获取元素的文本, 大小
    print(el.text, el.size)
    # 元素是否可见, 元素是否可用
    print(el.is_displayed(), el.is_enabled())
    # 获取元素的属性
    el.get_attribute("value")
    el.send_keys()

    #####################################
    # 鼠标与键盘操作
    # 悬停到某个元素
    chain: ActionChains = ActionChains(ele.driver).move_to_element(el)
    # 单击, 右击, 双击, 拖放
    chain.click()
    chain.context_click()
    chain.double_click()
    chain.drag_and_drop()
    # js 点击
    ele = self.find_element(locator)
    self.driver.execute_script("arguments[0].click();", ele)
    # 执行操作链中的行为
    chain.perform()
    # 键盘操作
    # 输入文本
    chain.send_keys("text")
    # 组合键 Control + A
    chain.send_keys(Keys.ENTER, 'a')
    # 截屏
    ele.driver.get_screenshot_as_file(r"C:\Users\wwx1182966\Desktop\2.0.png")
    
    #######################################
    # iframe操作
    # 切换到某个iframe
    driver.switch_to.frame("frame_name")
    # 切换到主iframe
    driver.switch_to.default_content()
    # 切换到父窗口
    driver.switch_to.parent_frame()

    #######################################
    # 窗口操作
    # 获取所有的窗口句柄
    driver.window_handles
    # 获取当前窗口句柄
    driver.current_window_handle
    # 切换到一个窗口句柄
    driver.switch_to.window("窗口句柄")

    #######################################
    # 弹窗与表单
    # 弹窗: 只能捕获html自带的alert, prompt, comfirm
    alert: Alert = driver.switch_to.alert
    # 弹窗的确定和取消
    alert.accept()
    alert.dismiss()
    # 获取弹窗的文本, 输入弹窗的文本
    alert.text
    alert.send_keys()
    # 下拉框
    select: Select= Select(el)
    # 通过值选择下拉框
    select.select_by_value("10")
    # 文件上传
    driver.find_element(by=By.XPATH, value="/html/body/div[2]/div/main/p[4]/a").send_keys(r'C:\Users\wwx1182966\Desktop\1.0.png')

    #########################################
    # cookie
    # 获取单个cookie, 获取所有的 cookies
    driver.get_cookie("name")
    driver.get_cookies()
    # 删除单个cookie, 获取所有cookies
    driver.delete_cookie("name")
    driver.delete_all_cookies()
    ```

##### 4.2 Selenium 进阶知识

##### 4.3 autotest 框架
- autotest 框架文件树
    ```shell
    Autotest 框架 
    ├─common                          
    ├─config                          
    ├─page                            
    ├─page_element                    
    │  └─ief                          
    │      └─ui_ief                   
    ├─page_object                     
    │  └─ief                          
    │      └─ui_ief                   
    ├─script                          
    ├─TestCase                        
    │  └─ief                          
    │      └─ui_ief                   
    │          ├─edge_application     
    │          └─fixture              
    ├─TestData                        
    │  └─ief                          
    │      └─ui_ief                   
    └─utils
    ```
---
#### 5. 接口自动化测试
##### 5.1 Postman 实现接口自动化
- postman 脚本
    ```javascript
    // 设置获取环境变量
    pm.environment.set("X-Subject-Token", pm.response.headers.get("X-Subject-Token"))
    pm.environment.get("X-Subject-Token")
    // 获取响应状态码, cookie, 响应头, 响应体(json, string)
    var code= pm.response.code
    var cookies= pm.response.cookies
    var header= pm.response.headers.get("Content-Type")
    var body_json = pm.response.json()
    var body_text= pm.response.text()
    // 正则表达式
    var regx= body_text.match('"expires_at":"(.*?)"')
    // 断言
    tests["响应是否成功"]= code===200
    
    ```
##### 5.2 request 框架
- 请求方法
    ```python
    # 请求头中的 Content-Type 类型的区别
    # application/x-www-form-urlencoded: 一般表单提交都是这种格式
    # application/json: json格式提交数据
    # multipart/form-data: 常用于文件上传

    # params: 支持dict, 加在url 后面的请求参数, 用于get
    # json: 支持字典, 默认Content-Type: application/json, 请求体中
    # data: 支持字典, Content-Type为非json格式使用, 请求中
    # files: 文件上传
    res = request(method=method, url=url, params=params, json=data, files=files, headers=headers, timeout=10)

    # 请求的url, 请求头, 请求体
    res.request.url, res.request.headers, res.request.body

    # 响应数据
    print(res.headers)          
    print(res.status_code)
    res.encoding = 'utf-8' # 防止乱码
    print(res.text)
    res.json()
    ```
    
- 请求resful-api
    ```python
    import requests
    domain = "http://localhost:8080"
    timeout = 10
    def print_request(request: requests.PreparedRequest):
        print("#### 请求信息:")
        print("请求url: ", request.url)
        print("请求方式: ", request.method)
        print("请求头: ", request.headers)
        print("请求体: ", request.body)

    def print_respose(resp: requests.Response, json: bool = True):
        print("#### 响应信息:")
        print("响应状态码: ", resp.status_code)
        print("响应头: ", resp.headers)
        resp.encoding = 'utf8'
        if json:
            print("响应体: ", resp.json())
        else:
            print("响应体: ", resp.text)

    # 获取所有用户信息
    def get_all_users():
        resp = requests.request(url=domain + r"/hello?name=123&password=12121", method="GET", timeout=timeout)
        print_request(resp.request)
        print_respose(resp)

    # 获取个人用户信息
    def get_user():
        resp = requests.request(url=domain + r"/hello/1", method="GET", timeout=timeout)
        print_request(resp.request)
        print_respose(resp)

    # 注册用户
    def register_user():
        json = '{ "name": "123", "password": "123456" }'
        resp = requests.request(url=domain + r"/hello", method="POST", timeout=timeout, json=json)
        print_request(resp.request)
        print_respose(resp)

    # 上传用户头像
    def upload_user_icon():
        files = {
            "image_file": ("Snipaste_2023-01-14_14-05-26.png",
                        open(r"C:/Users/Administrator/Postman/file/Snipaste_2023-01-14_14-05-26.png", mode='rb')),
            "image_file001": ("Snipaste_2023-01-14_14-05-26 - 副本.png",
                            open(r"C:/Users/Administrator/Postman/file/Snipaste_2023-01-14_14-05-26 - 副本.png", mode='rb'))
        }
        resp = requests.request(url=domain + r"/hello/1/upload", method="POST", timeout=timeout, files=files)
        print_request(resp.request)
        print_respose(resp)

    # 下载文件
    def download_files():
        resp = requests.request(url=domain + r"/hello/download/Snipaste_2023-01-14_14-05-26.png", method="GET",
                                timeout=timeout)
        print_request(resp.request)
        print_respose(resp, json=False)

    # 修改用户信息
    def update_user():
        json = {"name": "123"}
        resp = requests.request(url=domain + r"/hello/1", method="PUT", json=json, timeout=timeout)
        print_request(resp.request)
        print_respose(resp)

    # 删除用户信息用户信息
    def delete_user():
        resp = requests.request(url=domain + r"/hello/46556", method="DELETE", timeout=timeout)
        print_request(resp.request)
        print_respose(resp)

    if __name__ == '__main__':
        get_all_users()
        get_user()
        register_user()
        upload_user_icon()
        download_files()
        update_user()
        delete_user()
    ```

#### 6. 设计模式
##### 6.1 基本知识
- 设计模式六大原则
    ```txt
    1、单一原则（Single Responsibility Principle）：一个类或者一个方法只负责一项职责，尽量做到类的只有一个行为原因引起变化；
    　　a、业务对象（BO business object）、业务逻辑（BL business logic）拆分；
    2、里氏替换原则（LSP liskov substitution principle）：子类可以扩展父类的功能，但不能改变原有父类的功能；（本质其实就是c++的多态）
    　　（目的：增强程序的健壮性）实际项目中，每个子类对应不同的业务含义，使父类作为参数，传递不同的子类完成不同的业务逻辑。
    3、依赖倒置原则（dependence inversion principle）：面向接口编程；（通过接口作为参数实现应用场景）
    　　抽象就是接口或者抽象类，细节就是实现类
    　　含义：
    　　　　上层模块不应该依赖下层模块，两者应依赖其抽象；
    　　　　抽象不应该依赖细节，细节应该依赖抽象；
    通俗点就是说变量或者传参数，尽量使用抽象类，或者接口；
    【接口负责定义public属性和方法，并且申明与其他对象依赖关系，抽象类负责公共构造部分的实现，实现类准确的实现业务逻辑】
    4、接口隔离原则（interface segregation principle）：建立单一接口；（扩展为类也是一种接口，一切皆接口）
    　　　定义：
    　　　　a.客户端不应该依赖它不需要的接口；
    　　　　b.类之间依赖关系应该建立在最小的接口上；
    简单理解：复杂的接口，根据业务拆分成多个简单接口；（对于有些业务的拆分多看看适配器的应用）
    【接口的设计粒度越小，系统越灵活，但是灵活的同时结构复杂性提高，开发难度也会变大，维护性降低】　　　
    5、迪米特原则（law of demeter LOD）：最少知道原则，尽量降低类与类之间的耦合；
    一个对象应该对其他对象有最少的了解
    6、开闭原则（open closed principle）：用抽象构建架构，用实现扩展原则；
    ```

- 设计模式的分类
    - 创建型模式（5种）：工厂方法模式、抽象工厂模式、创建者模式、原型模式、单例模式
    - 结构型模式（7种）：适配器模式、桥模式、组合模式、装饰模式、外观模式、享元模式、代理模式
    - 行为型模式（11种）：解释器模式、责任链模式、命令模式、迭代器模式、中介者模式、备忘录模式、观察者模式、状态模式、策略模式、访问者模式、模板方法模式
- 抽象类的实现方式
    ```python
    # 抽象类需要继承抽象基类, 必须要有一个抽象方法. 抽象类不能实例化对象
    # 子类继承抽象类, 必须重写抽象类的抽象方法
    class MyClass(ABC):
        @abstractmethod
        def hello(self, a: int):
            pass
    ```

##### 6.2 创建型模式 
- 单例模式
    ```python
    # 使用模块导入
    # 实现原理：Python 的模块就是天然的单例模式，因为模块在第一次导入时，会生成 .pyc 文件，当第二次导入时，就会直接加载 .pyc 文件，而不会再次执行模块代码
    # singleton.py
    class Singleton(object):
        def foo(self):
            pass
    singleton = Singleton()
    # main.py
    from singleton import singleton

    # 使用装饰器
    def singleton(cls):
        """
        单例模式类装饰器
        装饰器加载父类上, 子类不能继承装饰器
        类实例对象的属性, 不能通过初始化方法改变
        """
        _instance = {}

        def _inner(*args, **kwargs):
            if cls not in _instance:
                _instance[cls] = cls(*args, **kwargs)
            return _instance[cls]

        return _inner

    # 基于__new__方法
    class Singleton:
        """
        单例类, 单例模式通过继承单例类实现.
        类实例对象的属性可以通过初始化方法改变, 以最后一个对象实例的属性值为准.

            my_class01 = MyClass(name="小明")
            # 最后对象实例的属性值都是``小白``.
            my_class02 = MyClass(name="小白")
        """
        _instance = None

        def __new__(cls, *args, **kwargs):
            """
            返回一个实例对象, 执行在__init__方法之前.
            """
            if cls._instance is None:
                cls._instance = super().__new__(cls)
            return cls._instance
    ```

- 工厂模式
    ```python
    class Payment(ABC):
        @abstractmethod
        def pay(self, money: float):
            pass

    class WechatPayment(Payment):
        def pay(self, money: float):
            print(self.__class__.__name__)

    class BankCardPayment(Payment):
        def pay(self, money: float):
            print(self.__class__.__name__)

    class PaymentFactory:
        @classmethod
        def get_payment(cls, class_name: Type[Payment]) -> Payment:
            return class_name()

    # 使用
    PaymentFactory.get_payment(BankCardPayment).pay(30)
    PaymentFactory.get_payment(WechatPayment).pay(30)
    ```

- 建造者模式
    ```python
    class Player:
        def __init__(self, face: str, body: str):
            self.face = face
            self.body = body
            
        def __str__(self):
            return "%s, %s" % (self.face, self.body)


    class PlayerBuilder(ABC):
        @abstractmethod
        def build_face(self):
            pass

        @abstractmethod
        def build_body(self):
            pass


    class SexyGirlBuilder(PlayerBuilder):
        def __init__(self):
            self.player = Player()

        def build_face(self):
            self.player.face = "漂亮脸蛋"

        def build_body(self):
            self.player.body = "苗条"


    class Monster(PlayerBuilder):
        def __init__(self):
            self.player = Player()

        def build_face(self):
            self.player.face = "怪兽脸"

        def build_body(self):
            self.player.body = "怪兽身材"

    class PlayerDirector:
        """
        指挥者: 控制组装顺序
        """
        def build_player(self, builder_obj):
            builder.build_body()
            builder.build_face()
            return builder.player

    if __name__ == '__main__':
        builder = Monster()
        director = PlayerDirector()
        p = director.build_player(builder)
    ```

##### 6.3 结构型模式 
- 适配器模式
    ```python
    class Payment(ABC):
        @abstractmethod
        def pay(self, money: float):
            pass

    class WechatPayment(Payment):
        def pay(self, money: float):
            print(self.__class__.__name__, money)

    class BankCardPayment(Payment):
        def pay(self, money: float):
            print(self.__class__.__name__, money)

    class AliPayment:
        """
        刚好有一个新写的支付宝类, 待适配
        """
        def cost(self, money: float):
            print(self.__class__.__name__, money)

    class PaymentAdaptor(Payment):
        """
        适配器类
        """
        def __init__(self, pay_class: Type, pay_method: str) -> None:
            self.pay_class = pay_class
            self.pay_method = pay_method

        def pay(self, money: float):
            if self.pay_method == "cost":
                self.pay_class().cost(money=money)

    # 使用
    PaymentAdaptor(pay_class=AliPayment, pay_method="cost").pay(300)
    ```

- 代理模式
    ```python
    class FileSubject(ABC):
        @abstractmethod
        def read(self):
            pass

        @abstractmethod
        def write(self, data: str) -> str:
            pass

    class RealFileSubject(FileSubject):

        def __init__(self, filename: str) -> None:
            self.filename = filename

        def read(self) -> str:
            with open(self.filename, mode='r+') as f:
                data = f.read()
            return data

        def write(self, data: str):
            with open(self.filename, mode="w+") as f:
                f.write(data)

    class ProxyFileSubject(FileSubject):
        def __init__(self, real_sub: FileSubject) -> None:
            self.sub = real_sub

        def read(self) -> str:
            return self.sub.read()

        def write(self, data: str):
            self.sub.write(data)

    if __name__ == '__main__':
        proxy_sub = ProxyFileSubject(RealFileSubject("1.txt"))
        proxy_sub.write("wewewe")
        print(proxy_sub.read())
    ```
    
##### 6.4 行为型模式
- 观察者模式
    ```python
    class Subscriber:
        def __init__(self, name: str) -> None:
            self.name = name

        def update(self, topic: str) -> None:
            print(topic)

    class Publisher:
        def __init__(self) -> None:
            self.subs = []
            self.topic = ""

        def set_topic(self, topic: str):
            self.topic = topic

        def add(self, sub: Subscriber):
            if sub not in self.subs:
                self.subs.append(sub)

        def remove(self, sub: Subscriber):
            if sub in self.subs:
                self.subs.remove(sub)

        def notify(self):
            for sub in self.subs:
                sub.update(self.topic)

    class ShopPublisher(Publisher):
        def activity(self, topic) -> None:
            self.topic = topic
            self.notify()

    if __name__ == '__main__':
        sub01 = Subscriber("sub01")
        sub02 = Subscriber("sub02")
        pub = ShopPublisher()
        pub.add(sub01)
        pub.add(sub02)
        pub.activity("商城推出了新活动")
        pub.remove(sub01)
        pub.activity("商城新活动结束")
    ```

#### 7. 数据结构
##### 7.1 栈
- 栈的实现
    ```python
    # 栈(Stack)
    class Stack:
        """
        实现一个栈类
        """
        def __init__(self) -> None:
            self.items = []

        def is_empty(self) -> bool:
            return len(self.items) == 0

        def push(self, item):
            self.items.append(item)

        def pop(self):
            self.items.pop()

        def size(self) -> int:
            return len(self.items)

        def peek(self) -> Any:
            """
            返回栈的最后一个元素

            :return:
            """
            return self.items[-1]

    ```
##### 7.2 队列
- 队列
  - 单向队列: Queue类
  - 双向队列: deque类
    ```python
    # 队列(Queue)
    # collections.deque实现了双向队列
    # 可以指定队列的长度`maxlen`, 方法和列表的方法类似
    # 超出最大长度后, 继续添加元素, 会把原来的元素踢出来
    queue = collections.deque(maxlen=2)
    # 在队列的尾部加入一个数据
    queue.append("last01")
    # 在队列的头部加入一个数据
    queue.appendleft("last01")
    # 在队列的尾部加入一个可迭代对象
    queue.extend([1, 2, 3])
    # 在队列的头部加入一个可迭代对象
    queue.extendleft(["头部"])
    # 在任意位置插入元素
    queue.insert(2, "wewe")
    # 通过下标访问
    print(queue[1])
    # 删除单个元素
    queue.remove("last01")
    ```

#### 8. 并发编程
##### 8.1 GIL锁
    ```python
    # GIL:又叫全局解释器锁，每个线程在执行的过程中都需要先获取GIL，保证同一时刻只有一个线程在运行，目的是解决多线程同时竞争python解释器而出现的线程安全问题. 即使在多核CPU中，多线程同一时刻也只有一个线程在运行，这样不仅不能利用多核CPU的优势，反而由于每个线程在多个CPU上是交替执行的，导致在不同CPU上切换时造成资源的浪费，反而会更慢。即原因是一个进程只存在一把gil锁，当在执行多个线程时，内部会争抢gil锁，这会造成当某一个线程没有抢到锁的时候会让cpu等待，进而不能合理利用多核cpu资源.

    # 解决GIL问题的方案： 
    # 1.使用其它语言，例如C,Java 
    # 2.使用其它解释器，如java的解释器python 
    # 3.使用多进程

    # 线程释放GIL锁的情况： 
    # 1.在IO操作等可能会引起阻塞的system call之前,可以暂时释放GIL,但在执行完毕后,必须重新获取GIL。 
    # 2.Python 3.x使用计时器（执行时间达到阈值后，当前线程释放GIL）或Python 2.x，tickets计数达到100。
    ```

##### 8.2 多进程
- multiprocessing模块
    ```python
    # 多进程: Process类
    # multiprocessing.Process()与threading.Thread()类似
    p = multiprocessing.Process(target=task, name="p1")
    # Process类的常用属性和方法:
    # 查看进程id, 进程名
    # p.pid, p.name
    # 启动进程
    p.start()
    # 终止进程: 发送 SIGTERM 信号给进程
    p.terminate()
    # 强制终止进程: 发送 SIGKILL 信号给进程
    p.kill()
    # 获取当前进程对象
    multiprocessing.current_process()
    # 获取当前进程的子进程对象
    multiprocessing.active_children()
    ```

- 进程的同步
    ```python
    # 互斥锁, 递归锁: threading.Lock(), threading.Rlock(), 与多线程类似
    # 文件中的全局变量, 在子进程中有单独的内存地址, 也就是说它的作用范围是子进程内部, 它不属于进程的共享资源.
    # 共享资源: 一个文件读写
    def task():   # 子进程
        lock = multiprocessing.Lock()
        with open("1.txt", mode="a+") as f:
            for _ in range(10000):
                with lock:
                    f.write("hello,world\n") 
        print(multiprocessing.current_process().name, "执行结束")

    # 信号量, 与多线程类似
    sem=multiprocessing.BoundedSemaphore(value=3)
    sem.acquire()
    sem.release()

    # 事件: threading.Event(), 与多线程类似
    event.set()  # 设置标志位为 True
    event.clear()  # 清空标志位(将标志位改为false)
    event.is_set()  # 检测标志位，如果标志位被设置，返回True，否则返回False
    event.wait() 

    # 队列: multiprocessing.Queue(), 与多线程类似
    # Queue.qsize() 返回队列的大小
    # Queue.empty() 如果队列为空，返回True,反之False
    # Queue.full() 如果队列满了, 与 maxsize 大小对应，返回True,反之False 
    # Queue.get([block[, timeout]])获取队列元素，默认block=True, timeout=None, 就是说如果队列满了, 该元素进入等待, 直到队列有空出, 再插入元素. 如果设置了timeout, 元素# 等待timeout后, 队列中还没有空出, 程序会抛出一个异常.
    # Queue.get_nowait() 获取队列元素, 队列满了, 元素不等待, 程序直接报错
    # Queue.put(item) 插入队列元素, 类似与Queue.get()
    # Queue.put_nowait(item) 插入队列元素, 类似与Queue.get_nowait()
    # Queue.task_done() 在完成一项工作之后，Queue.task_done()函数向任务已经完成的队列发送一个信号
    # Queue.join() 实际上意味着等到队列为空，再执行别的操作

    # 管道: Pipe
    # Pipe方法返回(conn1, conn2)代表一个管道的两个端。Pipe方法有duplex参数，如果duplex参数为True(默认值)，那么这个管道是全双工模式，
    # 也就是说conn1和conn2均可收发。duplex为False，conn1只负责接受消息，conn2只负责发送消息。
    # send和recv方法分别是发送和接受消息的方法。例如，在全双工模式下，可以调用conn1.send发送消息，conn1.recv接收消息。
    # 如果没有消息可接收，recv方法会一直阻塞。如果管道已经被关闭，那么recv方法会抛出EOFError 
    import multiprocessing
    from multiprocessing.connection import Connection
    from typing import Tuple
    def send_task(pipe: Tuple[Connection, Connection]):
        for val in range(10):
            pipe[0].send(val)
            print(multiprocessing.current_process().name + "发送了 %d" % val)
        print(multiprocessing.current_process().name + "执行结束")

    def recv_task(pipe: Tuple[Connection, Connection]):
        while True:
            print(multiprocessing.current_process().name + "接收了 %d" % pipe[1].recv())

    if __name__ == '__main__':
        p = multiprocessing.Pipe()
        for val in range(3):
            multiprocessing.Process(target=send_task, args=(p,), name="p-send-" + str(val)).start()
        for val in range(1):
            multiprocessing.Process(target=recv_task, args=(p,), name="p-recv-" + str(val)).start()

    # 进程池: ProcessPoolExecutor(与ThreadPoolExecutor类似)
    ```

##### 8.3 多线程
- threading模块
    ```python
    # 多线程
    # threading模块
    # threading.currentThread(): 返回当前的线程变量。
    # threading.enumerate(): 返回一个包含正在运行的线程的list。正在运行指线程启动后、结束前，不包括启动前和终止后的线程。
    # threading.activeCount(): 返回正在运行的线程数量，与len(threading.enumerate())有相同的结果。
    # 除了使用方法外，线程模块同样提供了Thread类来处理线程，Thread类提供了以下方法:
    # run(): 用以表示线程活动的方法。
    # start():启动线程活动。
    # join([time]): 等待至线程中止。这阻塞调用线程直至线程的join() 方法被调用中止-正常退出或者抛出未处理的异常-或者是可选的超时发生。
    # isAlive(): 返回线程是否活动的。
    # getName(): 返回线程名。
    # setName(): 设置线程名
    # setDaemon(): 守护线程, daemon默认为False, 主线程等待其他线程运行结束再销毁; daemon默认为True, 主线程运行结束直接终止子线程.
    # 示例:
    def wait():
        time.sleep(2)
        print(threading.current_thread(), "运行结束!!!!")

    if __name__ == '__main__':
        t = threading.Thread(target=wait, args=(), name="thread-1")
        t.start()
    ```

- 线程同步
    ```python
    # threading.Lock: 互斥锁
    # acquire(): 获取锁
    # release(): 释放锁
    # 互斥锁的上下文:
    lock=threading.Lock()
    with lock:
        pass
    # 出现死锁的两种情况:
    # 1. 线程自己获得了lock1, 以为自己没有获取lock1, 又去获取锁1.
    # 2. 假如线程A需要先获取lock1再获取lock2, 线程B需要先获取锁lock2再获取lock1. 当线程A获取了lock1, 同时线程B获取了lock2时, 线程A去获取lock2, 
    # 但是lock2此时被线程B占据. 同时线程B去获取lock1, 但是lock1此时被线程A占据.
    # 递归锁: 对同一把锁有一个引用计数, 可以解决上面的死锁问题. 一般不是必要情况下, 不要使用互斥锁
    lock1=threading.Rlock()
    with lock1:
        pass

    # 信号量
    # 信号量与互斥锁之间的区别：
    # 互斥量值只能为0/1，信号量值可以为非负整数。也就是说，一个互斥量只能用于一个资源的互斥访问，它不能实现多个资源的多线程互斥问题。
    # 信号量可以实现多个共享资源的多线程互斥和同步。当信号量为单值信号量是，也可以完成一个资源的互斥访问。信号量是通过一个计数器控制对共享资源的访问，信号量的值是一个非负整数，所有通过它的线程都会将该整数减一。如果计数器大于0，则访问被允许，计数器减1；如果为0，则访问被禁止，所有试图通过它的线程都将处于等待状态
    sem=threading.BoundedSemaphore(value=3)
    sem.acquire()
    sem.release()
    # 使用上下文
    # with sem:
    #    pass

    # 事件: threading.Event()
    # 通过Event的标志位来实现两个或多个线程间的交互, 以下四个是常用方法, 都是原子性操作:
    event.set()  # 设置标志位为 True
    event.clear()  # 清空标志位(将标志位改为false)
    event.is_set()  # 检测标志位，如果标志位被设置，返回True，否则返回False
    # 等待标志位被设置为True, 程序才继续往下运行; 另外, 可以设置timeout(超时时间), 默认为None.
    # wait()方法是通过同一个线程第二次获得同一把锁(此时线程会陷入死锁), 来主动实现线程的阻塞; 
    # 当另一个线程设置标志位flag为True时, 会调用notify_all()解除所有阻塞线程的阻塞状态. 其实, 
    # 它是通过释放所有阻塞线程的同一把锁,来解除死锁状态, 进而解锁阻塞状态, 使线程继续运行.
    event.wait()  
    ```

- 队列
    ```python
    # 单向队列: Python 的 Queue 模块中提供了同步的、线程安全的队列类，包括FIFO（先入先出)队列Queue，LIFO（后入先出）队列LifoQueue，和优先级队列 PriorityQueue。
    # 这些队列都实现了锁原语，能够在多线程中直接使用，可以使用队列来实现线程间的同步
    # Queue.qsize() 返回队列的大小
    # Queue.empty() 如果队列为空，返回True,反之False
    # Queue.full() 如果队列满了, 与 maxsize 大小对应，返回True,反之False 
    # Queue.get([block[, timeout]])获取队列元素，默认block=True, timeout=None, 就是说如果队列满了, 该元素进入等待, 直到队列有空出, 再插入元素. 如果设置了timeout, 元素# 等待timeout后, 队列中还没有空出, 程序会抛出一个异常.
    # Queue.get_nowait() 获取队列元素, 队列满了, 元素不等待, 程序直接报错
    # Queue.put(item) 插入队列元素, 类似与Queue.get()
    # Queue.put_nowait(item) 插入队列元素, 类似与Queue.get_nowait()
    # Queue.task_done() 在完成一项工作之后，Queue.task_done()函数向任务已经完成的队列发送一个信号
    # Queue.join() 实际上意味着等到队列为空，再执行别的操作

    # 生产者消费者模式
    import multiprocessing, queue, random, threading, time
    def product(q: queue.Queue, gl: dict):
        while True:
            item = random.randint(1, 10000)
            q.put(item)
            with gl["s_lock"]:
                gl["p_sum"] += 1  # 生产计数
            time.sleep(0.001)

    def consume(q: queue.Queue):
        while True:
            q.get()
            time.sleep(0.001)

    def summary(q: queue.Queue, p_name: str, gl: dict):
        """
        统计生产情况
        """
        last_p_sum = 0
        t = time.time() + 1
        while True:
            local_time = time.time()
            if local_time >= t:
                t = local_time + 1
                t_format = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(local_time))
                p_sum01 = gl["p_sum"]
                print(t_format + "\t进程名:" + p_name + "\t生产效率(个/s): %d, 总生产: %d, 通道中的线程数: %s, 活跃线程数: %d"
                    % (p_sum01 - last_p_sum, p_sum01, q.qsize(), threading.active_count()))
                last_p_sum = p_sum01

    def run(p_name: str):
        g_val = {
            "p_sum": 0,
            "s_lock": threading.Lock()
        }
        # 线程数
        t_count = 200
        q = queue.Queue(maxsize=int(t_count * 0.5))
        threading.Thread(target=summary, args=(q, p_name, g_val), name="summary_thread").start()
        for val in range(t_count):
            threading.Thread(target=product, args=(q, g_val), name="product" + str(val)).start()
            threading.Thread(target=consume, args=(q,), name="consume" + str(val)).start()

    if __name__ == '__main__':
        # 多进程多线程实现
        for val in range(2):
            name = "p" + str(val)
            p1 = multiprocessing.Process(target=run, args=(name,), name=name)
            p1.start()
    ```
    
- 线程池
    ```python
    import threading
    import time
    from concurrent.futures import ThreadPoolExecutor, Future

    def task(i: int):
        time.sleep(i)
        print(threading.current_thread().getName(), "完成了一个任务!!!")
        return i

    def result(f: Future):
        print("执行结果:", f.result(), threading.current_thread().getName())

    # 线程池: ThreadPoolExecutor(max_workers=2)
    # 如果max_workers=None(默认), 那么 max_workers = (os.cpu_count() or 1) * 5
    # 线程池的介绍: 在线程池中提交一个任务，线程池如果有空闲线程，则分配一个线程去执行，执行完毕后在将线程交还给线程池，
    # 如果没有空闲线程，则等待。注意在等待时，与主线程无关，主线程依然在继续执行。
    # submit(): 线程池中的一个线程获取一个任务(回调函数), 返回一个Future对象
    f_list = []
    pool = ThreadPoolExecutor(max_workers=2)
    for t in range(2):
        f = pool.submit(fn=task, i=t)
        f.add_done_callback(fn=result)  # 可以增加很多回调函数, 异步获取结果

    # map(): 线程池中的多个线程获取多个任务(回调函数), 可以设置超时时间timeout, 返回回调函数结果的迭代对象
    fs = pool.map(task, [1, 2, 3, 4, 5])
    for f in fs:  # 同步输出结果
        print(f)

    # shutdown(): 如果设置wait=True(默认), 程序会等待, 直到所有任务完成, 类似于Thread().join().
    # 如果设置wait=False, 程序不会等待, 直接执行.
    pool.shutdown()
    print("程序结束")

    # Future类: 异步执行的结果, 以下是常用的方法
    # result(): 获取线程执行任务的结果, 如果设置了超时时间timeout, 超时后收不到结果会报错; 如果没有设置超时时间, 程序陷入阻塞, 一直等待有结果返回.
    # done(): 判断线程执行任务是否完成.
    # add_done_callback(fn: Callable): 异步执行回调函数, 回调函数的入参必须是Future对象.
    ```

##### 8.4 协程
- yield实现的协程
    ```python
    import time
    from typing import Generator

    # yield实现的生产者消费者模式
    def product():
        for _ in range(1000000):
            item = random.randint(1, 100)
            print("生产了", item)
            c = yield item  # 类似于单向通道
            print("消耗了", c)


    def consume(g: Generator):
        # 启动生产器
        # 或者: item = g.next() 
        item = g.send(None)
        while True:
            try:
                item = g.send(item)
            except StopIteration:
                return

    if __name__ == '__main__':
        start = time.time()
        consume(product())
        print("总耗时: ", time.time() - start)
    ```

- asyncio协程
    ```python
    # async修饰的函数为一个生产协程的函数, coro= task()
    async def task():
        # await + 可等待对象(Task, 协程, Future), 它的作用是挂起对象, 把同步执行变成异步执行.
        await asyncio.sleep(1)
        print("任务执行完成!")


    async def main():
        tasks = [asyncio.ensure_future(task()) for _ in range(10)]
        # 等待任务完成
        done, pending = await asyncio.wait(tasks)
        print(len(done), len(pending))


    if __name__ == '__main__':
        asyncio.run(main())
    ```

#### 8. Web框架: Flask
##### 8.1 Flask的路由
- Flask的路由
    ```python
    # flask的请求参数与请求体
    # request.args
    # request.args就是获取请求链接中 ? 后面的所有参数；
    # 把所有参数转换成一个列表，列表里面的元素是一个元组，结构为：('id','1')；
    # 再转换成一个字典，还有编码等操作: `id = request.args.get('id')`
    # request.form
    # 原理跟request.args差不多，只是request.form的数据来源是form表单，其他操作基本一致
    # request.json
    # 要想获取request.json中的数据, 设置了Content-Type:application/json的Body数据
    # 只能通过request.json获取. request.json是把request.data的数据转换成JSON格式的数据
    # request.get_data()
    # request.get_data()的数据来源是请求参数属性Body
    # request.files
    # request.files接收的是form表单中<input type="file" name="file"/>传过过来的数据
    # url_for(函数名), 返回资源路径, 比如: url_for("hello") -> "/hello"

    # 获取请求其他参数
    print("请求方式: ", request.method)
    print("请求头: ", request.headers)
    print("请求url: ", request.url)
    ```

- 实现restful-api
    ```python
    import os
    from flask import Flask, jsonify, request, send_from_directory
    from werkzeug.utils import secure_filename
    app = Flask(__name__)

    # 使通过jsonify返回的中文显示正常，否则显示为ASCII码
    app.config["JSON_AS_ASCII"] = False
    app.config['UPLOAD_FOLDER'] = './upload'

    # 获取个人用户信息
    @app.route('/hello/<int:id>', methods=['GET'])
    def get_user(id: int):
        print("路径参数: id=", id)
        return jsonify({
            "code": 200,
            "msg": "查询个人用户信息成功!!!"
        })

    # 获取所有用户信息
    @app.route('/hello', methods=['GET'])
    def get_all_users():
        print("请求参数:", request.args)
        return jsonify({
            "code": 200,
            "msg": "查询所有用户信息成功!!!"
        })

    # 注册用户
    @app.route('/hello', methods=['POST'])
    def register_user():
        print("请求体: ", request.json)
        return jsonify({
            "code": 200,
            "msg": "注册用户成功!!!"
        })

    # 上传用户头像
    @app.route('/hello/<int:id>/upload', methods=['POST'])
    def upload_user_icon(id: int):
        print("请求路径: id=", id)
        for _, f in request.files.items():
            # 使用安全的文件名
            file_name = secure_filename(f.filename)
            if not os.path.exists(app.config['UPLOAD_FOLDER']):
                os.makedirs(app.config['UPLOAD_FOLDER'])
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], file_name))
        print("上传文件的信息: ", request.files)
        return jsonify({
            "code": 200,
            "msg": "上传用户头像成功!!!"
        })

    # 下载文件
    # 带文件夹的路径: /hello/download/123/Snipaste_2023-01-14_14-05-26.png
    @app.route('/hello/download/<path:name>', methods=['GET'])
    def download_files(name: str):
        return send_from_directory(app.config['UPLOAD_FOLDER'], name, as_attachment=True)

    # 修改用户信息
    @app.route('/hello/<int:id>', methods=['PUT'])
    def update_user(id: int):
        print("请求路径: id=", id)
        print("请求体: ", request.json)
        return jsonify({
            "code": 200,
            "msg": "修改用户信息成功!!!"
        })

    # 删除用户信息用户信息
    @app.route('/hello/<int:id>', methods=['DELETE'])
    def delete_user(id: int):
        print("请求路径: id=", id)
        return jsonify({
            "code": 200,
            "msg": "删除用户信息成功!!!"
        })

    if __name__ == '__main__':
        app.run(host="0.0.0.0", port=8080)
    ```

##### 8.2 数据库
- Flask-SQLAlchemy的配置
    ```python
    # 数据库引擎
    # MySQL:	mysql://username:password@hostname/database
    # Postgres:	postgresql://username:password@hostname/database
    # SQLite:	sqlite:///绝对路径, 比如: sqlite:////db/test.db
    # 安装Flask-SQLAlchemy插件: pip install flask-sqlalchemy 
    # 安装mysql驱动插件: pip install pymysql

    # mysql数据库连接示例
    from flask import Flask
    from flask_sqlalchemy import SQLAlchemy
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456@192.168.56.210/test'
    db = SQLAlchemy(app)

    # 检测数据是否连接成功
    with app.app_context():
        with db.engine.connect() as conn:
            # 执行原生SQL语句: conn.execute(text("{SQL语句}"))
            rs = conn.execute(text("show databases;"))
            print(rs.fetchall())
    ```

- 数据库的增删改查
    ```python
    from flask import Flask
    from flask_sqlalchemy import SQLAlchemy
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456@192.168.56.210/test'
    db = SQLAlchemy(app)
    
    #### 创建表
    #### 常用的字段类型
    # 类型名    python接收类型      mysql生成类型   说明
    # Integer   int                 int             整型
    # Float     float               float           浮点型. 可以指定总长度和小数点后位数, 比如: db.float(precision="10,2")
    # Numeric   float               decimal         浮点型. 可以指定总长度和小数点后位数, 比如: db.float(precision="10,2")
    # Boolean   bool                tinyint         整型, 只占1个字节
    # Text      str                 text            文本类型, 最大64KB
    # LongText  str                 longtext        文本类型, 最大4G
    # String    str                 varchar         变长字符串, 必须限定长度
    # Date      datetime.date       date            日期
    # DateTime  datetime.datetime   datetime        日期和时间
    # Time      datetime.time       time            时间

    ##### db.Column()
    # 选项名           说明
    # name             字段在数据库变种的名称. 如果没有设置, 则使用此属性名作为字段名称
    # primary_key      如果为True, 表示该字段为表的主键, 默认自增
    # autoincrement    如果为True, 数据自增
    # unique           如果为True, 代表这列设置唯一约束
    # nullable         如果为False, 代表这列设置非空约束
    # server_default   为这列设置默认值
    # index            如果为True, 为这列创建索引, 提高查询效率
    # comment          在创建表时的注释

    class User(db.Model):
        """创建用户表"""
        __tablename__ = 'blog_user'
        id = db.Column(db.Integer(), primary_key=True)
        username = db.Column(db.String(50), nullable=False)
        age = db.Column(db.Integer(), nullable=False, server_default="20")
        price = db.Column(db.Numeric("10,2"), nullable=False)
        description = db.Column(db.String(255), nullable=False)
        group_id = db.Column(db.String(20), nullable=False, comment="用户组ID")

    class UserGroup(db.Model):
        """创建用户组"""
        __tablename__ = 'blog_group'
        id = db.Column(db.Integer(), primary_key=True)
        group_name = db.Column(db.String(20), server_default="小学组", unique=True, nullable=False, comment="用户组名")

    if __name__ == '__main__':
        with app.app_context():
            # 如果存在表就删除, 再重新创建表
            db.drop_all()
            db.create_all()

    # 插入数据


    ```
