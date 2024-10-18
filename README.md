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
2. 部署ldap
docker run \
-p 389:389 \
-p 636:636 \   # ssl证书认证端口
--name ldap \
--hostname openldap-host \
--env LDAP_ORGANISATION="example" \
--env LDAP_DOMAIN="example.com" \          # ldap域名
--env LDAP_ADMIN_PASSWORD="123456" \       # admin密码
--volume /root/ssl:/container/service/slapd/assets/certs \   # 挂载证书
--env LDAP_TLS_CRT_FILENAME=tls.crt \      # 服务端证书名
--env LDAP_TLS_KEY_FILENAME=tls.key \      # 客户端证书名
--env LDAP_TLS_CA_CRT_FILENAME=ca.pem \    # ca证书名
--env LDAP_TLS_VERIFY_CLIENT=never \       # 服务端不验证客户端证书
--detach osixia/openldap:1.3.0

# ldap客户端工具
docker run \
-d \
--privileged \
-p 8080:80 \
--name phpldapadmin \
--env PHPLDAPADMIN_HTTPS=false \     # 关闭https认证
--env PHPLDAPADMIN_LDAP_HOSTS=192.168.106.150 \  # LDAP服务ip或者域名
--detach osixia/phpldapadmin:0.9.0
```
