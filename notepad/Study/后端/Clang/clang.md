## Clang 🎂🎉🌹
#### 1. clang语言
##### 1.1 Vscode配置Clang环境(Win10)
- 配置`C/C++`环境
  - 下载[MinGW](https://sourceforge.net/projects/mingw-w64/files/)的版本: `x86_64-win32-seh`
  - 再配置环境变量, `D:\MinGW` 和 `D:\MinGW\bin`
  - 接下来配置编译器路径，按快捷键`Ctrl+Shift+P`调出命令面板，输入`C/C++`，选择`Edit Configurations(UI)`进入配置, 设置编译器路径: `D:\MinGW\bin`, IntelliSense 模式: `windows-gcc-x64`(windows环境下)
- 配置`CMake`
  - 安装`CMake`, 增加VScode插件: `CMake` 和`CMake Tools`
  - 再配置环境变量, `D:\CMake\bin` 
  - 接下来配置编译器路径，按快捷键`Ctrl+Shift+P`调出命令面板，输入`CMake`，选择`CMake: Configure`进入配置, 设置CMake的编译环境

##### 1.2 CMake
- CMake的编译指令
    ```shell
    # linux 环境下
    # 完整指令
    # 生成makefile文件
    /bin/cmake --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_C_COMPILER:FILEPATH=/bin/gcc -DCMAKE_CXX_COMPILER:FILEPATH=/bin/g++ -S/home/tom01/Wangxi/respo/clang/clang-demo -B/home/tom01/Wangxi/respo/clang/clang-demo/build -G "Unix Makefiles"
    # 编译makefile
    /bin/cmake --build /home/tom01/Wangxi/respo/clang/clang-demo/build --config Debug --target all -j 6 --
    # 简化指令
    cmake -B build . && cmake --build build/

    # windows环境下
    # 完整指令
    # 生成makefile文件
    D:\CMake\bin\cmake.EXE --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_C_COMPILER:FILEPATH=D:\mingw64\bin\gcc.exe -DCMAKE_CXX_COMPILER:FILEPATH=D:\mingw64\bin\g++.exe -Sd:/My_Resp/Gitee/clang/clang-demo -Bd:/My_Resp/Gitee/clang/clang-demo/build -G "MinGW Makefiles"
    # 编译makefile
    D:\CMake\bin\cmake.EXE --build d:/My_Resp/Gitee/clang/clang-demo/build --config Debug --target all -j 18 --
    # 简化指令
    cmake -B build -G "MinGW Makefiles" . && cmake --build build/
    ```
- `CMakeLists.txt`文件
    ```shell
    cmake_minimum_required(VERSION 3.25)
    project(clang-demo)

    # specify the cross compiler, 即工具链的地址
    # SET(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gcc)
    # SET(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-g++)

    #Bring the headers, such as Student.h into the project
    include_directories(header)

    # 设置变量
    # set(SOURCES "src/foo.cpp" "src/main.cpp")
    file(GLOB SOURCES "src/*")

    # 生成链接库
    # Generate the shared library(动态链接库) from the sources
    # add_library(testStudent SHARED ${SOURCES})
    # Generate the static library(静态链接库) from the sources
    # add_library(testStudent STATIC ${SOURCES})
    # Set the location for library installation -- i.e., /usr/lib in this case
    # not really necessary in this example. Use "sudo make install" to apply
    # install(TARGETS testStudent DESTINATION D:/My_Resp/Gitee/clang/clang-demo/lib)

    # 设置链接动态库或者静态库的变量
    set ( PROJECT_LINK_LIBS libtestStudent.a )
    link_directories("D:/My_Resp/Gitee/clang/clang-demo/lib")

    # 生成可执行文件
    add_executable(demo ${SOURCES})
    # 可执行文件链接动态库或者静态库
    target_link_libraries(demo ${PROJECT_LINK_LIBS})
    ```

##### 1.3 C语言的基础知识
- 基础知识
    ```c
    // 特殊关键字
    // sizeof: 计算数据类型或变量长度（即所占字节数）
    // typedef: 用以给数据类型取别名

    // 常量的定义
    const float PI=3.1415;
    #define PI 3.1415
    const char *p // 常量指针, 指向的值为常量
    char * const p // 指针常量, 指向的地址不能改变

    // 存储类
    // auto: 所有局部变量默认的存储类
    // register: 用于定义存储在寄存器中而不是 RAM 中的局部变量。这意味着变量的最大尺寸等于寄存器的大小（通常是一个字），且不能对它应用一元的 '&' 运算符
    // static: 指示编译器在程序的生命周期内保持局部变量的存在，而不需要在每次它进入和离开作用域时进行创建和销毁。因此，使用 static 修饰局部变量可以在函数调用之间保持局部变量的值。tatic 修饰符也可以应用于全局变量。当 static 修饰全局变量时，会使变量的作用域限制在声明它的文件内。全局声明的一个 static 变量或方法可以被任何函数或方法调用，只要这些方法出现在跟 static 变量或方法同一个文件中
    // extern: 用于提供一个全局变量的引用，全局变量对所有的程序文件都是可见的。当您使用 extern 时，对于无法初始化的变量，会把变量名指向一个之前定义过的存储位置。当您有多个文件且定义了一个可以在其他文件中使用的全局变量或函数时，可以在其他文件中使用 extern 来得到已定义的变量或函数的引用。可以这么理解，extern 是用来在另一个文件中声明一个全局变量或函数

    // 魔术常量
    // __DATE__: 当前日期, 宏定义，一个以 "MMM DD YYYY" 格式表示的字符常量。
    // __TIME__: 当前时间, 宏定义，一个以 "HH:MM:SS" 格式表示的字符常量。
    // __FILE__: 这会包含当前文件名，一个字符串常量。
    // __LINE__: 这会包含当前行号，一个十进制常量。
    // __STDC__: 当编译器以 ANSI 标准编译时，则定义为 1。

    // 格式化当前时间, 头文件: `time.h`
    // 睡眠: `sleep()`, 头文件: `unistd.h`
    char * formatNowTime(){
        time_t t1= time(NULL); // 当前时间戳
        static char p[50];
        strftime(p, sizeof(p), "%Y-%m-%d %H:%M:%S", localtime(&t1));
        return p;
    }

    // 字符串, 头文件: `string.h`
    // 合并字符串
    char *strcat(char *dest, const char *src)
    // 将字符串复制到另一个字符
    char *strcpy(char *dest, const char *src)
    // 字符串的长度
    size_t strlen(const char *str)

    // 内存管理, 头文件: `stdlib.h`
    void *calloc(int num, int size);
    // 在内存中动态地分配 num 个长度为 size 的连续空间，并将每一个字节都初始化为 0。所以它的结果是分配了 num*size 个字节长度的内存空间，并且每个字节的值都是0。
    void free(void *address);
    // 该函数释放 address 所指向的内存块,释放的是动态分配的内存空间。
    void *malloc(int num);
    // 在堆区分配一块指定大小的内存空间，用来存放数据。这块内存空间在函数执行完成后不会被初始化，它们的值是未知的。
    void *realloc(void *address, int newsize);
    // 该函数重新分配内存，把内存扩展到 newsize。
    ```
- 进程

##### 1.4 进阶知识
- 内存管理
    ```c
    // 一般把内存理解成4个分区：栈、堆、全局/静态存储区和常量存储区
    // 1）栈：用于那些在编译期间就能确定存储大小的变量的存储区，用于在函数作用域内创建，在离开作用域后自动销毁的变量的存储区。它的存储空间是连续的，两个紧挨着定义的局部变量，它们的存储空间也是紧挨着的。一般栈的大小有限制，所以定义超大数组时需注意，如vc++编译器的默认栈大小为1M。
    // 2）堆：哪些在编译期间不能确定存储大小的变量的存储区，它的存储空间是不连续的，一般由malloc（new）函数来分配内存块，并且需free（delete）释放内存。如没释放便会造成内存泄漏问题。两个紧挨着定义的指针变量，所指向的分配出来的两块内存并不一定是紧挨着的。堆的大小由虚拟内存而定，32位机器的大小为2的32次方，即为4GB。
    // 3）全局/静态存储区：和“栈”一样，用于那些在编译期间就能确定存储大小的变量的存储区，但它用于的是在整个程序运行期间都可见的全局变量和静态变量。
    // 4）常量存储区：用于那些在编译期间就能确定存储大小的变量的存储区，并且在程序运行期间，存储区的常量也是全局可见的，而存放的是常量，不允许被修改

    /**
    * 增加内存持续一段时间
    * 
    * n: 内存的大小(M)
    * time: 持续时间(s)
    * return: 
    */ 
    void createMemory(int n, int time){
        size_t M= 1024 * 1024;
        char** p; 
        // 分配内存
        p=(char**)malloc(n * sizeof(char *));
        size_t i, j;
        for (i = 0; i < n; i++)
        {
            p[i]=(char *)malloc(M * sizeof(char));
        }
        printf("---assigned %d M memory---\n", n);
        // 使用内存
        for (i = 0; i < n; i++)
        {
            for (j = 0; j < M; j++)
            {
                p[i][j]='c';
            }
        }
        // 释放内存
        printf("---used %d M memory---\n", n);
        sleep(time);
        for (i = 0; i < n; i++)
        {
            free(p[i]);
        }
        free(p);
        printf("---free %d M memory---\n", n);  
    }
    ```