## my-config
#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)
- [Python-3.7.13文档](https://docs.python.org/zh-cn/3.7/)

---
#### 2. 主要内容
##### 2.2 windows 相关知识
- win10 hosts文件路径: `C:/windows/system32/drivers/etc`

##### 2.4 接口自动化开源项目
- 接口自动化框架: [pytest-auto-api2](https://gitee.com/yu_xiao_qi/pytest-auto-api2?_from=gitee_search)
  - [接口自动化框架技术博客](https://blog.csdn.net/weixin_43865008/article/details/123904871?spm=1001.2014.3001.5501)
- web 自动化框架:  <https://gitee.com/wxhou/web-demotest.git>

---
#### 3. 补充内容
- pytorch博客: https://blog.csdn.net/mengxianglong123/article/details/126034288
- python3 unittest模块解析：https://blog.csdn.net/qq_41437305/article/details/96368903
- python技术博客：https://www.cnblogs.com/wdliu/category/934310.html?page=1
- python HTTP代理：https://blog.csdn.net/xuezhangjun0121/article/details/128871916

#### 4. 代理配置
```shell
http://192.168.0.184:8080/prometheusalert?type=dd&tpl=prometheus-dd&ddurl=https://oapi.dingtalk.com/robot/send?access_token=f0089d1196f8900b9d7e02306a74058c333ff0114e0243c25da625b262293009

# gangway
https://github.com/vmware-archive/gangway?tab=readme-ov-file
```
##### test
```yaml
https://kubernetes.io/docs/reference/access-authn-authz/authentication/#openid-connect-tokens
dex.example.com

5. 修改apiserver
所有master节点修改/etc/kubernetes/manifests/kube-apiserver.yaml的启动参数

- --oidc-issuer-url=https://dex.example.com:32000
- --oidc-client-id=kubernetes
- --oidc-ca-file=/etc/kubernetes/ssl/ca.pem
- --oidc-username-claim=email
- --oidc-groups-claim=groups
```

```
-----BEGIN CERTIFICATE-----
MIIDBTCCAe2gAwIBAgIUbqBkS+cVwVpdSai+fF53++thJDUwDQYJKoZIhvcNAQEL
BQAwEjEQMA4GA1UEAwwHa3ViZS1jYTAeFw0yNDEwMDkwNjAwMDJaFw0yNDEwMTkw
NjAwMDJaMBIxEDAOBgNVBAMMB2t1YmUtY2EwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQCkJJDOzQ3Iw0G78GIKmStALt+lFbRXjH0s0g6bRzqe3ZmRLlSa
buf35GlVZns1oUl3oi7J/J+n/4tf8A24sIdvkEsZGre/QB3lzAOL0elix2gJTnIZ
DTUv1WYriO0IsvFPPwbz1Kca5AL7J2OtlexN9HHo27Raobv5o0BN8dQZHoPhwXqk
Syw9qMlWpswkiKrEdYBrpwCQ4O7r+ux9G+I5sx3uvp+MbepDXNvDnn2BFDMcgH0A
Olglxt22yPKJxCizsyrRUgO3cjlAS440agmxjFQV7EhqXUr8BOA9pq4MDk/FFXpD
avACS8sIa2m1VrQQMobjG/iWnpZCnC9650KrAgMBAAGjUzBRMB0GA1UdDgQWBBTW
xcDSOXCcggkwGUZp1CfI6x7/vDAfBgNVHSMEGDAWgBTWxcDSOXCcggkwGUZp1CfI
6x7/vDAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQB5zN7OhKZW
GPN8F0gBpzHiKUwSdqO3pKoX3goVm1iIHdfuuKeAPpF8IN6RRq9t4K+OSa1IxGM/
1pTooqbVoG14D34STXGQeL0SeZGx+dHikumC8XGB1HuzVgYKxX+vr7OeRbSdWraq
UygnkXADDh32otVUiWQC63AYMlF/BxDWr4ACHyLrH1ab5ruxVdt5x7qYg41wIp+/
1ON4k90AYW9AS3GA8+ErmYwOPssd+NtHzOXD+iBYJK5Rzh5ElLabDaoIMUBDFZ5y
iuhi2KV9f9QnX83ARYmb0Aw9czg7ok1P7kDqo58Ou6ZMtY+s11q8iYjEshK1151/
v7Pg+1MxXr9R
-----END CERTIFICATE-----
```

