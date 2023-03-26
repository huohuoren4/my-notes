## Shell
#### 1. shell常用指令
##### 1.1 目录常用命令
- 指令: `ls, cd, pwd, mkdir, rmdir, cp, rm, mv`
  - `ls -alh`  ***-h 磁盘大小信息可读***
  - `mkdir -p ./test/test1` ***-p 递归创建文件夹***
  - `rm -rf ` ***-rf 强制递归删除文件及文件夹***

##### 1.2 文件内容查看：
- 指令: `cat, more, head, tail -10f, find, awk, sed, last`  `ln -s oldfile newfile, wc, cut -c 1-12，tee , history` 
  - `last -n 5`  ***查看登陆Linux的最后5次记录***
  - `find . -name *.sh`  ***查找目录下的文件***
  - `awk [选项] '正则表达式{执行命令}' 文件名` ***文本处理工具(打印栏)***
    - `awk '/^$/ {print "Blank line"}' test.txt`
    - `awk '{print $1}' data2.txt` 
        - `$0` ***代表整个文本行***
        - `$1` ***代表文本行中的第 1 个数据字段***
        - `$n` ***代表文本行中的第 n 个数据字段***
    - `awk '/^$/ {print "Blank line"}' test.txt`
    - `awk -F ':' '/^$/ {print "Blank line"}' test.txt` ***默认用空白分割，这里改成':'***

  - `sed [选项] '正则表达式{执行命令}' 文件名` ***文本处理工具***
      - `sed '1a#!/bin/bash' test.sh` ***向第一行后面添加 hello，1表示行号, a表示追加, i-插入, d-删除, s-替换, p-打印***
      - `sed -i 's/22/goto/g' test.txt ` ***将22替换成goto, -i 修改原来的文件***
      - `sed -i '/22/d' test.txt ` ***删除文件中包含22的行***
      - `sed '/22/p' test.txt ` ***打印匹配22的行***
    
  - `wc [选项] 文件` ***统计指定文件中的字节数、字数、行数: -c 统计字数, -l 统计行数***
  - `echo "1,23 ,45,56" | cut -d ',' -f2` ***截取23***
    - `echo "1,23 ,45,56" | cut -c 1-6` ***截取第1-6个字符: '1,23 ,'***

  - `cat 文件名`  ***多行输入***
    ```shell
    cat > compose_install.sh <<EOF
    sudo chmod 755 /usr/local/bin/docker-compose
    # 创建软连接
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    EOF
    ```

##### 1.3 文件常见
- 指令: `touch, chmod, chown, source/. 文件名, env, export DATA=`
  - `chmod -R 777 test ` ***-R 递归修改文件及文件夹的读写***
  - `chown -R www:www test ` ***-R 递归修改文件及文件夹的使用者***
  - 文件详解
    ```shell
    # ls -al
    # ---
    # -rw-r--r--  1 tom  tom   193 Apr  1  2020 .bash_profile
    # ---
    # 文件符号:文件所有者:所有者所属组:其他用户
    # `rwx -> 421`
    # 一般用户创建文件的权限为: `rw-rw-rw-`, 创建文件夹的权限: `drwxrwxrwx`
    # umask: 去除用户的权限, `centos`中普通用户的umask: `0002`, root用户的umask: `0022`
    # 普通用户(centos) -> 创建文件的权限为: `-rw-rw-r--`, 创建文件夹的权限: `drwxrwxr-x`
    # root用户(centos) -> 创建文件的权限为: `-rw-r--r--`, 创建文件夹的权限: `drwxr-xr-x`
    ```

##### 1.4 用户与组
-  指令: `useradd, userdel, usermod, passwd, groupadd, groupdel, groupmod, passwd 用户名, su 用户名`  `sudo ./test.sh, id tom01, `
   - 创建用户命令格式: `sudo useradd -m 用户名` , 默认会创建一个同名的用户组,`/home`中创建一个用户名文件夹, `-m` 等于 `--create-home`
   - 删除用户使用 `sudo userdel -r 用户名` ，默认会删除同名的用户组及用户名文件夹, `-r` 等于 `--remove`
   - 用户与组详解
        ```shell
        # 用户与组
        # cat /etc/passwd
        # ---
        # ief:x:1000:1000::/home/ief:/usr/sbin/nologin  # 无法登录
        # tom:x:1001:1001::/home/tom:/bin/bash # 通过bash登录
        # ---
        # 用户名:密码(放在`/etc/shadow`):用户id:组id:用户描述:用户家目录:通过什么登录
        ```

##### 1.5 打包和解压
- 指令: `tar -r -zcvf 压缩包名 文件列表, tar -zxvf, zip -r , unzip`

##### 1.6 系统指令相关
- 指令: `which, whereis, man, uname -a, xargs, nohup, sh -c ,exec`
  - 所有数据一行显示: `df -h / | xargs` 
  - shell指令后台运行不停止: `nohup sh test.sh &` 
  - 解决无root权限的问题: `/bin/sh -c 'exec echo "hello" > /root/1.txt'` , 系统里面没有sudo指令
  - 内部命令,不需要产生另外的shell终端, 只在当前终端执行: `source, exec`, `exec echo "hello"`
        
##### 1.7 安装与卸载
- 指令: `yum, apt, make, make install, wget, curl, ssh, scp`
  - `yum install -y tree` ***-y 默认选择yes选项***
    - `yum list | grep xxx` ***查看软件列表*** 
  - `yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh ed8484bec` ***宝塔安装脚本: wget -O 文件名 重命名文件***
  - `curl`用来请求 Web 服务器的用法
      - 查看响应信息
        - 查看响应头：`curl -I https://proxy.mimvp.com`
        - 查看响应体：`curl https://proxy.mimvp.com`
      - 模仿`get, post, put, delet`请求
          - get请求：`curl "https://proxy.mimvp.com/freesecret.php?proxy=in_hp&sort=&page=5"`
          - post请求：`curl -d 'post_data=i_love_mimvp.com' https://proxy.mimvp.com/ip.php` 或者  `curl -X POST -H "Content-Type:application/json" -d '{"post_data":"i_live_mimvp.com"}' 'https://proxy.mimvp.com/ip.php'`
            - 文件上传：`curl -F 'csl=@/home/xxxx/xxx.csl' -F 'tag=xxx' -F 'category=full' "https://proxy.mimvp.com/demo/"`

  - `ssh  root@192.168.0.39` ***SSH 登录远程服务器***
  - 本地与服务器的文件传输
    - 本地终端使用`scp -r root@192.168.0.39:服务器文件/目录 本地文件目录 ` ***-r:递归拷贝, 服务器文件远程拷贝到本地***
    - 本地终端使用`scp -r 本地文件目录 root@192.168.0.39:服务器目录 ` ***-r:递归拷贝, 本地文件远程拷贝到服务器***
  - Centos7 的防火墙
    - 开机自启动防火墙: `systemctl enable/start/stop/disable/status firewalld`
    - 查看已打开的端口: `firewall-cmd --list-ports`
    - 打开端口: `firewall-cmd --permanent --zone=public --add-port=8080/tcp`, 其中permanent表示永久生效，public表示作用域，8080/tcp表示端口和类型
    - 关闭端口: `firewall-cmd --permanent --zone=public --remove-port=8080/tcp`

##### 1.8 系统资源查看
- 指令: `top, ps -aux, du, df, free -h, iostat, netstat, telnet`  `ip addr`
  - 系统信息
    - `cat /proc/version` ***查看系统信息***
    - `uname -a` ***查看内核信息***

  - 网络
    - `telnet 159.75.244.161` ***用于远程登陆 需要安装telnet-server***
    - `netstat -tlunp | grep 22` ***查看某个端口是否可访问( -p 进程PID/名字)***
      - Centos安装 netstat 指令: `yum install net-tools -y`
    - `cat /proc/net/dev`: ***查看网卡的收发包数量(bytes), 使用`ifconfig`也可以查看***

  - 磁盘
    - `du -sh ./test` ***显示目录test的总容量(以可读单位显示：K, M, G )***
    - `df -h` ***查看磁盘分区的使用情况***

  - CPU
    - `top -u www` ***显示www的进程***
        ```shell
        # top指令详解
        # l,t,m,P,M -- 开关: 'l' 系统负载; 't' task/cpu状态; 'm' 内存信息; P 进程按CPU排序, M 进程按内存排序
        # 0,1,2,3 -- 开关: '0' ; '1/2/3' 多个CPU的展示效果
        # load average: 5.44, 6.00, 6.10 -- 系统1分钟、5分钟、15分钟的CPU负载信息, 使用`uptime`也可以查看
        # M 根据驻留内存大小进行排序。
        # P 根据CPU使用百分比大小进行排序。
        # T 根据时间/累计时间进行排序。
        # q 退出程序。
        # l 切换显示平均负载和启动时间信息。
        # m 切换显示内存信息。
        # t 切换显示进程和CPU状态信息。
        # c 切换显示命令名称和完整命令行
        ```
        
    - `cat /proc/cpuinfo` ***查看CPU文件**
      - `cat /proc/cpuinfo | grep "physical id" | uniq | wc -l` ***查看机器一共几个cpu***
      - `cat /proc/cpuinfo | grep "cpu cores" | uniq` ***查看单个cpu的物理核数***
      - `cat /proc/cpuinfo | grep "processor" |wc -l` ***查看总逻辑核数***
      - 补充
        - 1.物理cpu数：主板上实际插入的cpu数量，可以数不重复的 physical id 有几个（physical id）
        - 2.cpu核数：单块CPU上面能处理数据的芯片组的数量，如双核、四核等 （cpu cores）
        - 3.逻辑cpu数：一般情况下，逻辑cpu=物理CPU个数×每颗核数

  - 内存
    - `free -h` ***查看内存信息***
    - `cat /proc/meminfo` ***查看内存文件**

  - 开关机: `shutdown -h now ,reboot`
  - 定时器: `crontab`
      - `ls -al /etc | grep cron` ***查看定时器相关目录 cron.daily, cron.hourly***
      - `crontab` 指令: `crontab -e`格式
          ```shell
          # Example of job definition:
          # .---------------- minute (0 - 59)
          # |  .------------- hour (0 - 23)
          # |  |  .---------- day of month (1 - 31)
          # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
          # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
          # |  |  |  |  |
          # *  *  *  *  * user-name  command to be executed
          ```

  - 日期时间`date, sleep 1s`
    - `date +%Y%m%d%H%M%S%N`  ***日期格式: 20140827093259000000000***
    - `date +"%Y-%m-%d %H:%M:%S"`  ***日期格式: 2014-08-27 09:32:59***
    - `date +%s`  ***获取绝对秒数（UTC）***
    - `date -s '2012-12-12 10:00:00'`  ***修改服务器时间：2012-12-12 10:00:00***
    - `timedatectl set-timezone Asia/Shanghai`  ***设置时区为: 中国上海***
    - 服务器时间同步:
      - `ntpdate ntp.api.bz`  ***手动同步服务器时间***
      - 自动同步服务器时间
        - 安装ntp和设置开机启动: `yum install -y ntp && systemctl enable ntpd --now`

##### 1.9 命令详解
- ps命令详解
    ```shell
    # ps命令详解
    # 进程的状态：
    # D 不间断睡眠（通常是IO）
    # R 正在运行或可运行（在运行队列上）
    # S 可中断睡眠（等待事件完成）
    # T 被作业控制信号停止, 即挂起进程
    # t 在跟踪期间被调试器停止
    # W 分页（自2.6.xx内核以来无效）
    # X dead（进程不可见）
    # Z 已失效（“僵尸”）进程，终止但未被其父进程处理

    # 对于BSD格式和使用stat关键字时，可能会显示其他字符：
    # < 高优先级（对其他用户不好）
    # N 低优先级（对其他用户很好）
    # L 将页面锁定在内存中（用于实时和自定义IO）
    # s 主进程
    # l 是多线程的, 可以理解为子进程（使用克隆_THREAD，就像NPTL p线程一样）
    # + 在前台进程组中
    ```

- free命令详解
    ```shell
    free -h
    #      total    used    free    shared   buff/cache  available
    # Mem:  3.7G     361M    1.4G     8.7M      2.0G       3.1G
    # Swap: 3.9G     0B      3.9G
    # 内存的使用率: (total - available)/total * 100%
    # total: 物理内存总量,对应 /proc/meminfo 的 MemTotal 字段, total= used + free + buff/cache
    # free: 空闲内存量,对应 /proc/meminfo 的 MemFree 字段
    # buffers: 内核缓冲区,对应 /proc/meminfo 的 Buffers 字段
    # cached:  文件缓冲页,对应 /proc/meminfo 的 Cached 字段
    # slab:  内核 slab 数据结构,对应 /proc/meminfo 的 Slab 字段
    # cache: cache= cached + slab
    # g_free: 广义空闲内存, g_free= free + buffers + cache, buffers 和 cache 是系统为了提升性能而使用的缓存，内存紧张时可随时回收另做它用。因此，这部分内存在某种意义上可以认为是空闲的，这就是 广义空闲内存 的由来
    # used:  已用内存
    # share: 多个进程共享的内存总额
    # available: 可用内存 指的是可用于启动一个新应用进程的内存，该指标是内核提供的一个估计值。它同样结合 free 以及 cache 两部分内存，但是考虑到 cache 因使用而不能释放的情况。因此，可以认为：free <= available <= g_free
    # swap: 可交换内存, 用作虚拟内存的硬盘部分.
    ```

#### 2. shell脚本
##### 2.1 变量 
- 变量声明 `num=10; num1=20`  ***等号左右不能有空格*** 
- 变量的使用 `$num`
- 变量的删除 `unset num` 
- 变量的类型：局部变量，环境变量，shell变量  
- 变量是否存在: `${str:-val}` ***如果str存在, 整个表达式的值为num, 否则为val***

##### 2.2 字符串
- 字符串中的单引号（单引号会原样输出,其中不能出现单引号）
- 双引号（可以有变量，可以出现转义字符）
- 字符串的拼接 `"wewew""1244"`
- 字符串的长度 `${#string}`
- 字符串的切片 `${string:1:4}`
- 字符串的替换 
    - `${string/old/new}` ==> `${str/:/#}` ***字符串中第一个 : 替换成 #***
    - `${string//old/new}` ==> `${str//:/#}` ***字符串中所有 : 替换成 #***
- 字符串截取(支持的通配符号: `*, ?`)
    - `echo ${str#*/}` ***#、## 表示从左边开始删除。#为最小匹配, ##为最大匹配(贪婪模式)***
    - `str=test.txt; echo ${str%.*} # 去后缀名: test` ***%、%% 表示从右边开始删除。%为最小匹配, %%为最大匹配(贪婪模式)***

##### 2.3 数组
- 定义数组 `arr=(a b c)`, `Bash`也支持关联数组，可以使用任意的字符串或者整数作为下标来访问数组元素(**关联数组的键是唯一的**)
    ```shell
    # 声明加初始化
    declare -A site=(["google"]="www.google.com" ["runoob"]="www.runoob.com" ["taobao"]="www.taobao.com")
    # 先声明, 再赋值
    declare -A site
    site["google"]="www.google.com"
    site["runoob"]="www.runoob.com"
    site["taobao"]="www.taobao.com"
    ```

- 获取数组的元素(下标读取) `${arr[1]}`, `i=2; ${arr[i]}`, 获取数组的键`${!arr[*]}`
- 数组的长度 `${#arr[*]}`
- 数组的遍历
    ```shell
    # 字符串转化成数组
    tags1=($(docker images | awk '/ago/{print $1 }' | xargs))
    tags2=($(docker images | awk '/ago/{print $2 }' | xargs))
    len=${#tags1[*]}

    # 数组遍历 01
    for ((i=0;i<len;i++)); do
        echo ${tags1[i]}":"${tags2[i]}
    done
    ```

##### 2.4 输入输出
- `echo -e "woewoe\n"` ***转义双引号字符串***
- `printf` 格式化输出: `printf "%d %s %c %.3f\n" 10 "abc" "def" "3.1415926"`  ***结果 --> 10 wewe 1 3.145***
- 执行指令（`ls` 或者 `$(ls)`）
- `read` 命令用于获取键盘输入信息： `read -p "input a val:" a`
- `!!` ***(代表上一条输入的命令，可以和其他命令组合起来构成新的命令)***

##### 2.5 传递参数
- 参数的传递详解
    ```shell
    # $0:程序执行的脚本
    # $n:传递到脚本或函数的参数, 如果不存在就为空(""), 比如$1, $2
    # 注意: $10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数

    # $#:传递到脚本或函数的参数个数
    # $*:以一个单字符串显示所有向脚本传递的参数
    # $$:脚本运行的当前进程ID号
    # $!:后台运行的最后一个进程的ID号
    # $@:与$*相同，但是使用时加引号，并在引号中返回每个参数。
    # $-:显示Shell使用的当前选项，与set命令功能相同。
    # $?:显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
    ```

##### 2.6 运算符
- `((a+b)), ((a+b, a++)), ss=$(( i*j ))或者(( ss=i*j ))`, `((...))`只能进行整数的运算, `>、<、>=、<=、==、!=, &&, ||, !`, 变量名不用加$, 比如`if ((a==b))`
  - 浮点数的运算: `a=10; b=3; echo "$a $b" | awk '{printf("%.2f", $1/$2)}'`

- `[[ "hello" == "hell?" ]] && echo "hello"`, `[[...]]`只能进行字符串的运算, 是`[...]`的扩充, 支持`>、<、==、!= 、&&、||, !`, 不支持`>=, <=`; **注意:** `[[...]]`两边要有空格, 比如`if [[ $a==$b ]]`
  - `$[]`也可以进行数字计算, 比如`$[a+b]`. `$[...]`两边不需要加空格

- 检查条件是否成立: `[ -e 文件名 ]/test -e 文件名`  ***`[...]`两边要有空格***
  - `[ -e 文件名 ]` ***文件是否存在***
  - `[ -d 文件名 ]` ***是否是目录***
  - `[ -f 文件名 ]` ***是否是文件***
  - `[ -r 文件名 ]` ***文件是否可读***
  - `[ -w 文件名 ]` ***文件是否可写***
  - `[ -x 文件名 ]` ***文件是否可执行***

- 检查字符串是否成立: `[...]` ***[...]两边要有空格***
  - `=, !=` ***字符串相等或者不相等, 相等是一个等号***
  - `[ -z 字符串 ]` ***检测字符串长度是否为0***
  - `[ -n 字符串 ]` ***检测字符串长度是否不为 0, 变量名或者字符串需要加双引号, 比如: [ -n "$a" ]***
  - `[ 字符串 ]` ***检测字符串是否不为空，不为空返回 true, 比如: [ $a ]***

##### 2.7 流程控制
- 条件循环语句
    ```shell
    # if-else-fi, 条件是true或者false
    if condition
    then
        command1
    elif
        command1
    else
        command3
    fi
    # 写成一行
    if condition; then command1; elif command1; else  command3; fi

    # case-esac
    case $aNum in
        1)  echo '你选择了 1'
        ;;
        1)  echo '你选择了 2'
        ;;
        *)  echo '你没有输入 1 到 4 之间的数字'
        ;;
    esac
    # 写成一行
    case $aNum in 1)  echo '你选择了 1';; 1)  echo '你选择了 2';; *)  echo '你没有输入 1 到 4 之间的数字' ;;esac
    ```	

- 循环语句 
    ```shell
    # 终止循环
    break
    continue

    # for 语句
    for ((i=0;i<10;i++))
    do
        command1
    done
    # 写成一行
    for ((i=0;i<10;i++)); do command1; done

    # for in 语句(items 为以空格进行分割的字符串)
    for i in $(seq 10)
    do
        command1
    done

    # while 语句
    while condition
    do 
        command
    done
    # 写成一行
    while condition;do command; done

    # until 语句
    until condition
    do 
        command
    done
    ```

##### 2.8 函数
- 函数定义
    ```shell
    # 全局变量
    a=2
    b=10
    # 函数名后面的`()`中不需要带传递参数
    # 先定义函数, 再调用, 所以函数需要写在最上面或者写入一个函数文件, 通过文件调用
    # [ -f ./func/xxx ] &&  . ./func/xxx || echo "加载函数文件 ./func/xxx 失败!!!" && exit 1
    function print(){
        # 在函数中, 局部变量会覆盖全局变量, 也可以直接调用全局变量
        # 在函数中, 变量未带`local`, 也是全局变量
        local a=1 # 局部变量
        c=30  # 全局变量
        echo "hello,world$a, $b"
        # 函数的退出状态码: return的返回值就是函数的退出状态码. 如果没有return 返回值, 以函数中最后一条指令执行的状态码为准
        # 函数的返回值可以使用: echo "123", 函数外部获取返回值: $(print $1)
        return 0
    }
    # 使用函数名调用函数, 在函数中也可以递归调用
    print 1 2 3 4 
    ```

- 函数示例
    ```shell
    #!/bin/bash
    # -*- coding:utf-8 -*-

    # 斐波那契数列
    function fab(){
        if (( $1 <= 1 )); then
            echo 1
            return
        fi
        # 递归调用
        echo $[$(fab $[$1-1]) + $(fab $[$1-2])]
        return
    }
    echo "fab="$(fab $1)
    ```

##### 2.9 文件相关
- 文件包含`. ./test.sh`
- 单行注释 `#`
- 多行注释
  ```shell
  :<<EOF
  echo -e "hello,world!"
  echo -e "hello,world!"
  EOF
  ```

- 随机数
  - `echo $RANDOM` ***RANDOM是shell内置的随机数***
  - `echo $[RANDOM %10]` ***产生0-9的随机数***
  - `echo -n $RANDOM | md5sum |cut -c 1-6` ***从md5加密字符串中产生随机字符第1到6位: echo -n 不输出换行符'\n'***
  - `seq 1000` ***生成1-1000的数组***

##### 2.10 shell的多线程
- 文件描述符
    ```shell
    # 文件描述符'File descriptor'是计算机的一个术语,是一个用于表述'指向文件的引用'的'抽象化'概念
    # 查看文件描述符: `ll /proc/$$/fd`
    # 系统自带的文件描述符: 0, 1, 2, 0-标准输入, 1-标准输出, 2-错误输出
    cat 1.txt > 2.txt 2>&1   # 错误信息输入到2.txt
    # exec指令是linux shell自带的指令,可以利用此指令'修改',保存'当前进程'的'文件描述符指向', 永久的重定向. 但是, cat 1.txt > 2.txt临时的重定向
    # 新建文件描述符
    exec N<> FILENAME
    # 关闭文件描述符: 下面这两种方法都可以关闭文件描述符
    exec N>&-
    exec N<&-
    # 文件描述符的'复制'语法
    [exec] [M]>&N   # "省略"M时,默认M=1,即标准输出
    [exec] [M]<&N   # "省略"M时,默认M=0,即标准输入
    # 备注："M"是'new'的文件描述符,"N"是'old'的文件描述符, 比如 exec 3<>3.txt; exec 2<>2.txt; exec 2 >&3, 
    # 结果就是: 2 -> 3.txt;  3 -> 3.txt
    # 文件描述符的'移动过程'：表示'先复制'源文件描述符,'再删除'源文件描述符
    [exec] [M]>&N-    # 省略M时，默认M=1
    [exec] [M]<&N-    # 省略M时，默认M=0
    # +++++++++++++++"等价效果"+++++++++++++++
    [exec] [M]>&N;N>&-    # 省略M时，默认M=1
    [exec] [M]<&N;N<&-    # 省略M时，默认M=0
    # 解读：先fd dup得到'fd=N的副本'fd=M,同时'关闭'fd=N. 比如 exec 3<>3.txt; exec 2 >&3-. 
    # 结果就是: 生成了 3 -> 3.txt, 删除了2 -> 3.txt
    # 示例:
    # cmd >&n  把输出送到文件描述符n -->前面'省略1'
    # cmd m>&n 把输出到文件符m的信息'重定向'到文件描述符n
    # cmd >&-  关闭标准输出
    # cmd <&n  输入来自文件描述符n
    # cmd m<&n m来自文件描述n
    # cmd <&-  '关闭'标准输入
    # cmd <&n- '移动'输入文件描述符n而非复制它.
    # cmd >&n- 移动输出文件描述符n而非复制它.
    ```

- 多线程的实现
    ```shell
    #!/bin/bash
    # -*- coding:utf-8 -*-

    # shell多线程
    # 方案一: 简单的多线程
    a=$(date +%s)
    for ((i=0;i< 100;i++)); do
        {
        echo "hello, world"
        sleep 3
        } &     # 将shell指令放在后台执行
    done
    wait
    b=$(date +%s)

    echo "总耗时:"$(( b - a ))"s"

    # 方案二: 线程池
    # 线程池中线程的数量
    nums=10
    a=$(date +%s)
    # 创建无名管道
    # 无名管道的特点: 管道里有数据才能读, 无数据才能写, 否者只能等待
    mkfifo filefifo
    # 创建文件描述符
    exec 4<>filefifo

    # 定义线程池中的线程数
    for ((i=0;i<nums;i++)); do
        echo >&4  # 写入空行
    done

    for ((i=0;i< 100;i++)); do
        read -u 4
        {
            echo "hello, world"$i
            sleep 3
            echo >&4
        } &
    done
    wait
    b=$(date +%s)
    echo "总耗时:"$[b-a]"s"
    # 释放管道
    exec 4>&-
    ```

#### 3. Vim 的常用快捷键
##### 3.1 底线模式
- `:w 文件名`  ***另存文件 但是不退出文件***
- `:wq`  ***保存并退出***
- `:q!`  ***强制退出***
- `:set nu`  ***加行号***
- `:! command`  ***暂时离开 vi 到指令行模式下执行 command 的显示结果***
- `/word`  ***向光标之下寻找一个名称为 word 的字符串***
- `:%s/word1/word2/g`  ***从第一行到最后一行寻找 word1 字符串，并将该字符串取代为 word2***

##### 3.2 命令模式
- `G`  ***移动到这个文件的最后一行***
- `gg`  ***移动到这个文件的第一行***
- `nG`  ***移动到这个文件的第n行***
- `ndd`  ***向下删除n行***
- `nyy`  ***向下复制n行***
- `np`  ***向下粘贴n次***
- `u`  ***撤销***
- `ctr+r` ***重做***
- `ctr+n` ***自动补全***

#### 4. Git 的常用操作
##### 4.1 了解 git 的四个区：
- 工作区：就是你在电脑里能看到的目录
- 暂存区：英文叫 `stage` 或 `index`。一般存放在 `.git` 目录下的 `index` 文件（`.git/index`）中，所以我们把暂存区有时也叫作索引（`index`）。
- 版本库：工作区有一个隐藏目录 `.git`，这个不算工作区，而是 `Git` 的版本库
- 远程服务器仓库，比如 `Gitee, Github`

##### 4.2 常用指令
- `git`中解决总是要输入账号密码的问题
  - `git config --list` ***有时候会看到重复的变量名，那就说明它们来自不同的配置文件（比如 `/etc/gitconfig` 和 `~/.gitconfig`），不过最终 `Git` 实际采用的是最后一个***
  - `git config --global credential.helper store` ***修改`~/.gitconfig`中的配置文件:credential.helper=store***
  - `git config --global user.email "674860357@qq.com"` ***修改`~/.gitconfig`中的配置文件:user.email=674860357@qq.com***
  - `git config --global user.name "tom01"` ***修改`~/.gitconfig`中的配置文件:user.name=tom01***
  - `git config --global http.proxy http://127.0.0.1:33210`  ***设置代理***

- 拉取与提交代码
  - `git pull, git clone https://gitee.com/shushuiren4/weixin.git , git push origin 本地分支:远程分支` ***从远程仓库拉取代码，从远程仓库克隆代码，将本地仓库的代码推送到远程服务器(注意: 本地分支与远程分支相同时可以省略远程分支)***
  - `git add ., git rm -rf filename, git commit -m "modified files"` ***将工作区的代码加入到暂存区，删除工作区的代码或者暂存区的代码，将暂存区的代码提交到本地仓库***
  - `git restore --staged filename` ***将暂存区中的filename回退到工作区***

- 回退版本
  - `git reset --soft 版本号 , git reset 版本号, git reset --hard 版本号"` ***把代码回退到暂存区（本地仓库是旧版本，工作区和暂存区是新版本），把代码回退到工作区（本地仓库和暂存区是旧版本，工作区是新版本）,本地的三个区都回退到旧版本***
  - `git push -f` ***回退版本后,进行强制提交***
  
- 代码冲突
  - 先找到冲突的文件，再查找冲突的代码，再删除相关代码，再提交到远程仓库
  - `git log, git status` ***查看代码的提交历史和版本号，查看代码的状态***
  - `git pull, git diff` ***拉取远程仓库的代码，默认自动融合工作区的本地代码，查看工作区与暂存区的文件区别***

- 分支管理
  - 创建分支: `git checkout -b 分支名` 等价于 `git branch -b 分支名 && git checkout 分支名 `
  - 切换分支: `git checkout 分支名`
  - 查看分支: `git branch -a` -- 查看所有分支包括远程分支, `git branch` -- 查看本地分支
  - 删除分支: `git branch -m 分支名`

- 忽略文件.gitignore
  - .gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的; 可以先删除这些文件和文件夹, 再commit和push, 重新生成此类文件和文件夹就会加入忽略规则

#### 5. 软件源码安装与卸载
##### 5.1 Centos
- yum 源替换
    ```shell
    # 替换 Centos7-yum
    wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo
    # 刷新缓存
    yum clean all && yum makecache
    # 常用依赖
    yum -y install wget  gcc make  net-tools git vim iotop tree ntp
    # 设置时区
    timedatectl set-timezone Asia/Shanghai
    # 设置时间自动同步
    yum install -y ntp && systemctl enable ntpd --now
    ```

- 升级linux内核
    ```shell
    # 升级yum
    yum -y update
    # 导入ELRepo仓库的公共密钥
    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    # 安装ELRepo仓库的yum源
    rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
    # 查询可用内核版本
    yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
    # 安装最新的稳定版本内核
    yum -y --enablerepo=elrepo-kernel install kernel-lt
    # 设置 grub2，即内核默认启动项
    # 查看系统上的所有可用内核
    sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
    # 编辑 /etc/default/grub 文件, GRUB_DEFAULT=0 即内核启动最新版本
    sed -i 's/GRUB_DEFAULT=saved/GRUB_DEFAULT=0/g' /etc/default/grub
    # 生成 grub 配置文件并重启
    grub2-mkconfig -o /boot/grub2/grub.cfg && reboot
    ```

- Virtualbox--Centos7.8 修改虚拟机固定ip
    ```shell
    # 使用双网卡
    # 1. Virtualbox菜单栏 > 管理 > 主机网络管理 > Virtualbox host-Only Ethernet Adapter > 网卡页签 > 单选手动 > IPv4地址: 192.168.56.1 (默认就好) 
    # 2. 设置 > 网络: 仅主机模式用于虚拟机和宿主机之间的网络通信, NAT用于虚拟机连接外网
    # 2.1 选择"网卡1"， 选择"连接方式" 为"仅主机（host-only）模式"
    # 2.2 选择"网卡2"， 选择 "连接方式" 为 "网络地址转换（NAT）"
    # 3. 进入虚拟机
    cd /etc/sysconfig/network-scripts/
    vi ifcfg-enp0s3    # 文件前缀类似, 依据实际的文件为准 
    # 修改项
    # BOOTPROTO="static"
    # IPADDR=192.168.56.201  # 参考步骤1中IPv4的地址设置ip
    # 重启网络服务
    systemctl restart network
    ```

- CentOS7.8 free命令参数详解
    ```shell
    free -h
    #      total    used    free    shared   buff/cache  available
    # Mem:  3.7G     361M    1.4G     8.7M      2.0G       3.1G
    # Swap: 3.9G     0B      3.9G
    # 内存的使用率: (total - available)/total
    # total: 物理内存总量,对应 /proc/meminfo 的 MemTotal 字段, total= used + free + buff/cache
    # free: 空闲内存量,对应 /proc/meminfo 的 MemFree 字段
    # buffers: 内核缓冲区,对应 /proc/meminfo 的 Buffers 字段
    # cached:  文件缓冲页,对应 /proc/meminfo 的 Cached 字段
    # slab:  内核 slab 数据结构,对应 /proc/meminfo 的 Slab 字段
    # cache: cache= cached + slab
    # g_free: 广义空闲内存, g_free= free + buffers + cache, buffers 和 cache 是系统为了提升性能而使用的缓存，内存紧张时可随时回收另做它用。因此，这部分内存在某种意义上可以认为是空闲的，这就是 广义空闲内存 的由来
    # used:  已用内存
    # share: 多个进程共享的内存总额
    # available: 可用内存 指的是可用于启动一个新应用进程的内存，该指标是内核提供的一个估计值。它同样结合 free 以及 cache 两部分内存，但是考虑到 cache 因使用而不能释放的情况。因此，可以认为：free <= available <= g_free
    # swap: 可交换内存, 用作虚拟内存的硬盘部分.
    ```

- SSH 使用密钥登录
    ```shell
    # ssh-keygen 生成ssh密钥
    # 主要参数介绍
    # -t 加/解密算法
    # -b 秘钥长度,rsa默认秘钥长度的为 2048
    # -C 注释，一般是填写用户名
    # -f 指定生成的秘钥文件名，如果不提供此参数则使用默认文件名，\
    # 如rsa私钥默认文件名 ~/.ssh/id_rsa ，公钥默认文件名 ~/.ssh/id_rsa.pub
    mkdir -p ~/.ssh &&  cd ~/.ssh  && ssh-keygen -t rsa
    # 把公钥加到authorized_keys（id_rsa根据取名略有不同，我这里用的是默认）
    # cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    # 也可以使用ssh-copy-id, ssh-copy-id 使用本地可用的密钥授权登录远程计算机。
    # ssh-copy-id 可以把本地主机的公钥复制到远程主机的 authorized_keys 文件上。
    # ssh-copy-id 也会给远程主机的~/.ssh 和 ~/.ssh/authorized_keys设置合适的权限。
    ssh-copy-id root@192.168.56.20
    # 打开密钥登陆功能（默认打开可以不设置）
    # vim /etc/ssh/sshd_config
    # ---
    # PubkeyAuthentication yes
    # ---
    # 重启ssh服务
    # 拷贝私钥到本地电脑
    systemctl restart sshd
    ```

##### 5.2 Ubuntu
- 环境的配置
    ```shell
    # 使用virtualbox安装Ubuntu20.04
    # 使用`win + 左键`可以拖动窗口
    # 配置固定ip, 使用双网卡
    # 1. Virtualbox菜单栏 > 管理 > 主机网络管理 > Virtualbox host-Only Ethernet Adapter \
    # > 网卡页签 > 单选手动 > IPv4地址: 192.168.56.1 (默认就好) 
    # 2. 设置 > 网络: 仅主机模式用于虚拟机和宿主机之间的网络通信, NAT用于虚拟机连接外网
    # 2.1 选择"网卡1"， 选择"连接方式" 为"仅主机（host-only）模式"
    # 2.2 选择"网卡2"， 选择 "连接方式" 为 "网络地址转换（NAT）"
    # 3. 进入虚拟机 > 网络 > 以太网(enp0s8, 设置主机模式的网卡) > ipv4 > ipv4方式: 自定义, \
    # 地址: 192.168.56.105; 255.255.255.0; 192.168.56.1
    # 注意: 如果主机与虚拟机无法相互ping通, 应该是开启了防火墙, 可以先关闭防火墙

    # 首次安装需要手动设置root用户密码
    sudo passwd root

    # 设置`apt`源为华为源
    # 1、备份配置文件
    sudo cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
    # 修改sources.list文件
    sudo sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
    sudo sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
    # 更新apt
    sudo apt-get update
    # 安装常用依赖
    sudo apt-get install wget  gcc make  net-tools git vim iotop tree

    # 安装ssh服务器端--sshd
    # 卸载原来安装好的openssh-client, 再安装openssh-server
    # sudo apt-get remove -y openssh-client
    # sudo apt-get install openssh-server
    # 关闭防火墙, 这样就可以实现主机和虚拟机的双向通信
    # sudo systemctl stop ufw
    # 查看22号端口是否起来, 再使用ssh工具连接虚拟机
    # sudo netstat -tlunp | grep 22 

    # 安装常用软件
    # 安装远程连接工具: xrdp, 对应的端口: 3389
    sudo apt install xrdp
    # 使用win10自带的远程连接工具连接Ubuntu. 如果出现黑屏, 请手动注销原先登录的账号, 再尝试重新连接
    # 安装.deb文件
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    # 安装pycharm, 解压安装包, 再执行shell指令不用使用sudo
    # cd pycharm-xxx/bin && ./pycharm.sh 
    # 安装chromedriver驱动
    # 设置环境变量 -> 安装
    echo 'export CHROMEDRIVERPATH=/home/tom01/Wangxi/packages/tools/google' >> ~/.bashrc
    source  ~/.bashrc
    sudo apt install chromium-chromedriver
    # 检验`chromedriver`. 如果已经进入`python virtualenv`, 先退出`deactivate`, 再重新进入`python virtualenv`
    # 如果看见`successful`, 说明安装成功了
    chromedriver
    # 安装allure
    # 注意: 默认Ubuntu20.04安装了allure
    unzip allure-xxx.zip
    # 设置软连接, 这样就可以使用allure指令了
    ln -s allure-xxx/bin/allure /usr/bin/allure
    ```

##### 5.3 Mysql
- mysql 的源码包安装
    ```shell
    #!/bin/bash
    # -*- coding:utf-8 -*-
    # @File: mysql5.7-install.sh
    # @Description: 
    # mysql5.7 的源码包安装
    # linux 版本: Centos7.8-x86_x64

    # 安装mysql 的依赖
    yum -y install ncurses vim wget ncurses-devel bison cmake gcc gcc libaio* net-tools

    # 下载安装包
    wget https://repo.huaweicloud.com/mysql/Downloads/MySQL-5.7/mysql-5.7.33-linux-glibc2.12-x86_64.tar.gz \
    -O /root/mysql-5.7.33.tar.gz

    # 解压安装包
    tar -zxvf /root/mysql-5.7.33.tar.gz -C /usr/local/
    mv /usr/local/mysql-5.7.33-linux-glibc2.12-x86_64/ /usr/local/mysql

    # 创建数据文件夹
    mkdir /usr/local/mysql/data
    mkdir /var/log/mysql

    # 创建用户
    useradd mysql
    # 修改权限
    chown -R mysql.mysql /usr/local/mysql
    
    # 安装
    /usr/local/mysql/bin/mysqld --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data --initialize > /root/mysql.log 2>&1
    password=$(tail /root/mysql.log | awk '/A temporary password is generated/{print $11}')

    # 修改配置文件
    cat <<EOF > /etc/my.cnf
    [mysqld]
    datadir=/usr/local/mysql/data
    basedir=/usr/local/mysql
    socket=/tmp/mysql.sock
    user=mysql
    port=3306
    character-set-server=utf8

    # 取消密码验证
    # skip-grant-tables

    # Disabling symbolic-links is recommended to prevent assorted security risks
    symbolic-links=0
    [mysqld_safe]
    log-error=/var/log/mysqld.log
    pid-file=/var/run/mysqld/mysqld.pid
    EOF

    # 添加快捷方式
    ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
    ln -s /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump
    
    # 将mysql加入服务
    cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
    
    # 开机自启
    chkconfig mysql on
    
    # 开启
    systemctl start mysql
    
    # 进入MySQL，设置密码
    echo -e "################################################ \n\
    # mysql 命令行中输入 \n\
    # 用户名: root; 密码: 123456 \n\
    # ALTER USER 'root'@'localhost' IDENTIFIED BY '123456'; \n\
    # GRANT ALL PRIVILEGES ON *.* TO root@\"%\" IDENTIFIED BY \"123456\" WITH GRANT OPTION; \n\
    # flush privileges; \n\
    # exit; \n\
    #################################################"

    /usr/local/mysql/bin/mysql -u root -p $password

    # mysql 不使用密码
    # sed -i 's/skip-grant-tables/# skip-grant-tables/g' /etc/my.cnf

    systemctl restart mysql
    # 开放 3306 端口
    firewall-cmd --permanent --zone=public --add-port=3306/tcp
    systemctl restart firewalld

    # 允许root用户在一个特定的IP进行远程登录，并具有所有库任何操作权限，具体操作如下：
    # GRANT ALL PRIVILEGES ON *.* TO root@"172.16.16.152" IDENTIFIED BY "123456" WITH GRANT OPTION;
    # 允许root用户在任何IP进行远程登录，并具有所有库任何操作权限，具体操作如下：
    # GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "123456" WITH GRANT OPTION;
    # 重载授权表：
    # FLUSH PRIVILEGES;
    # exit

    # 数据库备份
    mkdir -p /var/backup/mysql
    mysqldump -h 127.0.0.1 -uroot -p"123456" -R -E \
    --all-databases > /var/backup/mysql/back$(date +"%Y%m%d%H%M%S").sql

    # 安装包清理
    rm -rf /root/mysql-5.7.33.tar.gz /root/mysql.log

    echo ""
    mysql --version
    echo -e "\033[32mSuccess:mysql 安装成功 (^_^)\033[0m"
    echo ""
    ```

- mysql 5.7的卸载
    ```shell
    #!/bin/bash
    # -*- coding:utf-8 -*-
    # @File: mysql5.7-uninstall.sh
    # @Description: 
    # mysql5.7 的卸载
    # linux 版本: Centos7.8-x86_x64

    # 关闭 mysql 服务
    systemctl stop mysql
    # 删除安装文件夹及数据文件夹
    rm -rf $(whereis mysql) /var/log/mysql /var/backup/mysql
    # 删除用户
    userdel -r mysql
    # 清空配置文件
    cat /dev/null > /etc/my.cnf
    # 删除快捷方式
    rm -rf /usr/bin/mysql  /usr/bin/mysqldump
    # 删除 mysql 服务
    rm -rf /etc/init.d/mysql
    echo ""
    echo -e "\033[32mSuccess:mysql 卸载成功 (^_^)\033[0m"
    echo ""
    ```

##### 5.5 Redis
- redis 的安装
    ```shell
    #!/bin/bash
    # -*- coding:utf-8 -*-
    # @File: redis-install.sh
    # @Description: 
    # redis-6.2.7 的源码包安装
    # linux 版本: Centos7.8-x86_x64

    # 安装mysql 的依赖
    yum -y install gcc  wget vim  net-tools

    # 下载安装包
    wget https://repo.huaweicloud.com/redis/redis-6.2.7.tar.gz \
    -O /root/redis-6.2.7.tar.gz

    # 解压安装包
    tar -zxvf /root/redis-6.2.7.tar.gz -C /usr/local/
    cd /usr/local/redis-6.2.7

    # 编译安装redis
    make && make install PREFIX=/usr/local/redis

    # 增加 redis 的80端口
    firewall-cmd --permanent --zone=public --add-port=6379/tcp
    systemctl restart firewalld

    # 修改配置文件
    mkdir -p /usr/local/redis/conf /usr/local/redis/logs
    cp /usr/local/redis-6.2.7/redis.conf /usr/local/redis/conf
    sed -i 's/daemonize no/daemonize yes/g' /usr/local/redis/conf/redis.conf
    # 修改 redis 密码: 123456
    sed -i 's/# requirepass foobared/requirepass 123456/g' /usr/local/redis/conf/redis.conf
    # 修改 redis 日志文件路径
    sed -i 's/logfile ""/logfile "\/usr\/local\/redis\/logs\/redis.log"/g' /usr/local/redis/conf/redis.conf
    # redis 密码登录
    # redis -h 127.0.0.1 -p 6379 -a 123456

    # 添加开机服务
    touch /etc/systemd/system/redis.service
    cat <<EOF > /etc/systemd/system/redis.service
    [Unit]
    Description=redis-server
    After=network.target

    [Service]
    Type=forking
    ExecStart=/usr/local/redis/bin/redis-server /usr/local/redis/conf/redis.conf
    PrivateTmp=true

    [Install]
    WantedBy=multi-user.target
    EOF

    systemctl daemon-reload
    systemctl start redis.service

    # 创建redis的软链接
    ln -s /usr/local/redis/bin/redis-cli /usr/bin/redis

    # 安装包清理
    rm -rf /root/redis-6.2.7.tar.gz  /usr/local/redis-6.2.7

    echo ""
    redis -v
    echo -e "\033[32mSuccess: redis 安装成功 (^_^)\033[0m"
    echo ""
    ```

- redis 的卸载
    ```shell
    #!/bin/bash
    # -*- coding:utf-8 -*-
    # @File: redis-uninstall.sh
    # @Description: 
    # redis-6.2.7 的卸载
    # linux 版本: Centos7.8-x86_x64

    # 停止 redis 服务
    systemctl stop redis.service
    # 卸载安装文件夹
    rm -rf /usr/local/redis*
    # 卸载 redis 服务
    rm -rf /etc/systemd/system/redis.service
    # 删除redis的软链接
    rm -rf /usr/bin/redis

    echo ""
    echo -e "\033[32mSuccess: redis 卸载成功 (^_^)\033[0m"
    echo ""
    ```

#### 6. 常用的shell脚本
##### 6.1 脚本常用表情和常用颜色
- 成功: `:)`, `(^_^)`
- 失败: `:(`, `(~_~)`
- `echo -e "\033[字背景颜色;字体颜色m字符串\033[0m"` ***字体颜色: 31-red, 32-green, 33-yellow***

##### 6.2 脚本示例
- 批量更改当前目录中的文件后缀名
    ```shell
    #!/bin/bash
    read -p "input the old file:" old
    read -p "input the old file:" new
    [ -z $old ] || [ -z $new ] && echo "error" && exit
    for file in `ls  *.$old`;do
        if [ -f $file ];then
            newfile=${file%$old}   # 对文件去尾
            mv $file ${newfile}$new  # 文件重命名
        fi
    done
    ```  
