#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)

##### 开源项目
- dex: https://dexidp.io/docs/guides/kubernetes/

##### test
```yaml
https://dexidp.io/docs/connectors/microsoft/


121.36.91.36

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
