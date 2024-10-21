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

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: dex.uol-cce-poc.duck.tec.br
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
    - secretName: dex.example.com.tls
      hosts:
        - dex.uol-cce-poc.duck.tec.br

config:
  issuer: https://dex.uol-cce-poc.duck.tec.br

  storage:
    type: kubernetes
    config:
      inCluster: true

  oauth2:
    responseTypes: ["code", "token", "id_token"]
    skipApprovalScreen: true

  connectors:
  - type: ldap
    id: ldap
    name: LDAP
    config:
      host: 192.168.0.144:389
      insecureNoSSL: true
      bindDN: CN=Administrator,CN=Users,DC=example,DC=com
      bindPW: "Tonarcreares6="
      userSearch:
        baseDN: dc=example,dc=com
        filter: "(objectClass=person)"
        username: sAMAccountName
        idAttr: sAMAccountName
        emailAttr: mail
        nameAttr: name

      groupSearch:
        baseDN: dc=example,dc=com
        filter: "(objectClass=group)"
        userMatchers:
        - userAttr: distinguishedName
          groupAttr: member
        nameAttr: sAMAccountName


  staticClients:
    - id: kubernetes
      secret: ZXhhbXBsZS1hcHAtc2VjcmV0
      name: "kubernetes"
      redirectURIs:
      - https://login.uol-cce-poc.duck.tec.br/callback

```
