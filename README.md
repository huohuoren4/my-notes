#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)

##### 开源项目
- ldap: https://blog.csdn.net/weixin_42257195/article/details/102769495
- dex: https://dexidp.io/docs/guides/kubernetes/
- https://github.com/osixia/docker-openldap?tab=readme-ov-file#set-your-own-environment-variables
- https://github.com/osixia/docker-phpLDAPadmin

- https://www.ldapclient.com/downloads78/LdapBrowser-7.8.x-win-x64-Setup.exe
活动目录AD（Active Directory）是微软服务的核心组件。使用AD域能实现高效管理，例如批量管理用户和计算机、部署应用、更新补丁、统一文件和资源访问等。许多微软组件（例如Exchange）和故障转移集群也需要AD域环境。本文以Windows Server 2016数据中心版操作系统为例，介绍如何搭建AD域，并将客户端加入该AD域
```
https://github.com/mintel/dex-k8s-authenticator/blob/master/docs/config.md
```

部署openldap服务

```
远程连接作为域控制器的ECS实例。

具体操作，请参见连接方式概述。

打开服务器管理器。

在桌面左下角单击搜索.jpg图标，在搜索框输入服务器管理器，然后单击服务器管理器。打开服务器管理器.png

在服务器管理器中，为服务器添加角色和功能。

本文以将AD域服务和DNS服务部署在同一台服务器上为例，操作步骤如下：

重要
除额外说明的配置外，部分配置步骤已省略，配置时保持默认配置，单击下一步即可。

单击添加角色和功能。添加角色和功能.png

选择安装类型。安装类型.png

选择要安装角色和功能的服务器。

选择服务器.png

选中要安装在服务器上的角色，即Active Directory 域服务和DNS 服务器。

勾选服务器角色.png

安装完成后，单击关闭。

安装成功.png

将ECS实例设置为域服务器。

重要
除额外说明的配置外，部分配置步骤已省略，配置时保持默认配置，单击下一步即可。

单击服务器管理器右上角的警告图标.png图标，然后单击将此服务器提升为域控制器。提升为域控制器.png

在Active Directory 域服务配置向导中，选择添加新林，并在根域名中设置域名。

本文操作中，AD域的示例域名为example.com。根域名.png

配置域服务器参数，然后单击下一步。配置域服务器参数.png

配置DNS选项，然后单击下一步。配置DNS选项.png

配置NetBIOS域名，然后单击下一步。配置NetBIOS域名.png

检查并确认您的选择，单击下一步。确认选择.png

所有先决条件都检查通过后，单击安装。单击安装.png

安装完成后将自动重启该服务器，重新连接该服务器后可以在系统配置中查看安装结果，当您的DC相关信息无误时，表示安装成功，如下图所示。

```
