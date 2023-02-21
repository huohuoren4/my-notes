#### VSCode常用插件
##### 1. Markdown 插件
- Markdown All in One: 方便输入markdown语法
- Markdown Preview Enhanced: 预览markdown文件, 导出html文件
  - 打开配置, 搜索 `enableScriptExecution` 并将其设置为 true
- Paste Image: 方便粘贴(`ctr + alt + v`)图片, 可以设置图片粘贴路径

##### 2. 前端插件
- HTML CSS Support: html, css 语法提示
- JavaScript(ES6) code snippets: 原生js语法提示
- Live Server: 起一个简单的http服务器
- Vetur: vue 管理工具

##### 3. 程序运行插件
- Code Runner: 不同语言的执行命令可以自己设置
  - `Run in Termimal`中设置为true, 能够在终端中执行命令
  - 如果使用code runner执行命令出现乱码, 在终端中输入`chcp 65001`设置utf-8, 在执行code runner
- Go: goland 的插件
  - 使用快捷键`ctr + shift + P`, 输入 `go tools`, 勾选所有的插件
- C/C++: Clang插件, 
- CMake: makefile插件
- CMake Tools: makefile插件

##### 4. 其他插件
- Path Intellisense: 路径插件
- Docker: 写dockerfile, docker-compose.yaml文件, 有语法提示
- Git Graph: git 版本树

#### Goland-2020.1的破解教程
##### 操作步骤
1. 打开Goland, 点击"试用". 进入Goland的首页, 将"Crack"文件夹中的"jetbrains-agent.jar"拖入首页, 点击安装再重启软件. 通过菜单栏`帮助>注册`, 查看证书是否安装成功.
2. 修改"GoRoot"路径下`D:\Go\src\runtime\internal\sys\zversion.go`文件, 末尾添加一行版本信息: "const TheVersion = \`go1.17.6\`", 就可以使用Goland中的设置添加"GoRoot"的路径了.