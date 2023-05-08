## Go 🎂🎉🌹
#### 1. Go语言
##### 1.1 Go 的安装与卸载
- window 环境下安装 Go
    - 到官网下载安装包, 直接安装
    - 环境变量的介绍
        ```shell
        # go 的安装目录
        GOROOT=D:\Go
        # `%GOROOT\bin% 到PATH中`

        # 更换 go 代理地址为golang中文社区: `go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct`
        ```
    - go 的常用指令
        ```shell
        # 编译
        go build  -o 编译的文件名  包的目录/go文件
        # 运行
        go run go文件
        # 查看环境变量
        go env

        # 创建项目
        go mod init 项目名
        # 整理依赖
        go mod tidy 
        # 添加依赖并下载(项目目录下)
        # 依赖默认会下载到`$GOPATH/pkg`
        go get
        # 安装依赖并生成可执行文件
        # 可执行文件安装在环境变量`GOBIN`的目录中, `GOBIN`未设置时候, 默认为`$GOPATH/bin`(如果`GOPATH`未设置, 默认就是`$HOME/go/bin`). $GOROOT中的可执行文件安装在`$GOROOT/bin`或`$GOTOOLDIR`，而不是`$GOBIN`
        # Go1.17版本以前使用go install
        go install -v github.com/Loyalsoldier/geoip@latest 
        # Go1.17版本以后使用go install
        go get -v github.com/Loyalsoldier/geoip@latest  
        ```

- linux 环境下安装 Go
    - Go 的安装
      ```shell
      #!/bin/bash
      # -*- coding:utf-8 -*-
      # @File: go-install.sh
      # @Description: 
      # Go-1.18.4 的安装
      # linux 版本: Centos7.8-x86_x64

      # 安装 go 的依赖
      yum -y install gcc  wget vim  net-tools

      # 下载 Go-1.18 安装包
      wget -O /root/go1.19.5.linux-amd64.tar.gz https://studygolang.com/dl/golang/go1.19.5.linux-amd64.tar.gz

      # 解压 Go-1.18 安装包
      tar -zxvf /root/go1.19.5.linux-amd64.tar.gz -C /root/
      mv /root/go /usr/local/

      # 配置Go 的环境变量
      echo 'export GOROOT=/usr/local/go
      export PATH=${PATH}:${GOROOT}/bin' >> $HOME/.bashrc

      # 环境变量生效
      . $HOME/.bashrc

      # 配置go env, 设置国内代理
      go env -w GO111MODULE=on
      go env -w GOPROXY=https://goproxy.cn,direct

      echo ""
      go version
      echo -e "\033[32mSuccess: Go 安装成功 (^_^)\033[0m"
      echo ""
      ```

    - Go 的卸载
      ```shell
      #!/bin/bash
      # -*- coding:utf-8 -*-
      # @File: go-install.sh
      # @Description: 
      # Go-1.18.4 的卸载
      # linux 版本: Centos7.8-x86_x64

      # 删除 Go 的安装包
      rm -rf /usr/local/go

      # 配置Go 的环境变量和 GO的华为源代理
      sed -i '/export GOROOT=\/usr\/local\/go/d' $HOME/.bashrc
      sed -i '/export PATH=\${PATH}:\${GOROOT}\/bin/d' $HOME/.bashrc

      # 环境变量生效
      . $HOME/.bashrc

      echo ""
      go version
      echo -e "\033[32mSuccess: Go 卸载成功 (^_^)\033[0m"
      echo ""
      ```

- 交叉编译
    ```go
    // Windows 下编译 Mac 和 Linux 64位可执行程序
    // GOOS: 目标平台的操作系统( darwin, freebsd, linux, windows )
    // GOARCH: 目标平台的体系架构( 386, amd64, arm )
    // 交叉编译不支持 CGO 所以要禁用它
    go env -w CGO_ENABLED=0
    go env -w GOOS=linux
    go env -w GOARCH=arm
    go build main.go

    // 恢复 Window 下编译
    go env -w CGO_ENABLED=1
    go env -w GOOS=windows
    go env -w GOARCH=amd64
    go build main.go
    ```

- golang镜像打包
    - golang-demo容器的go代码
        ```go
        package main
        import (
            "fmt"
            "io"
            "log"
            "math/rand"
            "net/http"
            "os"
            "path/filepath"
            "time"
        )
        var logger *log.Logger
        func init()  {
            file:="/var/golang-demo/log/test-app.log"
            err := os.MkdirAll(filepath.Dir(file), 0755)
            if err!=nil{
                log.Fatalln(err)
            }
            logFile, err01 := os.OpenFile(file, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
            if err01 != nil {
                log.Fatalln(err)
            }
            logger = log.New(logFile, "", log.Ldate | log.Ltime | log.Lmicroseconds)
        }

        // 增加memory 多少M, 持续一定时间
        func TestMem(mem int, duration int64) {
            s := make([][M]byte, mem)
            PrintLog("TestMem 开始增加内存...")
            for i := 0; i < mem; i++ {
                for j := 0; j < M; j++ {
                    s[i][j] = 'c'
                }
            }
            PrintLog("TestMem 增加内存结束...")
            time.Sleep(time.Second * time.Duration(duration))
            s[0][0]='a'
        }

        // CPU使用率xx%( 30% )持续一段时间
        func TestCpu(cupUsage int64, duration int64) {
            var t, t1 int64
            t = time.Now().Unix() + duration
            for {
                if time.Now().Unix() > t {
                    return
                }
                t1 = time.Now().UnixMilli() + cupUsage
                for {
                    if time.Now().UnixMilli() > t1 {
                        break
                    }
                }
                time.Sleep(time.Millisecond * time.Duration(100-cupUsage))
            }
        }

        //定义一个map来实现路由转发
        type MyHandler struct {
            Mux map[string]func(http.ResponseWriter, *http.Request)
        }

        func (handler *MyHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
            //实现路由的转发
            if h, ok := handler.Mux[r.URL.String()]; ok {
                //用这个handler实现路由转发，相应的路由调用相应func
                h(w, r)
                return
            }
            msg := fmt.Sprintf(`{
            "error": "请求地址不存在!!! 本镜像可访问路径: [ '/', '/foo' ], 可访问端口: [ '80', '8080' ], 容器日志目录: [ /var/golang-demo/log/ ]"
        }
        `)
            PrintLog(fmt.Sprintf("%v  %v  %v%v    %v", r.Method, http.StatusNotFound, r.Host, r.URL, r.Header))
            _, err := io.WriteString(w, msg)
            if err != nil {
                log.Fatal(err)
            }
        }

        func HomeHandler(response http.ResponseWriter, request *http.Request) {
            hostname, err := os.Hostname()
            if err != nil {
                log.Fatal(err)
            }
            s := `{
            "msg":"welcome to home page, 我是主机[ %v ]!!! 本镜像可访问路径: [ '/', '/foo' ], 可访问端口: [ '80', '8080' ], 容器日志可挂载目录: [ '/var/golang-demo/log/' ]", 
            "request_api":"%v %v%v",
            "request_header":"%v"
        }
        `
            PrintLog(fmt.Sprintf("%v  %v  %v%v    %v", request.Method, http.StatusOK, request.Host, request.URL, request.Header))
            json := fmt.Sprintf(s, hostname, request.Method, request.Host, request.URL, request.Header)
            _, err = response.Write([]byte(json))
            if err != nil {
                log.Fatal(err)
            }
        }

        func FooHandler(response http.ResponseWriter, request *http.Request) {
            hostname, err := os.Hostname()
            if err != nil {
                log.Fatal(err)
            }
            s := `{
            "msg":"welcome to foo page, 我是主机[ %v ]!!! 本镜像可访问路径: [ '/', '/foo' ], 可访问端口: [ '80', '8080' ], 容器日志可挂载目录: [ '/var/golang-demo/log/' ]", 
            "request_api":"%v %v%v",
            "request_header":"%v"
        }
        `
            PrintLog(fmt.Sprintf("%v  %v  %v%v    %v", request.Method, http.StatusOK, request.Host, request.URL, request.Header))
            json := fmt.Sprintf(s, hostname, request.Method, request.Host, request.URL, request.Header)
            _, err = response.Write([]byte(json))
            if err != nil {
                log.Fatal(err)
            }
        }

        // 自定义服务器
        func MyServer(port int) {
            handler := MyHandler{
                Mux: make(map[string]func(http.ResponseWriter, *http.Request)),
            }
            handler.Mux["/"] = HomeHandler
            handler.Mux["/foo"] = FooHandler
            addr := fmt.Sprintf("0.0.0.0:%v", port)
            server := http.Server{
                Addr:    addr,
                Handler: &handler,
            }
            PrintLog("服务器启动成功, 请访问 http://" + addr)
            err := server.ListenAndServe()
            if err != nil {
                log.Fatal(err)
            }
        }

        func PrintLog(msg string) {
            logger.Println(msg)
        }

        func FreeLog() {
            for {
                PrintLog("服务器运行正常, 日志正常写入!!!")
                time.Sleep(time.Second * 3)
            }
        }

        const M = 1 << 20
        func main() {
            PrintLog("程序运行开始...")
            rand.Seed(time.Now().UnixNano())
            go MyServer(8080)
            go MyServer(80)
            // 空闲日志, 每3秒写入一次
            go FreeLog()
            // CPU增加持续时长
            duration := int64(600)
            go func() {
                for {
                    cpuUsage := (rand.Int63n(7) + 2) * 10
                    PrintLog(fmt.Sprintf("容器cpu使用率: %v %%, 持续时间: %vs", cpuUsage, duration))
                    TestCpu(cpuUsage, duration)
                }
            }()

            var memUsage = 0
            for {
                memUsage = (rand.Intn(3) + 1) * 100
                PrintLog(fmt.Sprintf("容器内存增加: %v M, 持续时间: %vs", memUsage, duration))
                TestMem(memUsage, duration)
            }
        }

        ```
    - dockerfile文件, 放在项目的根目录中
        ```dockerfile
        FROM golang:1.19.5-alpine3.17 As buildStage
        WORKDIR /go/src
        COPY . /go/src
        RUN  go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct; \
             go mod tidy; \
             go build -o main
        
        FROM alpine:3.17
        WORKDIR /app
        COPY --from=buildStage /go/src/main /app/
        RUN mkdir -p /var/log/golang-demo
        EXPOSE 80
        EXPOSE 8080
        ENTRYPOINT ./main
        ```
    - 打包镜像: `docker build -t swr.cn-north-4.myhuaweicloud.com/wx-2022/golang-demo-x86_64:v1.1.8 .`
    - 运行并进入容器: `docker run --name golang-demo  --entrypoint '/bin/sh' -it 3b8faa9985a3`
    - 运行容器: `docker run --name test -v $PWD/log:/var/log/golang-demo -p 8080:8080 -d 容器镜像ID`
    
##### 1.2 Golang 的基本知识
- golang 基本知识
    ```go
    // 基本数据类型: int, string, float64, bool, byte
    // 派生数据类型: 
    // (a) 指针类型（Pointer）
    // (b) 数组类型
    // (c) 结构化类型(struct)
    // (d) Channel 类型
    // (e) 函数类型
    // (f) 切片类型
    // (g) 接口类型（interface）
    // (h) Map 类型
    // #######################################
    // 常量的定义: const PI float64= 3.14151926
    // 多常量:
    const (
        a = "abc"
        b = len(a)
        c = unsafe.Sizeof(a)
    )
    // iota，特殊常量，可以认为是一个可以被编译器修改的常量。
    // iota 在 const关键字出现时将被重置为 0(const 内部的第一行之前)，const 中每新增一行常量声明将使 iota 计数一次(iota 可理解为 const 语句块中的行索引)
    const (
        a = iota
        b = iota
        c = iota
    )
    // 字符串:
    // 单行字符串: "hello"
    // 多行字符串: `12121212
    // 121212121`

    // 条件语句
    switch a := 1; a {
	case 1:
		println(123)
		fallthrough  // 强制执行下一个条件
	case 2:
		println(12302)
	case 3:
		println(12303)
	default:
		println(3456)
	}
    // 判断接口的类型
	var t interface{}
	switch t.(type) {
	case nil:
		fmt.Println("nil")
	case int:
		fmt.Println("int")
	case bool:
		fmt.Println("bool")
	default:
		fmt.Println("unkonw type")
	}

    // select 条件语句
    // select 与 switch 原理很相似，但它的使用场景更特殊，学习了本篇文章，你需要知道如下几点区别:
    // select 只能用于 channel 的操作(写入/读出)，而 switch 则更通用一些
    // select 的 case 是随机的，而 switch 里的 case 是顺序执行
    // select 要注意避免出现死锁，同时也可以自行实现超时机制
    // select 里没有类似 switch 里的 fallthrough 的用法
    // select 不能像 switch 一样接函数或其他表达式
    c1 := make(chan int, 1)
	select {
	case msg1 := <-c1:
		fmt.Println("received", msg1)
	default:
		fmt.Println("No data received")
	}
    
    // 输入与输出
    // 格式化打印: fmt.Printf("%d, %.2f, %s, %T, %p", a, b, str, ss, w), %T -- 打印数据类型, %p -- 打印指针
    fmt.Println("\033[32m请输入一个整数:\033[0m")
	var num int
	fmt.Scanf("%d", &num)

    // 函数
    // 有名函数, 包中函数名第一个字母大写, 作用域 public; 函数名第一个字母小写, 作用域 private
    func max(a, b int) int {
        if a > b {
            return a
        }
        return b
    }
    // 匿名函数
    f := func(a, b int) int {
		return a + b
	}

    // 数组与切片
    // 数组: 具有固定长度, 值传递
	arr := [10]int{1, 2, 3}
	// 切片: 长度不固定, 引用传递
	arr01 := []int{1, 2, 3}
    arr02 := make([]int , 3, 5)
  
    // range
    // for 循环的 range 格式可以对 slice、map、数组、字符串等进行迭代循环
	for _, v := range s {
		fmt.Println(v)
	}
    
    ///////////////////////////////////////////////////
    // 集合的定义
	m := map[string]string{"name": "want", "age": "25"}
	fmt.Println(m)
	m2 := make(map[string]string)
	fmt.Println(m2)
    
    /////////////////////////////////////////////////
    // 结构体
    type Color struct {
        name   string
        type01 string
        color  string
    }
    func (c *Color) setName(name string) {
        c.name = name
    }
    func setName(c *Color, name string) {
        c.name = name
    }
    color := Color{"wang", "wew", "green"}
    fmt.Println(color)
    // 结构体的嵌套
    

    ///////////////////////////////////////////////
    // 接口
    type Fruit interface {
        getName() string
        setName(name string)
    }

    // 接口实现类 Apple
    type Apple struct {
        name string
    }

    func (a *Apple) getName() string {
        //TODO implement me
        return a.name
    }

    func (a *Apple) setName(name string) {
        //TODO implement me
        a.name = name
    }

    // golang 的并发
    // 我们只需要通过 go 关键字来开启 goroutine 即可
    go eat()
    // 通道（channel）是用来传递数据的一个数据结构, 带有缓冲区, 必须配合协程一起使用
    // 异步通道
    func sum(s []int, c chan int) {
        for _, v := range s {
            c <- v
            println("存入数据: ", v)
        }
        println("所有数字都放进缓存了")
        close(c)
    }

    func main() {
        arr := make([]int, 0, 10)
        arr = append(arr, 1, 2, 3, 10, 2, 30)
        ch := make(chan int, 3)
        go sum(arr, ch)
        for {
            data, ok := <-ch
            if ok == false {
                break
            }
            println("取出数据: ", data)
        }
    }

    //////////////////////////////////////////////////////
    // 错误机制
    // error类型是一个接口类型，这是它的定义：
    type error interface {
        Error() string
    }
    // errors.New("Error: 出错了"): error, 返回值为error 接口
    // panic 与 recover,一个用于主动抛出错误，一个用于捕获panic抛出的错误
    // 延迟函数: defer
    // 规则与约束
    // 1. 延迟函数的参数在defer语句出现时就已经确定
    // 2. 延迟函数执行按后进先出顺序执行， 即先出现的defer最后执行
    // 3. 延迟函数可能操作主函数的具名返回值, 只有引用类型才会影响函数的返回值
    type SumsungPhone struct {
	name string
    }
    func hello() *SumsungPhone {
        i := new(SumsungPhone)
        defer func() {
            fmt.Println("defer1=", i)
            i.name = "defer1"

        }()
        defer func() {
            fmt.Println("defer2=", i)
            i.name = "defer2"
        }()
        return i
    }
    func main() {
        fmt.Printf("hello(): %v\n", hello())
    }
    // 执行结果:
    // defer2= &{}
    // defer1= &{defer2}
    // hello(): &{defer1}

    // panic: 当程序发生panic时，程序会执行当前栈中的defer 函数列表
    // 引发panic有两种情况，一是程序主动调用，二是程序产生运行时错误，由运行时检测并退出, 特点:
    // 1、panic 在没有用 recover 前以及在 recover 捕获那一级函数栈，panic 之后的代码均不会执行；一旦被 recover 捕获后，外层的函数栈代码恢复正常，所有代码均会得到执行
    // 2、panic 后，不再执行后面的代码，立即按照逆序执行 defer，并逐级往外层函数栈扩散；defer 就类似 finally
    // 3、利用 recover 捕获 panic 时，defer 需要再 panic 之前声明，否则由于 panic 之后的代码得不到执行，因此也无法 recover
    // 主动抛出panic: panic("have a error")
    func createPanic() {
        fmt.Println("\033[32mpanic开始 (^_^)\033[0m")
        arr := []int{}
        fmt.Printf("arr[10]: %v\n", arr[10])
        fmt.Println("\033[32mpanic结束 (^_^)\033[0m")
    }
    func main() {
        defer func() {
            fmt.Println("\033[32mdefer开始 (^_^)\033[0m")
            if i := recover(); i != nil {
                fmt.Println("\033[32mpanic recover (^_^)\033[0m")
            }
            fmt.Println("\033[32mdefer结束 (^_^)\033[0m")
        }()
        createPanic()
    }
    // 执行结果:
    // panic开始 (^_^)
    // defer开始 (^_^)
    // panic recover (^_^)
    // defer结束 (^_^)
    ```

- golang 常用函数
    ```go
    // 字符串常用函数
    // 字符串的长度
    str= "你好, 世界"
    len(str)
    // golang的字符有两种:
    // 一种是 uint8 类型，或者叫 byte 型，代表了 ASCII 码的一个字符
    // 另一种是 rune 类型，代表一个 UTF-8 字符，当需要处理中文、日文或者其他复合字符时，则需要用到 rune 类型。rune 类型等价于 int32 类型
    // 处理遍历字符串乱码
    []rune(str)
    // 字符串转整数
    strconv.parseInt(str, 10, 0)
    // 整数转字符串
    strconv.FormatInt(123, 10)
    // 字符串转字节
	b := []byte("abc")
	fmt.Println(b)
	// 字节转字符串
	s := string(b)
	fmt.Println(s)
    // 字符串相加
    s1, s2 := "hello", "world"
    // fmt.Sprinf()
    fmt.Sprinf("%s%s", s1, s2)
    // strings.Builder
	b := new(strings.Builder)
	b.WriteString(s1)
	b.WriteString(s2)
	fmt.Printf("b.String(): %v\n", b.String())
    // 正则表达式
    regexp.MatchString("^.*?$", "wewoang123")

	s := "Hello, world"
	// 子串出现的次数
	count := strings.Count(s, "l")
	fmt.Println(count)
	// 子串出现的索引
	index := strings.Index(s, "ll")
	fmt.Println(index)
	// 字符串的替换
	replace := strings.Replace(s, "l", "9", -1)
	fmt.Println(replace)
	// 分割字符串
	split := strings.Split(s, ",")
	fmt.Println(split)
	// 连接字符串
	join := strings.Join(split, ",")
	fmt.Println(join)
	// 去除字符串两端的空白
	s2 := "\nhell\n"
	space := strings.TrimSpace(s2)
	fmt.Println(space)
	// 字符串转大写
	strings.ToLower(s)
	// 字符串转小写
	strings.ToUpper(s)

    ////////////////////////////////
    // 数组在golang中是值传递
    // 切片(slice)是对数组一个连续片段的引用，所以切片是一个引用类型. 切片的本质是一个由3部分构成的结构体，Pointer 是指向一个数组的指针，len 代表当前切片的长度，cap 是当前切片的容量, cap 总是大于等于 len 的. 通常我们在对 slice 进行 append 等操作时，可能会造成slice的自动扩容
    // 扩容的原则:
    // 1. 如果切片的容量小于1024个元素，那么扩容的时候slice的cap就乘以2；一旦元素个数超过1024个元素，增长因子就变成1.25，即每次增加原来容量的四分之一
    // 2. 如果扩容之后，还没有触及原数组的容量，那么，切片中的指针指向的位置，就还是原数组，如果扩容之后，超过了原数组的容量，那么，Go就会开辟一块新的内存，把原来的值拷贝过来，这种情况丝毫不会影响到原数组
    // 切片的常用函数
    arr := make([]int, 3, 5)
    // 数组的长度, 容量
    len(arr), cap(arr)
    
    // 追加元素元素
    // 切片进行append操作, 切片指向数组的地址发生改变, 可以通过数组的首地址`&slice[0]`判断. 
    append(arr, 10, 29)
    // 中间插入, "s[1:]...": 数组的拆包
    s01 := append(s[:1], append([]int{89}, s[1:]...)...)
    // 头部插入
    s = append([]int{60}, s...)

    // copy数组元素
    // func copy(dst, src []T) int copy 方法将类型为 T 的切片从源地址 src 拷贝到目标地址 dst，覆盖 dst 的相关元素，并且返回拷贝的元素个数。目标数组的地址不会发生改变, src的长度小于等于dst
    // 切片的赋值本质是传递数组的地址
    slice01=s

    // 集合的常用函数
	// 添加, 获取元素
	m2["name01"] = "wewe"
	m2["password"] = "12356"
	fmt.Println(m2)
	// 删除元素
	delete(m2, "name01")

    ////////////////////////////////////
    // 伪随机数
	rand.Seed(time.Now().UnixNano())
	fmt.Printf("rand.Intn(100): %v\n", rand.Intn(100))
    ```

##### 1.3 进阶知识
- 文件操作
    ```go
    // 读文件
    b, err := ioutil.ReadFile("./cross_compiling.bat")
    if err != nil {
        fmt.Printf("\033[31mError:读文件出错, %v\033[0m", err)
        return
    }
    fmt.Printf("b: %v\n", string(b))
    // 写文件
    content := `wewewe
    wewewew
    你好码`
    err2 := ioutil.WriteFile("./test.txt", []byte(content), 0755)
    if err2 != nil {
        fmt.Printf("%v\n", err2)
        return
    }

    // 获取文件及文件夹
    type FileInfo interface {
        Name() string       // base name of the file
        Size() int64        // length in bytes for regular files; system-dependent for others
        Mode() FileMode     // file mode bits
        ModTime() time.Time // modification time
        IsDir() bool        // abbreviation for Mode().IsDir()
        Sys() interface{}   // underlying data source (can return nil)
    }
    // 返回FileInfo
    ioutil.ReadDir(dirname) 
    // 文件或者文件夹的绝对路径, 会把路径中的"/", "\"转化成系统分隔符
    filepath.Abs(".")
    // 文件或者文件夹的父目录, 会把路径中的"/", "\"转化成系统分隔符
    filepath.Dir(".")
    // 系统分隔符
    string(filepath.Separator)
    // 判断文件是否存在
    os.IsExist(err)
    // 创建文件
    os.Create("./1.txt")
    // 删除文件及文件夹, 递归删除
    os.RemoveAll("./a/b/1.txt")

    ///////////////////////////////////////////////
    // 读配置文件
    import (
        "fmt"
        "github.com/spf13/viper"   // 支持`json，toml，ini，yaml，hcl，env`等格式的文件内容
        "path/filepath"
    )

    type YamlStruct struct {
        Name    string `yaml:"name" json:"name"`
        Age     int    `yaml:"age" json:"age"`
        Address string `yaml:"address" json:"address"`
    }

    /**
    读配置文件
    @filename: 文件名
    @filetype: 文件类型, json, yaml等类型
    */
    func ReadConfig(filename string) interface{} {
        ext := filepath.Ext(filename)[1:]
        viper.SetConfigType(ext)
        viper.SetConfigFile(filename)
        err := viper.ReadInConfig()
        if err != nil {
            fmt.Println(err.Error())
            return nil
        }
        var yaml YamlStruct
        err = viper.Unmarshal(&yaml)
        if err != nil {
            fmt.Println(err.Error())
            return nil
        }
        return yaml
    }

    func WriteConfig(filename string, content YamlStruct) {
        ext := filepath.Ext(filename)[1:]
        viper.SetConfigType(ext)
        viper.SetConfigFile(filename)
        viper.Set("name", content.Name)
        viper.Set("age", content.Age)
        viper.Set("address", content.Address)
        err := viper.WriteConfig()
        if err != nil {
            fmt.Println(err.Error())
            return
        }
    }

    func main() {
        ReadConfig("test.yaml")
        content :=YamlStruct{Name: "tom", Age: 456, Address: "中关村晓坪路1203路"}
        WriteConfig("test01.json", content)
    }
    ```

- 日志
    ```go
    // 系统自带的log包
    // log包中有3个系列的日志打印函数，分别print系列、panic系列、fatal系列
    // print、println、printf	单纯打印日志
    // panic、panicln、panicf	打印日志，抛出panic异常
    // fatal、fatalln、fatalf	打印日志，强制结束程序(os.Exit(1))，defer函数不会执行
    var logger *log.Logger
    func init()  {
        logFile, err := os.OpenFile("./c.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
        if err != nil {
            log.Panic("打开日志文件异常")
        }
        logger = log.New(logFile, "", log.Ldate | log.Ltime | log.Lmicroseconds | log.Llongfile)
    }
    func main() {
        logger.Println("成功!!!!")
        // 结果: 2023/01/09 01:33:35.764986 D:/My_Resp/Gitee/golang/go-demo/demo01/main.go:17: 成功!!!!
    }

    // logrus的使用
    import (
        "bytes"
        "fmt"
        "github.com/sirupsen/logrus"
        "log"
        "os"
        "path/filepath"
    )

    type MyFormatter struct {}
    func (m *MyFormatter) Format(entry *logrus.Entry) ([]byte, error){
        var b *bytes.Buffer
        if entry.Buffer != nil {
            b = entry.Buffer
        } else {
            b = &bytes.Buffer{}
        }

        timestamp := entry.Time.Format("2006-01-02 15:04:05.000000")
        var newLog string

        //HasCaller()为true才会有调用信息
        if entry.HasCaller() {
            fName := entry.Caller.File
            newLog = fmt.Sprintf("[%s] [%s] [%s:%d] %s\n",
                timestamp, entry.Level, fName, entry.Caller.Line, entry.Message)
        } else{
            newLog = fmt.Sprintf("[%s] [%s] %s\n", timestamp, entry.Level, entry.Message)
        }

        b.WriteString(newLog)
        return b.Bytes(), nil
    }

    var logger *logrus.Logger

    func init(){
        logger =logrus.New()
        filename:="logs/c.log"
        if err := os.MkdirAll(filepath.Dir(filename), 0755); err !=nil{
            log.Fatal(err)
        }
        file, err := os.OpenFile(filename, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
        if err !=nil{
            log.Fatal(err)
        }
        logger.Out= file
        logger.ReportCaller=true
        logger.Level=logrus.InfoLevel
        logger.Formatter=&MyFormatter{}
    }

    func main() {
        logger.Info("hello, world")
    }
    // 结果: [2023-01-09 01:30:29.401494] [info] [D:/My_Resp/Gitee/golang/go-demo/demo01/main.go:56] hello, world
    ```

- 系统
    ```go
    // 系统变量
    os.Environ()
    os.Getenv("LANG")
    // 系统命令执行的参数
    os.Args 
    // 执行系统指令
    import (
	"bytes"
	"fmt"
	"os/exec"
	"runtime"
	"strings"
    )

    // 输出命令的结果与错误信息
    func CmdOutput(cmd string) (string, string, error){
        var stdout, stderr bytes.Buffer
        var command *exec.Cmd
        if strings.HasPrefix(runtime.GOOS, "win") {
            command = exec.Command("cmd", "/c", cmd)
        }else{
            command = exec.Command("bash", "-c", cmd)
        }
        command.Stdout, command.Stderr = &stdout, &stderr
        err:= command.Run()
        return stdout.String(), stderr.String(), err
    }

    func main() {
        if stdout, stderr, err :=CmdOutput("dir"); err!=nil{
            fmt.Println(err.Error())
            fmt.Println(stderr)
            return
        }else{
            fmt.Println(stdout)
        }
    }
    ```

- 时间操作
    ```go
    // Go 语言提供了时间类型格式化函数 Format()，需要注意的是 Go 语言格式化时间模板不是常见的 Y-m-d H:i:s，而是 2006-01-02 15:04:05，也很好记忆(2006 1 2 3 4 5)
    // 时间戳转时间格式
    time_format := time.Unix(time.Now().Unix(), 0).Format("2006/01/02 15:04:05")
    fmt.Println(time_format)
    // 时间格式转时间戳
    t, err := time.Parse("2006/01/02 15:04:05", "2025/05/09 05:10:10")
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Printf("t.Unix(): %v\n", t.Unix())
    ```
    
- 反射与断言
    ```go
    // 反射
    import (
        "fmt"
        "reflect"
    )

    type Student struct {
        Name     string `json:"name"`
        password string
    }

    func (s Student) GetName(name string) string {
        return name
    }

    func (s Student) setName(name string){
        s.Name = name
    }

    func main() {
        var s Student
        t :=reflect.TypeOf(s)
        fmt.Println(t)    // main.Student
        v :=reflect.ValueOf(&s)
        // 获取值, 数据类型,数据类型种类(struct, ptr)
        fmt.Println(v, v.Type(), v.Kind())  // { } main.Student struct
        // 调用Elem()获取结构体的字段(包括私有字段), s必须是结构体指针
        fmt.Println(v.Elem().NumField())
        // 直接使用NumField()获取结构体的字段(包括私有字段), s不能是指针
        // fmt.Println(v.NumField())    // 2
        // 修改结果体的值, s必须是指针
        v.Elem().Field(0).SetString("123")
        fmt.Println(s)
        // 获取结构体的方法(不包括私有方法)
        fmt.Println(v.NumMethod())   // 1
        // 执行函数
        args:=[]reflect.Value{ reflect.ValueOf("wewewe") }
        v.Method(0).Call(args)
        // 获取标签
        tag := t.Field(0).Tag.Get("json")
        fmt.Println(tag)   // name
    }

    // 类型断言
    // 接口类型包括两部分: receiver和method table ptr
    // 类型（比如结构体）可以实现某个接口的方法集；这个实现可以描述为，该类型的变量上的每一个具体方法所组成的集合，包含了该接口的方法集。
    // 实现了 Namer 接口的类型的变量可以赋值给 ai（即 receiver 的值），方法表指针（method table ptr）就指向了当前的方法实现。
    // 当另一个实现了 Namer 接口的类型的变量被赋给 ai，receiver 的值和方法表指针也会相应改变, 所以接口是动态类型
    import (
        "fmt"
        "reflect"
    )

    type Peopler interface {
        GetName(string) string
    }

    type Student struct {
        Name     string `json:"name"`
        password string
    }

    func (s Student) GetName(name string) string {
        return name
    }

    func (s Student) setName(name string) {
        s.Name = name
    }

    func main() {
        // 类型隐式转换: 结构体转接口
        var p Peopler = Student{}
        // 接口转结构体
        if s, ok := p.(Student); ok {
            fmt.Println("接口转结构体, 类型转换成功")
            fmt.Println(s.GetName("12323")) // 123
        }

        // 判断一个值是否实现了某个接口
        var i interface{} = Student{}
        if s, ok := i.(Peopler); ok {
            fmt.Println("i 实现了Peopler接口")
            fmt.Println(s.GetName("12323")) // 1212
        }

        v := reflect.ValueOf(p)
        fmt.Println(v, v.Type(), v.Kind()) // { } main.Student struct
    }
    ```

- 协程
    ```go
    // 在golang中, 主协程结束会直接关闭子协程, 所以主协程通常需要加等待时间
    // 协程死锁, 程序执行会报错
    func Task(ch chan int) {
        <-ch
    }

    func main() {
        ch := make(chan int) // 无缓存通道
        ch <- 1
        go Task(ch)  // 造成死锁: 无缓存通道无法缓存数据
    }
    // 解决方案: 将子协程`go Task(ch)`写在`ch <- 1`的前面或者改成带缓存的通道

    ///////////////////////////////////////////////
    // 协程的通信与同步
    func Task(ch chan int) {
        ch <- 1
    }

    func main() {
        ch := make(chan int) 
        go Task(ch)  
        <- ch // 主线程中加入接收通道, 就可以实现协程同步

        // 这样可以判断通道是否关闭(关闭通道: Close(ch) ), 来实现线程的通信. 注意只有发送方才需要主动关闭通道, 接收方不需要
        // for{
        //     if item, ok:= <-ch; !ok{   
        //         break
        //     }else{
        //         fmt.Println(item)
        // }
        // }
        // 或者
        // for item:=range ch {   // 会自动检查通道是否关闭了
        //     fmt.Println(item)      
        // }
    }

    ///////////////////////////////////////////////
    // 协程相关
    // 操作系统, 操作系统平台: `runtime.GOOS`, `runtime.GOARCH`
    // 协程的主动切换: `runtime.GoSched()`
    // 生产者消费者模式
    package main
    import (
        "fmt"
        "math/rand"
        // "runtime"
        "time"
    )

    var counter int64
    func Produce(ch chan int, ch1 chan int) {
        rand.Seed(time.Now().UnixNano())
        for {
            item := rand.Intn(1000)
            ch <- item
            ch1 <- 1
            // time.Sleep(time.Millisecond)
        }
    }
    
    func Consume(ch chan int) {
        for {
            <-ch
            // time.Sleep(time.Millisecond)
        }
    }

    func Summary() {
        var c, now_t int64
        last_counter, t := int64(0), time.Now().Unix()+1
        for {
            if now_t = time.Now().Unix(); now_t >= t {
                time_format := time.Unix(time.Now().Unix(), 0).Format("2006/01/02 15:04:05")
                t = now_t + 1
                c = counter
                fmt.Printf("%s: 生产效率: %d/s, 生产总数: %d\n", time_format, c-last_counter, c)
                last_counter = c
            }
        }
    }

    func main() {
        // GMP模型中, G-Go协程, M-内核线程, P-逻辑处理器Processor, 默认为逻辑核心数:`runtime.NumCPU()`
        // runtime.GOMAXPROCS(2)  
        ch := make(chan int, 5)
        ch_result := make(chan int)
        go Summary()
        for j := 0; j < 10; j++ {
            go Produce(ch, ch_result)
            go Consume(ch)
        }
        for item := range ch_result {
            counter += int64(item)  // 通过通道实现数据同步
        }
    }

    // 协程池
    import (
	"fmt"
	"github.com/panjf2000/ants"
	"runtime"
	"sync"
	"time"
    )

    func worker()  {
        fmt.Println("I am working")
        time.Sleep(time.Second)
    }

    func main() {
        // 线程同步
        // 互斥锁
        // var mutex sync.Mutex
        // 加锁与解锁
	    // mutex.Lock(), mutex.Unlock()
        // 读写锁: 读时共享,写时独占
        // var rwMutex sync.RWMutex
        // 读写锁的读加锁与解锁
        // rwMutex.RLock(), rwMutex.RUnlock()
        // 读写锁的写加锁与解锁
        // rwMutex.Lock(), rwMutex.Unlock()
        
        tasks := 2
        // 等待组
        wg := &sync.WaitGroup{}
        workerFunc := func() {
            defer wg.Done()
            worker()
        }
        // 获取当前协程数: runtime.NumGoroutine()
        pool, err := ants.NewPool(100)
        if err != nil {
            fmt.Println(err.Error())
            return
        }
        for i := 0; i < tasks; i++ {
            wg.Add(1)
            err = pool.Submit(workerFunc)
            if err != nil {
                fmt.Println(err.Error())
                return
            }
        }
        // 阻塞主协程
        wg.Wait()
        pool.Release()
    }
    ```

- http请求 resful-api
    ```go
    package main
    import (
        "fmt"
        "github.com/parnurzeal/gorequest"
        "log"
    )

    var domain = "http://localhost:8080"
    // 打印请求信息
    func PrintRequest(req *gorequest.SuperAgent) {
        fmt.Printf("请求信息:\n请求的url: %v\n请求方法: %v\n请求头: %v\nContent-Type: %v\nraw数据: %v\n",
            req.Url, req.Method, req.Header, req.ForceType, req.RawString)
    }

    // 打印响应信息
    func PrintResponse(resp gorequest.Response, body string) {
        fmt.Printf("响应信息:\n响应的状态码: %v\n响应头: %v\n响应体: %v\n", resp.StatusCode, resp.Header, body)
    }

    // 获取用户列表
    func GetUserList() {
        req := gorequest.New().Get(domain + "/hello?name=123&password=12121")
        PrintRequest(req)
        resp, body, err := req.End()
        if err != nil {
            log.Fatal(err)
        }
        PrintResponse(resp, body)
    }

    // 获取用户详细信息
    func GetUserInfo() {
        req := gorequest.New().Get(domain + "/hello/1")
        PrintRequest(req)
        resp, body, err := req.End()
        if err != nil {
            log.Fatal(err)
        }
        PrintResponse(resp, body)
    }

    // 创建用户
    func PostUser() {
        reqBody := `{ "name": "123", "password": "123456" }`
        req := gorequest.New().Post( domain+ "/hello").Type("json").Send(reqBody)
        PrintRequest(req)
        resp, body, err := req.End()
        if err != nil {
            log.Fatal(err)
        }
        PrintResponse(resp, body)
    }

    // 上传用户头像
    func PostUserIcon() {
        filepath1 := "C:/Users/Administrator/Postman/file/Snipaste_2023-01-14_14-05-26.png"
        filepath2 := "C:/Users/Administrator/Postman/file/Snipaste_2023-01-14_14-05-26 - 副本.png"
        // 文件名不能是file
        req := gorequest.New().Post(domain + "/hello/1/upload").Type("multipart").
            Set("User-Agent", "golang").
            SendFile(filepath1, "", "image_file").
            SendFile(filepath2, "", "image_file001")
        PrintRequest(req)
        resp, body, err01 := req.End()
        if err01 != nil {
            log.Fatal(err01)
        }
        PrintResponse(resp, body)
    }

    // 下载文件
    func DownlodFile() {
        req := gorequest.New().Get(domain + "/hello/download/Snipaste_2023-01-14_14-05-26.png")
        resp, body, err := req.End()
        PrintRequest(req)
        if err != nil {
            log.Fatal(err)
        }
        PrintResponse(resp, body)
    }

    // 修改用户信息
    func PutUserInfo() {
        reqBody := `{ "name": "123" }`
        req := gorequest.New().Put( domain + "/hello/1").Type("json").Send(reqBody)
        resp, body, err := req.End()
        PrintRequest(req)
        if err != nil {
            log.Fatal(err)
        }
        PrintResponse(resp, body)
    }

    // 删除用户信息
    func DeleteUser() {
        req := gorequest.New().Delete(domain + "/hello/1")
        PrintRequest(req)
        resp, body, err := req.End()
        if err != nil {
            log.Fatal(err)
        }
        PrintResponse(resp, body)
    }

    func main() {
        GetUserList()
        fmt.Println("#######################")
        GetUserInfo()
        fmt.Println("#######################")
        PostUser()
        fmt.Println("#######################")
        PostUserIcon()
        fmt.Println("#######################")
        DownlodFile()
        fmt.Println("#######################")
        PutUserInfo()
        fmt.Println("#######################")
        DeleteUser()
    }
    ```

- 颜色打印
    ```go
    import (
        "fmt"
        "github.com/fatih/color"
    )

    func main() {
        color.Set(color.FgGreen)
        fmt.Println("1111")
        color.Set(color.FgYellow)
        fmt.Println("1111")
        color.Set(color.FgRed)
        fmt.Println("1111")
    }
    ```

#### 2. Beego框架
- beego的安装与使用
    ```shell
    # 安装beego与bee工具(不需要在`go mod`项目文件中使用)
    # go1.17后, 使用`go install`进行下载安装; go1.17前, 使用`go get`进行下载安装;
    go install -v github.com/beego/beego
    go install -v  github.com/beego/bee
    # bee的可执行文件加入到环境变量中
    # bee的可执行文件在`$GOPATH/bin`目录中

    # bee工具的使用
    # 新建beego MVC项目
    bee new beego-demo
    cd beego-demo
    # 运行项目
    bee run
    # 打包项目
    bee pack
    ```

#### 3. Gin 框架
- Gin的路由
    ```go
    package main

    import (
        "fmt"
        "github.com/gin-gonic/gin"
        "net/http"
        "os"
        "path/filepath"
        "regexp"
        "strings"
    )

    type User struct {
        Name     string `json:"name"`
        Password string `json:"password"`
    }

    // restful-API路由
    func main() {
        router := gin.Default()
        router.MaxMultipartMemory = 8 << 20 // 8M
        uploadDir := "./upload"

        // 查询用户列表: GET /hello?name=123&password=12121
        router.Handle("GET", "/hello", func(context *gin.Context) {
            var user User
            err := context.ShouldBindQuery(&user)
            if err != nil {
                context.JSON(http.StatusInternalServerError, gin.H{"msg": "请求信息错误!!!"})
                return
            }
            fmt.Println("##### 请求参数: name=", context.Query("name"), ", password=", context.Query("password"))
            context.JSON(http.StatusOK, gin.H{"msg": "查询用户列表成功 !"})
        })

        // 查询用户信息: GET /hello/{id}
        router.Handle("GET", "/hello/:id", func(context *gin.Context) {
            fmt.Println("##### 路径参数: id=", context.Param("id"))
            ok, err := regexp.Match("^[1-9]\\d*$", []byte(context.Param("id")))
            if err!=nil{
                context.JSON(http.StatusInternalServerError, gin.H{"msg": err.Error()})
                return
            }
            if !ok{
                context.JSON(http.StatusNotFound, gin.H{"msg": "资源路径不存在"})
                return
            }
            context.JSON(http.StatusOK, gin.H{"msg": "查询用户信息成功 !"})
        })

        // 创建用户: POST /hello  json: { "name": "123", "password": "123456" }
        router.Handle("POST", "/hello", func(context *gin.Context) {
            var user User
            err := context.ShouldBindJSON(&user)
            if err != nil {
                context.JSON(http.StatusInternalServerError, gin.H{"msg": "请求信息错误!!!"})
                return
            }
            fmt.Println("##### 请求体: name=", user.Name, ", password=", user.Password)
            context.JSON(http.StatusOK, gin.H{"msg": "创建用户成功 !"})
        })

        // 上传用户头像: POST /hello/{id}/upload  image_file=xxxx
        router.Handle("POST", "/hello/:id/upload", func(context *gin.Context) {
            fmt.Println("##### 路径参数: id=", context.Param("id"))
            form, err := context.MultipartForm()
            if err != nil {
                context.JSON(http.StatusInternalServerError, gin.H{"msg": "文件上传失败!!!"})
                return
            }
            for _, files := range form.File {
                for _, file := range files {
                    // 文件大小: 不超过2M
                    if fileSize := int64(2 << 20); file.Size > fileSize {
                        context.JSON(http.StatusInternalServerError, gin.H{"msg": fmt.Sprintf("文件大小不能超过 %v bytes !!!", fileSize)})
                        return
                    }
                    // 文件类型
                    if ext := "jpg;jpeg;png"; !strings.Contains(ext, strings.ToLower(filepath.Ext(file.Filename))[1:]) {
                        fmt.Println(strings.ToLower(filepath.Ext(file.Filename)))
                        context.JSON(http.StatusInternalServerError, gin.H{"msg": "文件类型只支持" + ext + " !!!"})
                        return
                    }
                    // 保存文件
                    err := os.MkdirAll(uploadDir, 0755)
                    if err != nil {
                        context.JSON(http.StatusInternalServerError, gin.H{"msg": "服务器上传文件目录异常 !!!"})
                        return
                    }
                    if err = context.SaveUploadedFile(file, filepath.Join(uploadDir, file.Filename)); err != nil {
                        context.JSON(http.StatusInternalServerError, gin.H{"msg": "文件保存失败!!!"})
                        return
                    }
                }
            }
            context.JSON(http.StatusOK, gin.H{"msg": "用户头像上传成功 !"})
        })

        // 上传用户头像: GET /hello/download/{filepath}
        router.Handle("GET", "/hello/download/:filepath", func(context *gin.Context) {
            fmt.Println("##### 路径参数: filepath=", context.Param("filepath"))
            file , ok :=context.Params.Get("filepath")
            if !ok{
                context.JSON(http.StatusNotFound, gin.H{"msg": "接口路径不存在!!!"})
                return
            }
            // 客户端只能看不能下载文件
            // context.File(filepath.Join(uploadDir, file))
            // 客户端可以下载文件
            context.FileAttachment(filepath.Join(uploadDir, file), file)
        })

        // 修改用户信息: PUT /hello  json: { "name": "123" }
        router.Handle("PUT", "/hello/:id", func(context *gin.Context) {
            fmt.Println("##### 路径参数: id=", context.Param("id"))
            var user User
            err := context.ShouldBindJSON(&user)
            if err != nil {
                context.JSON(http.StatusInternalServerError, gin.H{"msg": "请求信息错误!!!"})
                return
            }
            fmt.Println("##### 请求体: name=", user.Name, ", password=", user.Password)
            context.JSON(http.StatusOK, gin.H{"msg": "修改用户信息成功 !"})
        })

        // 删除用户: DELETE /hello/{id}
        router.Handle("DELETE", "/hello/:id", func(context *gin.Context) {
            fmt.Println("##### 路径参数: id=", context.Param("id"))
            context.JSON(http.StatusOK, gin.H{"msg": "删除用户成功 !"})
        })

        err := router.Run("0.0.0.0:8080")
        if err != nil {
            fmt.Println(err.Error())
            return
        }
    }
    ```
 
- Gin整合Swagger
    ```golang
    // 安装最新版Swag: `go install -v github.com/swaggo/swag/cmd/swag`
    // 或者先下载依赖再编译安装: `go install -v github.com/swaggo/swag/cmd/swag@v1.8.8 && 
    // cd $GOPATH/pkg/mod/github.com/swaggo/swag@v1.8.8/cmd/swag && go install`
    // 将$GOPAHT/go/bin/swag.exe加入到环境变量中, 初始化文档: `swag init`
    // 参考官方文档: https://github.com/swaggo/swag
    ```

- Gin整合Gorm
    ```go
    import (
        "gorm.io/driver/mysql"
        "gorm.io/gorm"
        "log"
    )

    type BlogUser struct {
        gorm.Model
        Username string `gorm:"size:50;not null"`
        Age uint8 `gorm:"not null;default:20"`
        Price float32 `gorm:"not null;precision:5;scale:2"`
        Description string `gorm:"size:255;not null"`
        GroupID uint `gorm:"not null;comment:组ID"`
    }

    type BlogGroup struct {
        gorm.Model
        GroupName string `gorm:"size:20;not null;default:小学组"`
    }


    func main() {
        // 与数据建立连接
        dsn:="root:123456@tcp(106.13.223.242:3306)/test?charset=utf8&parseTime=True&loc=Local"
        db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
        if err != nil {
            log.Fatalln(err)
        }
        // 创建表
        err = db.AutoMigrate(&BlogUser{})
        if err != nil {
            log.Fatalln(err)
        }
        err = db.AutoMigrate(&BlogGroup{})
        if err != nil {
            log.Fatalln(err)
        }
        // 插入数据
        var datas =[]BlogUser{
            {Username:"小唐", Age: 0, Price: 12.30, Description: "广东省深圳市松白路", GroupID: 1},
            {Username:"小明", Age: 13, Price: 30.00, Description: "美国洛杉矶", GroupID: 1},
            {Username:"小章",Age: 70, Price: 89.00, Description: "英国伦敦", GroupID: 3},
            {Username:"王小名", Age: 40, Price: 45.00, Description: "法国巴黎", GroupID: 2},
            {Username:"艾伦", Age: 1, Price: 14.00, Description: "古巴比伦", GroupID: 2},
            {Username:"李冰", Age: 36, Price: 45.63, Description: "中国上海", GroupID: 1},
        }
        db.Create(&datas)   // 创建结果更新在datas, 比如每行记录的id
        db.Create(&[]BlogGroup{
            {ID: 1, GroupName: "中学组"}, {ID: 2,GroupName: "大学组"}, {ID: 3,GroupName: "小学组"},
        })

        // 查询
        var user BlogUser
        db.First(&user) // SELECT * FROM users ORDER BY id LIMIT 1;
        db.Last(&user)  // SELECT * FROM users ORDER BY id DESC LIMIT 1;
        var users []BlogUser
        db.Find(&users) // SELECT * FROM users;
        // 条件查询
        db.Where("username != ?", "小唐").Find(&users)
        db.Where("username = ?", "小唐").Find(&users)
        db.Where("username like ?", "%小%").Find(&users)
        db.Where("username in ?", []string{"小唐", "小明"}).Find(&users)
        db.Where("age between ? and ? ", 0, 50).Find(&users)
        db.Where("age > ? or age < ? ", 50, 10).Find(&users)
        db.Where("age > ? or age < ? ", 50, 10).Find(&users)
        // 排序与分页
        db.Order("age desc, username").Limit(2).Offset(0).Find(&users)
        // 分组与聚合函数
        type Result struct {
            GroupID string
            Total   uint
        }
        var results []Result
        db.Table("blog_users").Select("group_id, sum(age) as total").Group("group_id").Having("group_id = ?", 1).Scan(&results)
        //fmt.Printf("%+v", results)
        // 去重
        db.Distinct("group_id").Find(&users)
        // 多表查询
        type TwoResult struct {
            ID        uint
            Username  string
            GroupID   uint
            GroupName string
        }
        var twoResults []TwoResult
        db.Table("blog_users").Select("blog_users.id, blog_users.username, blog_users.group_id , blog_groups.group_name").
            Joins("inner join blog_groups on blog_users.group_id = blog_groups.id").Scan(&twoResults)
        // 衍生表
        subTable:= db.Table("blog_users").Select("max(age) as max_age, group_id").Group("group_id")
        db.Table("blog_users").Select("blog_users.id, blog_users.age, blog_users.username, blog_users.group_id").
            Joins("inner join (?) q on blog_users.age = q.max_age", subTable).Scan(&users)
        fmt.Printf("%+v", users)
        // 子查询
        type S struct {
            AvgAge float32
        }
        subQuery:= db.Table("blog_users").Select("avg(age) as avg_age")
        db.Where("age > (?)", subQuery).Find(&users)
        fmt.Printf("%+v", users)

        // 更新与删除
        // 更新
        db.Model(BlogUser{}).Where("id = ?", 16).Updates(BlogUser{Username: "铁拐李", Age: 75})
        // 软删除: UPDATE `blog_users` SET `deleted_at`='2023-04-09 12:12:59.69' WHERE `blog_users`.`id` = 17 AND `blog_users`.`deleted_at` IS NULL
        db.Delete(&BlogUser{}, 15)
        // 查询软删除数据
        var result BlogUser
        db.Unscoped().Where("id = ? ", 15).Find(&result)
        fmt.Printf("\n%+v", result)
        // 硬删除: DELETE from blog_users where id = 15;
        db.Unscoped().Delete(&BlogUser{}, 15)
    }
    ```



    