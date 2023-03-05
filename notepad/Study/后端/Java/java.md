## Java 🐱‍🐉🐱‍👓🐱‍🚀
#### 1. JDK 环境配置
##### 1.1 Windows 环境配置
- 变量名：`JAVA_HOME`
  变量值：`C:\Program Files (x86)\Java\jdk1.8.0_91 `  <b style="color: orange;" >🍔 要根据自己的实际路径配置 🍔</b>
- 变量名：`CLASSPATH`
  变量值：`.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;`  <b style="color: orange;" >🍔 记得前面有个"." 🍔</b>
- 变量名：`Path`
  变量值：`%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;`

##### 1.2 Linux 环境配置
- java8 的安装
  ```shell
  #/bin/bash
  # -*- coding:utf-8 -*-
  # @File: java-install.sh
  # @Description: 
  # java-1.8 的安装
  # linux 版本: Centos7.8-x86_x64

  # 安装java的依赖
  yum -y install gcc  wget vim  net-tools

  # 下载 java-1.8
  wget -O /root/jdk-8u202-linux-x64.tar.gz \
  https://repo.huaweicloud.com/java/jdk/8u202-b08/jdk-8u202-linux-x64.tar.gz

  # 解压java-1.8
  tar -zxvf /root/jdk-8u202-linux-x64.tar.gz -C /root/
  mv /root/jdk1.8.0_202 /usr/local/java8

  # 配置java JDK环境
  echo 'export JAVA_HOME=/usr/local/java8
  export PATH=${PATH}:${JAVA_HOME}/bin
  export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar' >> /etc/profile

  # 环境变量生效
  . /etc/profile

  echo ""
  java -version
  echo -e "\033[32mSuccess: java 安装成功 (^_^)\033[0m"
  echo ""
  
  ```
- java8 的卸载
  ```shell
  #/bin/bash
  # -*- coding:utf-8 -*-
  # @File: java-uninstall.sh
  # @Description: 
  # java8 的卸载
  # linux 版本: Centos7.8-x86_x64

  # 删除java8安装目录
  rm -rf /usr/local/java8

  # 删除java配置语句
  sed -i '/export JAVA_HOME=\/usr\/local\/java8/d' /etc/profile
  sed -i '/export PATH=\${PATH}:\${JAVA_HOME}\/bin/d' /etc/profile
  sed -i '/export CLASSPATH=.:\${JAVA_HOME}\/lib\/dt.jar/d' /etc/profile

  # 环境变量生效
  . /etc/profile

  echo ""
  java -version
  echo -e "\033[32mSuccess: java 卸载成功 (^_^)\033[0m"
  echo ""
  
  ```
---
#### 2. Maven相关知识
##### 2.1 简介
- Maven 是一个项目管理工具，可以对 Java 项目进行构建、依赖管理
- `~/.m2/repository`, Maven默认的本地仓库目录位置
  
##### 2.2 配置环境变量
- `Windows`中添加环境变量
  - 新建系统变量 `MAVEN_HOME`，变量值：`E:\Maven\apache-maven-3.3.9`
  - 编辑系统变量 `Path`，添加变量值：`;%MAVEN_HOME%\bin`
- `Linux`中添加环境变量
  - 下载解压安装包
    - `wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz -O  apache-maven-3.8.6.tar.gz `
    - `tar -xvf  apache-maven-3.8.6.tar.gz`
    - `sudo mv -f apache-maven-3.8.6 /usr/local/`
  - 编辑 `/etc/profile` 文件 `sudo vim /etc/profile`，在文件末尾添加如下代码：
    - `export MAVEN_HOME=/usr/local/apache-maven-3.8.6`
    - `export PATH=${PATH}:${MAVEN_HOME}/bin`
  - 保存文件，并运行如下命令使环境变量生效：`source /etc/profile`
  - 查看`Maven`是否安装成功：`mvn -v`
  
##### 2.3 pom文件
- POM( Project Object Model，项目对象模型 ) 是 Maven 工程的基本工作单元，是一个XML文件，包含了项目的基本信息，用于描述项目如何构建，声明项目依赖等
- 所有 POM 文件都需要 `project` 元素和三个必需字段：`groupId，artifactId，version`
- 使用构建配置文件，你可以为不同的环境，比如说生产环境（Production）和开发（Development）环境，定制构建方式。配置文件在 pom.xml 文件中使用 activeProfiles 或者 profiles 元素指定，并且可以通过各种方式触发。配置文件在构建时修改 POM，并且用来给参数设定不同的目标环境（比如说，开发（Development）、测试（Testing）和生产环境（Production）中数据库服务器的地址
- maven 修改配置文件
  - 找到你解压的目录，进去找到conf，然后找到settings.xml文件
  - 本地仓库位置修改：在`<localRepository>D:\java\maven\repository</localRepository>`标签内添加自己的本地仓库位置路径，这个本地仓库位置是自己创建的
    ```xml
    <!-- localRepository
      | The path to the local repository maven will use to store artifacts.
      |
      | Default: ${user.home}/.m2/repository
      <localRepository>/path/to/local/repo</localRepository>
      -->
      <localRepository>D:\java\maven\repository</localRepository>

    ```
  - 修改maven默认的JDK版本：在`<profiles>`标签下添加一个`<profile>`标签，修改maven默认的JDK版本
    ```xml
    <profile>     
        <id>JDK-1.8</id>       
        <activation>       
            <activeByDefault>true</activeByDefault>       
            <jdk>1.8</jdk>       
        </activation>       
        <properties>       
            <maven.compiler.source>1.8</maven.compiler.source>       
            <maven.compiler.target>1.8</maven.compiler.target>       
            <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>       
        </properties>       
    </profile>

    ```
  - 添加国内镜像源添加`<mirrors>`标签下`<mirror>`，添加国内镜，这样下载`jar`包速度很快
    ```xml
    <mirror>
          <id>alimaven</id>
          <mirrorOf>central</mirrorOf>
          <name>aliyun maven</name>
          <url>http://maven.aliyun.com/nexus/content/groups/public</url>
    </mirror>

    ```
- 依赖管理
  - parent与dependencyManager的区别
    1. 继承了parent，会继承parent项目中的所有jar包
    2. dependencyManager只用来维护jar包，子项目可以通过dependency引用指定jar包来使用
  - parent与dependency的区别
    1. 使用parent，只能使用parent中引入的jar包，用不了parent中的代码方法
    2. 使用dependency，能使用parent中引入的jar包，也可以parent中的代码方法
  - 模块管理
    ```xml
    <!-- 添加模块 -->
    <modules>
        <module>demo</module>
    </modules>
    <!-- 打包 -->
    <packaging>pom</packaging>

    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
      <version>2.7.4</version>
      <!-- 作用域 -->
      <scope>compile</scope>
      <!-- 排除依赖 -->
      <exclusions>
          <exclusion>
              <groupId>log4j</groupId>
              <artifactId>log4j</artifactId>
          </exclusion>
      </exclusions>
    </dependency>
    
    ```


##### 2.4 构建生命周期
  - `clean`：项目清理的处理
  - `default`(或 `build`)：项目部署的处理
    - 验证 `validate` -> 编译 `compile` -> 测试 `Test` -> 包装 `package` ->检查 `verify` ->安装 `install` ->部署 `deploy` 
      - 包装 `package`:创建`JAR/WAR`包如在 `pom.xml` 中定义提及的包
  - `site`：项目站点文档创建的处理
  - maven 编译打包: `mvn clean package -Dmaven.test.skip=true` 

---
#### 3. Tomcat服务器
##### 3.1 部署项目
- 下载 Tomcat9 安装包，解压
- 把项目打包成`jar`或者`war`包，放到`Tomcat`的`webapps`目录下
- 双击`bin`目录下的`startup.bat`,再按`CTR + C`关闭应用
- Ideal 编辑器中配置热启动
  - 打开右上角`构建` 旁边的下拉菜单，点击里面的配置，添加一个本地Tomcat服务器
  - 点击`部署`, 点击`+`添加工件`untitled3:war exploded`
  - 点击`服务器`, 配置`Tomcat`文件根路径
  - 点击`确定`

##### 3.2 修改配置文件
- 修改网站的端口号(`./conf/server.xml`): 默认端口号-8080
  ```xml
  <Connector port="8089" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" useBodyEncodingForURI="true" URIEncoding="UTF-8" />

  ```

##### 3.3 Jenkins自动化集成
- 安装: 类似于用宝塔安装Java war包
- 配置 JDK, Maven, git
  - Jenkins的配置文件夹:  `用户目录/.jenkins`
  - 点击主页中:  `Manage Jenkins > Global Tool Configuration > 配置相关选项`
- 添加项目
  - 步骤：点击`New Item`,填写项目名字，类型
  - `Build Triggers`: 选择`Poll SCM`, 意思是检测到源代码发生改变的时候重新构建项目，不然不会去构建

---
#### 4. Java 编程
##### 4.1 Java 基础知识
- 基础语法
    ```java
    // 数据类型
    boolean b=true;
    byte b1=12;
    char c='c';
    short val= 123;
    long val1= 1542;
    int val2= 1545;
    // 小数默认是 double 类型浮点型，在定义 float 类型时必须在数字后面跟上 F 或者 f
    float f= 123.23f;
    double d= 155463;
    //常量
    final double PI= 3.1415926;
    // 类型自动转换: byte,short,char—> int —> long—> float —> double
    // 强制类型转换: int a= (int)12.3
    int a= (int) 12.3;

    // 字符串, 只能使用双引号, 不支持单引号
    String s= "123";
    String s1= a+ "";
    // 字符串, 转换成其他类型
    // 单引号与双引号的区别: 单引号表示字符, 双引号表示字符串
    byte b2= Byte.parseByte(s1);

    // 数组: 可以进行下标访问
    double[] nums = { 1.4, 1.5, 1.6, -1.4, -1.5, -1.6 };

    // 流程控制
    // 三目运算符
    int y = 10;
    boolean x = y > 5 ? true : false;
    // 条件运算符
    // if 语句
    if (i == 0) {
        System.out.println(123);
    } else {
        System.out.println(123);
    }
    // if ... else if ... 语句
    if (i == 0) {
        System.out.println(123);
    } else if (i > 0 ) {
        System.out.println(123);
    } else {
        System.out.println(123);
    }

    // switch ... case ... 语句
    switch (num) {
        case 8:
            System.out.println("恭喜你，获得了三等奖！");
            break;
        default:
            System.out.println("谢谢参与！");
            break;
    }

    // while 语句
    while(i <= 10) {
        System.out.println("1253");
    }

    // for 语句
    for (int i = 1; i <= 6; i++) {
        System.out.println("请输入第" + i + " 个月的销售数量：");
    }

    // foreach 语句
    for (String url : urls) {
        System.out.println(url);
    }

    // 方法的可变参数
    public static int printType(int a, int b, int... args){
        return a + b;
    }
    public static double printType(double[] args){
        return args[0] + args[1];
    }

    // 类与包
    // java 修饰符
    // default (即默认，什么也不写）: 在同一包内可见，不使用任何修饰符。使用对象：类、接口、变量、方法。
    // private : 在同一类内可见。使用对象：变量、方法。 注意：不能修饰类（外部类）
    // public : 对所有类可见。使用对象：类、接口、变量、方法
    // protected : 对同一包内的类和所有子类可见。使用对象：变量、方法。 注意：不能修饰类（外部类）
    //
    // 继承的特性: B extends A, C implements D
    // 子类拥有父类非 private 的属性、方法。
    // 子类可以拥有自己的属性和方法，即子类可以对父类进行扩展。
    // 子类可以用自己的方式实现父类的方法。
    // Java 的继承是单继承，但是可以多重继承，单继承就是一个子类只能继承一个父类，多重继承就是，例如 B 类继承 A 类，C 类继承 B 类，
    // 所以按照关系就是 B 类是 C 类的父类，A 类是 B 类的父类，这是 Java 继承区别于 C++ 继承的一个特性。
    // 提高了类之间的耦合性（继承的缺点，耦合度高就会造成代码之间的联系越紧密，代码独立性越差）。
    // super关键字：我们可以通过super关键字来实现对父类成员的访问，用来引用当前对象的父类。
    // this关键字：指向自己的引用。
    // 使用 final 关键字声明类，就是把类定义定义为最终类，不能被继承，或者用于修饰方法，该方法不能被子类重写
    //
    // 重写(Override)与重载(Overload)
    // 重写是子类对父类的允许访问的方法的实现过程进行重新编写, 返回值和形参都不能改变。即外壳不变，核心重写！
    // 重载(overload) 是在一个类里面，方法名字相同，而参数不同。返回类型可以相同也可以不同
    //
    // 接口
    // 接口不能用于实例化对象, 接口没有构造方法。
    // 接口中所有的方法必须是抽象方法，Java 8 之后接口中可以使用 default 关键字修饰的非抽象方法。接口中每一个方法也是隐式抽象的,接口中的方法会被隐式的指定为 public abstract（只能是 public abstract，其他修饰符都会报错）。
    // 接口不能包含成员变量，除了 static 和 final 变量。接口中可以含有变量，但是接口中的变量会被隐式的指定为 public static final 变量（并且只能是 public，用 private 修饰会报编译错误）。
    // 接口中的方法是不能在接口中实现的，只能由实现接口的类来实现接口中的方法。
    // 接口不是被类继承了，而是要被类实现, 接口支持多继承。
    // 在接口的多继承中extends关键字只需要使用一次，在其后跟着继承接口
    // public interface Hockey extends Sports, Event 
    // public class Hockey extends Dog implements Animal
    // 
    // 包
    // 创建包
    package animals;
    interface Animal {
        public void eat();
        public void travel();
    }
    // 导入包
    import java.io.Math;


    ```
- 常用函数
    ```java
    // 字符串的常用函数
    String s= "Hello,World !";
    // 字符串的长度
    System.out.println(s.length());
    // 连接字符串
    System.out.println(s + " Tom");
    // 字符串下标对应的字符
    System.out.println(s.charAt(2));
    // 字符或子字符串第一次出现字符串的下标
    System.out.println(s.indexOf("ll"));
    // 正则表达式
    s.matches("Hell.*");
    // 字符串替换
    System.out.println(s.replace("ll", "pp"));
    // 字符串分割成数组
    String[] arr = s.split(",");
    // 获取字符串的子串
    System.out.println(s.substring(1, 2));
    // 字符串大小写转换
    System.out.println(s.toLowerCase());
    System.out.println(s.toUpperCase());
    // 字符串去除两端的空白字符
    System.out.println(s.trim());

    // Math 类的常用函数
    // 四舍五入: Math.round(1.23), 向下取整: Math.floor(1.23), 向上取整: Math.ceil(1.23)
    // 随机数: Math.random(), Π: Math.PI
    System.out.println(Math.PI);

    // 输入与输出
    // 正常输出
    System.out.println(Math.PI);
    // 格式化输出
    System.out.printf("%.2f, %d" , Math.PI, 100);
    // 控制台输入字符串
    System.out.println("请输入:");
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    String s1 = br.readLine();
    System.out.println(s1);

    // 日期函数
    Date d = new Date();
    System.out.println(d);
    // 时间戳转时间字符串
    String f_date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(123));
    System.out.println(f_date);
    // 时间字符串转时间戳
    long t1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("1920-08-10 10:00:00").getTime();
    // 当前时间戳
    long t2 = new Date().getTime();
    // 时区的转换
    SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    // 转化为 GMT 时间
    f.setTimeZone(TimeZone.getTimeZone("GMT+0:00"));
    System.out.println(f.format(new Date()));

    // 文件类的常用方法
    // 写入文件
    FileOutputStream fop = new FileOutputStream(new File("./1.txt"), true);
    OutputStreamWriter wt = new OutputStreamWriter(fop, "UTF-8");
    wt.write("hello, world!! 你好, 我是王溪\n");
    wt.close();
    fop.close();
    // 读文件
    FileInputStream fip = new FileInputStream(new File("./1.txt"));
    InputStreamReader rd = new InputStreamReader(fip, "UTF-8");
    StringBuffer str = new StringBuffer();
    while (rd.ready()) {
        // 每次调用 read() 方法，它从输入流读取一个字符并把该字符作为整数值返回
        str.append((char)rd.read());
    }
    System.out.println(str);
    rd.close();
    fip.close();
    // 文件不存在就创建
    new File("./2.txt").createNewFile();
    // 递归创建文件夹
    new File("./ss/ss01").mkdirs();
    // 判断文件的类型
    File f= new File("./2.txt");
    f.isFile();
    f.isDirectory();
    f.exists();
    // 获取路径
    File f = new File("./ss");
    // 获取绝对路径
    System.out.println(f.getAbsolutePath());
    // 获取文件或者文件夹名
    System.out.println(f.getName());
    // 获取父类文件夹
    System.out.println(f.getParent());
    // 获取文件及文件夹对象
    f.listFiles();
    // 删除文件或者文件夹
    f.delete();


    ```
##### 4.2 java 高级知识
- java 常用类
    ```java
    // 数据结构
    // ArrayList 类是一个可以动态修改的数组，与普通数组的区别就是它是没有固定大小的限制，我们可以添加或删除元素,
    // 通过下标访问查询速度更快, 插入与删除速度慢
    // 以下情况使用 ArrayList :
    // 1.频繁访问列表中的某一个元素。
    // 2.只需要在列表末尾进行添加和删除元素操作。
    ArrayList<String> arr = new ArrayList<>();
    // 增加元素
    arr.add("hello");
    // arraylist中添加数组
    String[] s1= { "hello", "world"};
    Collections.addAll(arr, s1 );
    // arraylist转化为数组
    String[] s2= new String[arr.size()];
    arr.toArray(s2);
    for (String el : s2) {
        System.out.println(el);
    }
    // 修改元素
    arr.set(0, "30");
    // 删除元素
    arr.remove(0);
    arr.add("goodbye");
    // 清空数组
    // arr.clear();
    arr.add("afternoon");
    // 获取元素
    System.out.println(arr.get(0));
    // 获取数组的大小
    System.out.println(arr.size());
    // 数组排序: sort() 方法可以对字符或数字列表进行排序
    Collections.sort(arr);
    System.out.println(arr);
    // 获取数组的子数组
    System.out.println(arr.subList(1, arr.size()));
    // arraylist转化成字符串
    System.out.println(arr.toString());
    // 返回元素的索引值
    System.out.println(arr.indexOf("hello"));

    // 链表（Linked list）是一种常见的基础数据结构，是一种线性表，但是并不会按线性的顺序存储数据，
    // 而是在每一个节点里存到下一个节点的地址. 特点: 查询速度慢, 插入和删除速度快
    // 以下情况使用 LinkedList :
    // 1.你需要通过循环迭代来访问列表中的某些元素。
    // 2.需要频繁的在列表开头、中间、末尾等位置进行添加和删除元素操作。
    // LinkedList 的方法
    LinkedList<String> l = new LinkedList<>();
    // 末尾添加元素
    l.add("hello");
    // 指定位置添加元素
    l.add(0, "tom");
    // 将集合的所有元素添加到链表指定位置
    System.out.println(l.addAll(l));
    // 链表转化为数组
    String[] str_arr = l.toArray(new String[l.size()]);
    for (String el : str_arr) {
        System.out.println(el);
    }
    // 获取元素
    l.get(0);
    // 返回元素的索引
    l.indexOf("hello");
    // 修改元素的值
    l.set(0, "10");
    // 元素的个数
    l.size();
    // 删除元素
    l.remove(0);
    l.removeLast();
    // 清空链表
    l.clear();

    // 集合: hashSet 基于 HashMap 来实现的，是一个不允许有重复元素的集合。
    // HashSet 允许有 null 值。
    // HashSet 是无序的，即不会记录插入的顺序。
    // HashSet 不是线程安全的， 如果多个线程尝试同时修改 HashSet，则最终结果是不确定的
    // 集合的方法与数组类似
    HashSet<String> set01 = new HashSet<>();
    set01.add("hello");
    set01.remove("hello");
    set01.size();

    // 字典: HashMap 是一个散列表，它存储的内容是键值对(key-value)映射。
    // HashMap 实现了 Map 接口，根据键的 HashCode 值存储数据，具有很快的访问速度，最多允许一条记录的键为 null，不支持线程同步。
    // HashMap 是无序的，即不会记录插入的顺序
    HashMap<Integer, String> dic = new HashMap<>();
    // 添加或者修改元素
    dic.put(1, "Hello");
    dic.put(2, "tom");
    dic.put(3, "jerry");
    // 获取元素
    System.out.println(dic.get(1));
    // 删除元素
    dic.remove(1);
    // 字典的大小
    dic.size();
    // 字典的遍历
    for (Integer key : dic.keySet()) {
        System.out.println("dic["+ key +"]= " + dic.get(key) );
    }
    // 清空字典
    dic.clear();

    // 泛型
    // 下面是定义泛型方法的规则：
    // 所有泛型方法声明都有一个类型参数声明部分（由尖括号分隔），该类型参数声明部分在方法返回类型之前（在下面例子中的 <E>）。
    // 每一个类型参数声明部分包含一个或多个类型参数，参数间用逗号隔开。一个泛型参数，也被称为一个类型变量，是用于指定一个泛型类型名称的标识符。
    // 类型参数能被用来声明返回值类型，并且能作为泛型方法得到的实际参数类型的占位符。
    // 泛型方法体的声明和其他方法一样。注意类型参数只能代表引用型类型，不能是原始类型（像 int、double、char 等）。
    // java 中泛型标记符：
    // E - Element (在集合中使用，因为集合中存放的是元素)
    // T - Type（Java 类）
    // K - Key（键）
    // V - Value（值）
    // N - Number（数值类型）
    // ？ - 表示不确定的 java 类型
    // 有界的类型参数: 首先列出类型参数的名称，后跟extends(类), implements(接口)关键字，最后紧跟它的上界
    // <? extends T>表示该通配符所代表的类型是T类型的子类。
    // <? super T>表示该通配符所代表的类型是T类型的父类。
    // 泛型方法
    public static <T extends Comparable<T>> T max( T x, T y, T z ) {
        T max= x;
        if ( y.compareTo(max) > 0 ) {
            max= y;
        }
        if ( z.compareTo(max) > 0 ) {
            max= z;
        }
        return max;
    }
    // 泛型类
    public class Box <T, V>{
        private T t;
        private V v;

        public T getT() {
            return t;
        }

        public void setT(T t) {
            this.t = t;
        }

        public V getV() {
            return v;
        }

        public void setV(V v) {
            this.v = v;
        }

        public static void main(String[] args) {
            Box<Integer, String> integerBox = new Box<>();
            integerBox.setT(123);
            integerBox.setV("tom");
            System.out.println(integerBox.getT());
            System.out.println(integerBox.getV());
        }
    }

    // 反射
    // 反射机制相关的重要的类: java.lang.Class, java.lang.reflect.Method,
    // java.lang.reflect.Constructor, java.lang.reflect.Field
    // 获取类的方法:
    // 第一种：Class c = Class.forName("完整类名带包名"); 这个方法的执行会导致类加载，类加载时，静态代码块执行
    // 第二种：Class c = 对象.getClass();
    String s01= new String("123");
    System.out.println(s01.getClass());
    // 第三种：Class c = 任何类型.class;
    System.out.println(String.class);
    // Class 的方法
    // public T newInstance()	创建对象
    // public String getName()	返回完整类名带包名
    // public Field[] getDeclaredFields()	返回类中所有的属性
    // public Field getDeclaredField(String name)	根据属性名name获取指定的属性
    // public Method[] getDeclaredMethods()	返回类中所有的实例方法
    // public Method getDeclaredMethod(String name, Class<?>… parameterTypes)	根据方法名name和方法形参获取指定方法
    userServiceClass.getDeclaredMethod("login", String.class, String.class);
    // public Constructor<?>[] getDeclaredConstructors()	返回类中所有的构造方法
    // public Constructor getDeclaredConstructor(Class<?>… parameterTypes)	根据方法形参获取指定的构造方法
    // public native Class<? super T> getSuperclass()	返回调用类的父类
    // public Class<?>[] getInterfaces()	返回调用类实现的接口集合
    // Method 的方法
    // public Object invoke(Object obj, Object… args)	调用方法
    Object resValues = loginMethod.invoke(obj, "admin", "123");

    // 注解类
    // 注解类的组成部分:
    // 修饰符：访问修饰符必须为public,不写默认为pubic；
    // 关键字：关键字为@interface；
    // 注解名称： 注解名称为自定义注解的名称，使用时还会用到；
    // 注解类型元素： 注解类型元素是注解中内容，可以理解成自定义接口的实现部分；
    // 注解类的示例:
    public @interface Info {
        String value() default "tracy";
        boolean isDelete();
    }
    // 元注解: @Target，@Retention,@Document,@Inherited
    // @Target：表明该注解可以应用的java元素类型;  @Target({ ElementType.Type }), ElementType 代表应用于包, 接口(包括注解类型), 类
    // @Retention：表明该注解的生命周期
    // @Document：表明该注解标记的元素可以被Javadoc 或类似的工具文档化
    // @Inherited：表明使用了 @Inherited 注解的注解，所标记的类的子类也会拥有这个注解
    // 注意: 自定义注解中，设置了默认值的属性在使用时可以不用定义值，但是没被设置默认值的属性使用时一定要定义属性值。

    ```
##### 4.3 设计模式

##### 4.4 算法与数据结构


---
#### 5. SpringBoot 框架
##### 5.1 SpringBoot 基本知识 
- Springboot 框架的参考地址: <b style="color: green;" >🥦 [狂神说 ](https://blog.csdn.net/qq_41978509/article/details/116104434) 🥦</b>  
- pom.xml文件的常用配置选项:
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.example</groupId>
        <artifactId>demo</artifactId>
        <packaging>pom</packaging>
        <version>0.0.1-SNAPSHOT</version>
        <modules>
            <module>demo01</module>
            <module>demo02</module>
        </modules>
        <name>demo</name>
        <description>Demo project for Spring Boot</description>
        <properties>
            <java.version>1.8</java.version>
            <!--springboot-->
            <spring-boot-starter-web.version>2.7.3</spring-boot-starter-web.version>
            <spring-boot-starter-test.version>2.7.3</spring-boot-starter-test.version>
            <!--数据库-->
            <spring-boot-starter-jdbc.version>2.7.3</spring-boot-starter-jdbc.version>
            <mysql-connector-java.version>8.0.30</mysql-connector-java.version>
            <mybatis-spring-boot-starter.version>2.2.2</mybatis-spring-boot-starter.version>
            <druid.version>1.2.12</druid.version>
            <spring-boot-starter-data-redis.version>2.7.3</spring-boot-starter-data-redis.version>
            <lombok.version>1.18.24</lombok.version>
            <!--安全验证-->
            <spring-boot-starter-security.version>2.7.3</spring-boot-starter-security.version>
            <thymeleaf-extras-springsecurity5.version>3.0.4.RELEASE</thymeleaf-extras-springsecurity5.version>
            <spring-security-test.version>5.7.3</spring-security-test.version>
            <!--模板引擎-->
            <spring-boot-starter-thymeleaf.version>2.7.3</spring-boot-starter-thymeleaf.version>
            <!--Swagger3 依赖-->
            <springfox-boot-starter.version>3.0.0</springfox-boot-starter.version>
            <!--spring-cloud-->
            <spring-cloud-starter-zookeeper-config.version>3.1.3</spring-cloud-starter-zookeeper-config.version>
            <spring-boot-starter-amqp.version>2.7.3</spring-boot-starter-amqp.version>
            <spring-rabbit-test.version>2.4.7</spring-rabbit-test.version>
            <spring-kafka.version>2.9.1</spring-kafka.version>
            <spring-kafka-test.version>2.9.1</spring-kafka-test.version>
            <spring-cloud.version>2021.0.3</spring-cloud.version>
        </properties>

        <dependencyManagement>
            <dependencies>

                <!--springboot 基本依赖-->
                <!--springboot-web依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-web</artifactId>
                    <version>${spring-boot-starter-web.version}}</version>
                </dependency>
                <!--springboot-test 依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-test</artifactId>
                    <version>${spring-boot-starter-test.version}</version>
                </dependency>

                <!--数据库-->
                <!--jdbc依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-jdbc</artifactId>
                    <version>${spring-boot-starter-jdbc.version}</version>
                </dependency>
                <!--mysql驱动依赖-->
                <dependency>
                    <groupId>mysql</groupId>
                    <artifactId>mysql-connector-java</artifactId>
                    <version>${mysql-connector-java.version}</version>
                </dependency>
                <!--springboot-mybatis 依赖-->
                <dependency>
                    <groupId>org.mybatis.spring.boot</groupId>
                    <artifactId>mybatis-spring-boot-starter</artifactId>
                    <version>${mybatis-spring-boot-starter.version}</version>
                </dependency>
                <!--数据库连接池-->
                <dependency>
                    <groupId>com.alibaba</groupId>
                    <artifactId>druid</artifactId>
                    <version>${druid.version}</version>
                </dependency>
                <!--redis 依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-data-redis</artifactId>
                    <version>${spring-boot-starter-data-redis.version}</version>
                </dependency>
                <!--lombok 依赖-->
                <dependency>
                    <groupId>org.projectlombok</groupId>
                    <artifactId>lombok</artifactId>
                    <version>${lombok.version}</version>
                </dependency>

                <!--安全验证-->
                <!--security依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-security</artifactId>
                    <version>${spring-boot-starter-security.version}</version>
                </dependency>
                <dependency>
                    <groupId>org.thymeleaf.extras</groupId>
                    <artifactId>thymeleaf-extras-springsecurity5</artifactId>
                    <version>${thymeleaf-extras-springsecurity5.version}</version>
                </dependency>
                <dependency>
                    <groupId>org.springframework.security</groupId>
                    <artifactId>spring-security-test</artifactId>
                    <version>${spring-security-test.version}</version>
                </dependency>

                <!--模板引擎-->
                <!--thymeleaf依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-thymeleaf</artifactId>
                    <version>${spring-boot-starter-thymeleaf.version}</version>
                </dependency>

                <!--Swagger3 依赖-->
                <dependency>
                    <groupId>io.springfox</groupId>
                    <artifactId>springfox-boot-starter</artifactId>
                    <version>${springfox-boot-starter.version}</version>
                </dependency>

                <!--springboot-cloud-->
                <!--zookeeper 依赖-->
                <dependency>
                    <groupId>org.springframework.cloud</groupId>
                    <artifactId>spring-cloud-starter-zookeeper-config</artifactId>
                    <version>${spring-cloud-starter-zookeeper-config.version}</version>
                </dependency>
                <!--消息队列-->
                <!--rabbitMQ 依赖-->
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-amqp</artifactId>
                    <version>${spring-boot-starter-amqp.version}</version>
                </dependency>
                <dependency>
                    <groupId>org.springframework.amqp</groupId>
                    <artifactId>spring-rabbit-test</artifactId>
                    <version>${spring-rabbit-test.version}</version>
                </dependency>
                <!--kafka 依赖-->
                <dependency>
                    <groupId>org.springframework.kafka</groupId>
                    <artifactId>spring-kafka</artifactId>
                    <version>${spring-kafka.version}</version>
                </dependency>
                <dependency>
                    <groupId>org.springframework.kafka</groupId>
                    <artifactId>spring-kafka-test</artifactId>
                    <version>${spring-kafka-test.version}</version>
                </dependency>
                <!--springboot-cloud 依赖-->
                <dependency>
                    <groupId>org.springframework.cloud</groupId>
                    <artifactId>spring-cloud-dependencies</artifactId>
                    <version>${spring-cloud.version}</version>
                </dependency>
            </dependencies>
        </dependencyManagement>

    </project>
    
    ```
- application.yml 的常见配置
    ```yaml
    spring:
      profiles:
        active: dev
      datasource:   # mysql数据库配置
        username: root
        password: wangxi@678994
        driver-class-name: com.mysql.jdbc.Driver
        url: jdbc:mysql://182.61.148.121:3306/mybatis?serverTimezone=GMT%2B8&useSSL=True&useUnicode=true&characterEncoding=UTF-8
        type: com.alibaba.druid.pool.DruidDataSource

        initialSize: 5   # druid 数据源专有配置, Spring Boot 默认是不注入这些属性值的，需要自己绑定
        minIdle: 5
        maxActive: 20
        maxWait: 60000
        timeBetweenEvictionRunsMillis: 60000
        minEvictableIdleTimeMillis: 300000
        validationQuery: SELECT 1 FROM DUAL
        testWhileIdle: true
        testOnBorrow: false
        testOnReturn: false
        poolPreparedStatements: true

      redis:   #指定redis信息 (如 host, ip, password)
        host: 182.61.148.121
        port: 6379
        password: 123456  #没有密码可以不用配置这个

      thymeleaf:   # thymeleaf关闭缓存
        cache: false
      mvc:  # 自定义 icon
        favicon:
          enabled: false
        pathmatch:  # Swagger3 与 springboot 2.7 兼容的问题
          matching-strategy: ant_path_matcher
      messages:   # 国际化
        basename: i18n.login

    mybatis:    # mybatis 的配置
      mapper-locations: classpath:mapper/*Mapper.xml,classpath:mapper/user/*.xml # file: 指当前项目根目录; classpath: 指当前项目的类路径，即 resources 目录
      type-aliases-package: com.example.demo.pojo   # type-aliases-package：指定POJO扫描包来让 mapper.xml 文件的 resultType 自动扫描到自定义POJO，这样就不用每次指定完全限定名
    ---
    server:
      port: 8083
    spring:
      profiles: dev #配置环境的名称
    ---
    server:
      port: 8084
    spring:
      profiles: prod  #配置环境的名称
    ```
- springboot 的启动类
    ```java
    /**
    * Spring Boot应用启动类
    * Created by bysocket on 16/4/26.
    * 文件: com.example.Application.java
    */
    @SpringBootApplication
    public class Application {
        public static void main(String[] args) {
            SpringApplication.run(Application.class,args);

        }
    }

    // springboot 启动类的分析
    // @SpringBootConfiguration
    //      @Configuration
    //          @Component
    //      自动配置
    //      @EnableAutoConfiguration
    //           @AutoConfigurationPackage 
    //      	        @Import(AutoConfigurationPackages.Registrar.class)
    //           自动配置导入选择
    //           @Import(AutoConfigurationImportSelector.class)
    //               selectImports(): AutoConfigurationImportSelector的selectImports()方法通过SpringFactoriesLoader.loadFactoryNames()扫描所有具有
    //                   META-INF/spring.factories的jar包。spring-boot-autoconfigure-x.x.x.x.jar里就有一个这样的spring.factories文件
      
    ```
##### 5.2 SpringBoot 进阶知识
- 实体类的自动注入
  - java 文件
    ```java
    /*
        @ConfigurationProperties作用：
        将配置文件中配置的每一个属性的值，映射到这个组件中；
        告诉SpringBoot将本类中的所有属性和配置文件中相关的配置进行绑定
        参数 prefix = “person” : 将配置文件中的person下面的所有属性一一对应
        文件: com.example.pojo.User.java
    */
    @Component // 注册bean
    @ConfigurationProperties(prefix = "person") // 注入 application.yaml 中的数据
    public class Person {
        private String name;
        private Integer age;
        private Boolean happy;
        private Date birth;
        private Map<String,Object> maps;
        private List<Object> lists;
        private Dog dog;

        // get、set方法、toString()方法
    }

    // 测试类: com.example.SpringbootDemoApplicationTests.java
    @SpringBootTest
    class SpringbootDemoApplicationTests {
        @Autowired
        private Persion persion;
        @Test
        void contextLoads() {
            System.out.println("######################################");
            System.out.println(persion);
        }

    }

    ```
  - 配置文件
    ```yaml
    # 配置文件: resources/application.yaml
    server:
      port: 8080
    persion:   # Persion实体类
      name: wewoe
      age: 13
      happy: true
      birthday: 1920/12/13
      map: { name: jwoewoe, address: woewewo12536 }
      list: [ "1", "2" ]
      dog:
        name: 小黑
        age: 23
    ```
- httpMVC 自定义配置类
    ```java
    // 自定义配置类: com.example.config.MyMvcConfigurer.java
    @Configuration
    public class MyMvcConfigurer implements WebMvcConfigurer {
        /**
        * 自定义视图控制器
        * @param registry
        */
        @Override
        public void addViewControllers(ViewControllerRegistry registry) {
            // 页面访问"/test" 会跳转到"/test.html"
            registry.addViewController("/test").setViewName("test");
        }

        /**
        * 自定义语言
        * @return
        */
        @Bean
        public LocaleResolver localeResolver() {
            return new MyLocaleResolver();
        }
    }

    // 自定义语言解析类: com.example.config.MyLocaleResolver.java
    public class MyLocaleResolver implements LocaleResolver {
        // 进行语言切换
        @Override
        public Locale resolveLocale(HttpServletRequest request) {
            String lang = request.getParameter("lang");
            Locale locale = Locale.getDefault();
            if ( lang != null && lang != ""){
                String[] s = lang.split("_");
                locale = new Locale(s[0],s[1]);
            }
            return locale;
        }

        @Override
        public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {

        }
    }

    /**
     * 跨域访问
     * @param registry
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedHeaders("*")
                .allowedMethods("*")
                .allowCredentials(false)
                .maxAge(1800)
                .allowedOrigins("*");
    }

    ```
- Swagger 的配置类
    ```java
    // 自定义配置类: com.example.config.SwaggerConfig.java
    @Configuration
    @EnableOpenApi
    public class SwaggerConfig {
        @Bean
        public Docket createRestApis(Environment environment) {
            return new Docket(DocumentationType.OAS_30)
                    .enable(getEnv(environment))//是否启用：注意生产环境需要关闭
                    .groupName("spring-boot-2.7.3")
                    .apiInfo(apiInfo())
                    .select()
                    .apis(RequestHandlerSelectors.basePackage("com.example.demo.controller"))
    //                .paths(PathSelectors.any())
                    // 只扫面 "/user/**" 路径下
                    .paths(PathSelectors.ant("/user/**"))
                    .build();
        }

        @Bean
        public Docket createRestApis01(Environment environment) {
            return new Docket(DocumentationType.OAS_30)
                    .enable(getEnv(environment))//是否启用：注意生产环境需要关闭
                    .groupName("spring-boot-2.7.3-v1")
                    .apiInfo(apiInfo01())
                    .select()
                    .apis(RequestHandlerSelectors.basePackage("com.example.demo.controller"))
                    .paths(PathSelectors.any())
                    .build();
        }

        private ApiInfo apiInfo() {
            return new ApiInfoBuilder()
                    .title("使用swagger生成的接口文档")
                    .description("开发测试")
                    // 服务条款URL
                    .termsOfServiceUrl("https://www.baidu.com/")
                    // 作者信息
                    .contact(new Contact("qihh", "https://www.baidu.com/", "qihh@136.com"))
                    .version("0.0.1")
                    .build();
        }

        private ApiInfo apiInfo01() {
            return new ApiInfoBuilder()
                    .title("使用swagger生成的接口文档-v1")
                    .description("开发测试")
                    // 服务条款URL
                    .termsOfServiceUrl("https://www.baidu.com/")
                    // 作者信息
                    .contact(new Contact("qihh", "https://www.baidu.com/", "qihh@136.com"))
                    .version("0.0.1-v1")
                    .build();
        }

        public boolean getEnv(Environment environment){
            Profiles profiles = Profiles.of("dev");
            return environment.acceptsProfiles(profiles);
        }
    }
    
    ```

##### 5.4 thymeleaf 模板引擎
- 模板引擎的引入: 常通过 controller 引入
    ```java
    // Controller 类
    // 文件: com.example.controller.HelloController.java
    @Controller   // 不是 @RestController, RestController 是生成接口的类
    public class HelloController {
        @GetMapping(path = { "/", "/index" })
        //  @ResponseBody  返回值不是html的模板, 而是响应体
        public String index(Model model) {
            model.addAttribute("names", Arrays.asList("hellw", 123, 789));
            HashMap<String, Object> map = new HashMap<>();
            map.put("name", "鞋子");
            map.put("price", "$12");
            model.addAttribute("goods", map);
            System.out.println("123");
            return "index";
        }
    }  
    ```
- thymeleaf 模板引擎的语法
    ```html
    <!-- 开头引入配置 -->
    <html xmlns:th="http://www.thymeleaf.org">
    <!-- 引入路径 -->
    <link rel="icon" th:href="@{/favicon.ico}">
    <link rel="stylesheet" th:href="@{/css/3.css}">
    
    <!-- 获取值: th:text, th:utext(不转义), th:value -->

    <!-- 字典的遍历 -->
    <h2>
        <p>Name: <span th:text="${user.name}"></span>.</p>
        <p>Age: <span th:text="${user.age}"></span>.</p>
        <p>friend: <span th:text="${user.friend.name}"></span>.</p>
    </h2>
    <!-- 循环遍历 -->
    <tr th:each="user : ${users}">
        <td th:text="${user.name}"></td>
        <td th:text="${user.age}"></td>
    </tr>
    <!-- 三元运算符 -->
    <span th:text="${user.sex} ? '男':'女'"></span>

    <!-- 国际化 -->
    <form action="#" method="post">
        <label for="username">
            <span th:text="#{login.username}" ></span>: <input type="text" name="username" id="username" th:placeholder="#{login.username}"><br>
        </label>
        <label for="password">
            <span th:text="#{login.password}" ></span>: <input type="password" name="password" id="password" th:placeholder="#{login.password}" ><br>
        </label>
        <label for="remember">
            <input type="checkbox" name="" id="remember"><span th:text="#{login.remember}" ></span>
        </label><br>
        <button type="submit" th:text="#{login.submit}" ></button><br>
        <a th:href="@{/index(lang=en_US)}" th:text="English"></a>
        <a th:href="@{/index(lang=zh_CN)}" th:text="中文"></a>
    </form>

    ```
##### 5.5 SpringMVC 实现
- java 文件
    ```java
    // 文件目录树
    // ├─java
    // │  └─com
    // │      └─example
    // │          └─demo
    // │              ├─config
    // │              ├─controller
    // │              ├─mapper
    // │              ├─pojo
    // │              └─service
    // └─resources
    //     ├─i18n
    //     ├─mapper
    //     ├─static
    //     │  └─css
    //     └─templates

    // 实体类
    // 文件: com.example.demo.pojo.User.java
    @Data   // lombok 插件的使用
    @AllArgsConstructor
    @NoArgsConstructor
    @ApiModel("用户信息")  // 进入swagger
    public class User {
        @ApiModelProperty("用户id")
        private Integer id;
        @ApiModelProperty("用户名")
        private String username;
        @ApiModelProperty("用户密码")
        private String password;
        @ApiModelProperty("用户真实姓名")
        private String realname;

    }

    // Mapper 类
    // 文件: com.example.demo.mapper.UserMapper.java
    @Mapper
    @Repository
    public interface UserMapper {
        User getUserByID(int id);
        User getUserByMap(Map<String, Object> map);
        List<User> getUser();
        int insertUser(User user);
        int updateUser(User user);
        int deleteUser(User user);
    }
    // Service 类
    // 文件: com.example.demo.service.UserService.java
    @Service
    public class UserService {
        @Autowired
        UserMapper userMapper;

        public User getUserByID(int id){
            return userMapper.getUserByID(id);
        }
        public List<User> getUser(){
            return userMapper.getUser();
        }
        public User getUserByMap(Map<String, Object> map){
            return userMapper.getUserByMap(map);
        }
        public int insertUser(User user){
            return userMapper.insertUser(user);
        }

        public int updateUser(User user){
            return userMapper.updateUser(user);
        }

        public int deleteUser(User user){
            return userMapper.deleteUser(user);
        }
    }
    // Controller 类
    // 文件: com.example.demo.controller 
    // 接口设计的模板
    @RestController
    @RequestMapping("/usermgr")
    @Api(tags = "用户管理")
    public class UserController {
        @Autowired
        UserService userService;

        @GetMapping( "/users/{user_id}")
        @ApiOperation("查询用户详情")
        @ApiImplicitParams({
            @ApiImplicitParam(name = "user_id", value = "用户id"),
            @ApiImplicitParam(name = "token", value = "用户身份凭证")
        })
        public Object getUserByID(@PathVariable int user_id , @RequestHeader String token ) {
            User data= userService.getUserByID(user_id);
            if (data != null ) {
                return data;
            }
            return "查询数据为空 !";
        }

        @GetMapping("/users")
        @ApiOperation("查询用户列表")
        @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "用户名"),
            @ApiImplicitParam(name = "token", value = "用户身份凭证")
        })
        public Object getUser(@RequestParam(required = false) String name, @RequestHeader String token ) {
            List<User> data = userService.getUser();
            if (data != null ) {
                return data;
            }
            return "查询数据为空 !";
        }

        @PostMapping("/users")
        @ApiOperation("创建用户")
        @ApiImplicitParams({
            @ApiImplicitParam(name = "user", value = "用户信息"),
            @ApiImplicitParam(name = "token", value = "用户身份凭证")
        })
        public String insertUser(@RequestBody User user, @RequestHeader String token ) {
            int flag = userService.insertUser(user);
            if (flag != 0) {
                return "数据添加成功 !";
            }
            return "数据添加失败 !";
        }

        @PutMapping("/users/{user_id}")
        @ApiOperation("更新用户")
        @ApiImplicitParams({
            @ApiImplicitParam(name = "user_id", value = "用户id"),
            @ApiImplicitParam(name = "user", value = "用户信息"),
            @ApiImplicitParam(name = "token", value = "用户身份凭证")
        })
        public String updateUser(@RequestParam int user_id ,@RequestBody User user ,@RequestHeader String token ) {
            user.setId(user_id);
            int flag = userService.updateUser(user);
            if (flag != 0) {
                return "数据更新成功 !";
            }
            return "数据更新失败 !";
        }

        @DeleteMapping("/users/{user_id}")
        @ApiOperation("删除用户")
        @ApiImplicitParams({
            @ApiImplicitParam(name = "user_id", value = "用户id"),
            @ApiImplicitParam(name = "token", value = "用户身份凭证")
        })
        public String deleteUser(@PathVariable int user_id, @RequestHeader String token ) {
            User user = new User(user_id, null, null, null);
            int flag = userService.deleteUser(user);
            if (flag != 0) {
                return "删除数据成功 !";
            }
            return "删除数据失败 !";
        }
    }
    ```
- 配置文件
    ```xml
    <!-- xml 配置文件
    文件名: mapper/UserMapper.xml -->
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
    <mapper namespace="com.example.demo.mapper.UserMapper">

        <select id="getUserByID" parameterType="int" resultType="User">
            SELECT * FROM `user` where id = #{id}
        </select>
        <select id="getUser" resultType="User">
            SELECT * FROM `user`
        </select>
        <select id="getUserByMap" parameterType="Map" resultType="User">
            SELECT * FROM `user` where id = #{id} or username=#{username}
        </select>
        <insert id="insertUser" parameterType="User">
            INSERT INTO `user`(`id`, `userName`, `passWord`, `realName`) VALUES ( NULL, #{username},#{password}, #{realname})
        </insert>
        <update id="updateUser" parameterType="User">
            UPDATE `user` SET `userName`= #{username} WHERE id = #{id}
        </update>
        <delete id="deleteUser" parameterType="User">
            DELETE FROM `user` WHERE id = #{id}
        </delete>
    </mapper>   
    ```
##### 5.5 Shiro 框架
- shiro 三大要素
  - `subject -> ShiroFilterFactoryBean` ----当前用户
  - `securityManager -> DefaultWebSecurityManager` ----管理所有用户
  - `Realm` --- 用户认证和授权
  - 实际操作中对象创建的顺序 ： `realm -> securityManager -> subject` ----连接数据
- shiro 整合 Springboot

##### 5.6 Springsecurity


---
#### 6. Java 自动化
##### 6.1 单元测试框架
- Testng 框架的使用
  - java 文件
    ```java
    @BeforeSuite / @AfterSuite: 在套件运行之前/后运行 
    @BeforeTest / @AfterTest: 在每个test运行之前/后运行
    @BeforeClass / @AfterClass: 在类运行之前/后运行, 当前类
    @BeforeMethod / @AfterMethod: 在测试方法之前/后运行, 当前类中所有方法
    @Test: 单元测试注解
    @Test(enable= false): 跳过测试用例
    @Test(dependsOnMethods = { "testLogin02" }): 测试用例的依赖, 如果被依赖方法执行失败，有依赖关系的方法不会被执行
    // 数据驱动
    @Test(dataProvider = "getData")
    public void test02(String name, int age) {
        System.out.printf("name: %s, age: %d\n", name, age);
    }

    @DataProvider
    public Object[][] getData(){
         return  new Object[][]{
            { "wewe", 25},
            { "tioto", 36}
        };
    }

    ```
  - 配置文件: `resources/testng.xml`
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE suite SYSTEM "http://testng.org/testng-1.0.dtd">
    <suite name="All Test Suite">
        <test name="test">
            <classes>
                <class name="com.qzcsbj.TestAnnotation"/>
            </classes>
        </test>
        <test name="test2">
            <classes>
                <class name="com.qzcsbj.TestAnnotationB">
                    <methods>
                        <include name="testb"/>  <!--指定要运行的方法-->
                    </methods>
                </class>
            </classes>
        </test>
    </suite>
    
    ```

##### 6.2 UI 自动化框架

---
#### 7. Springboot 项目实战