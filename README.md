#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)

##### 开源项目
- ldap: https://blog.csdn.net/weixin_42257195/article/details/102769495
- dex: https://dexidp.io/docs/guides/kubernetes/

```
[    # A raw certificate file can also be provided inline.
    # rootCAData: ( base64 encoded PEM file )](https://dexidp.io/docs/connectors/ldap/)
```

##### test
### 安装dexuid
添加 Dex Helm 仓库
```
helm repo add dex https://charts.dexidp.io
helm repo update

helm install dex dex/dex --namespace dex --create-namespace --version 0.19.1 --values dex-values.yaml
```


### 安装 dex-k8s-authenticator
```
helm repo add skm https://charts.sagikazarmark.dev
helm repo update

helm install dex-k8s-authenticator skm/dex-k8s-authenticator --namespace dex --version 0.0.3 --values authen-values.yaml
```

dex-helm
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
      host: ldap-svc.dex:389
      insecureNoSSL: true
      bindDN: cn=admin,dc=example,dc=com
      bindPW: "123456"
      userSearch:
        baseDN: dc=example,dc=com
        filter: "(objectClass=*)"
        username: uid
        idAttr: uid
        emailAttr: mail
        nameAttr: uid

      groupSearch:
        baseDN: dc=example,dc=com
        filter: "(objectClass=*)"
        userMatchers:
        - userAttr: uid
          groupAttr: memberUid
        nameAttr: cn

  staticClients:
    - id: kubernetes
      secret: ZXhhbXBsZS1hcHAtc2VjcmV0
      name: "kubernetes"
      redirectURIs:
      - https://login.uol-cce-poc.duck.tec.br/callback
```

authen.yaml
```

config:
  clusters:
    - name: dex-cluster
      short_description: "Your cluster"
      description: "Your cluster"
      issuer: https://dex.uol-cce-poc.duck.tec.br
      client_id: kubernetes
      client_secret: ZXhhbXBsZS1hcHAtc2VjcmV0
      redirect_uri: https://login.uol-cce-poc.duck.tec.br/callback
      k8s_master_uri: https://192.168.0.188:5443
      k8s_ca_pem: |
        -----BEGIN CERTIFICATE-----
        MIIDDzCCAfegAwIBAgIBADANBgkqhkiG9w0BAQsFADApMRkwFwYDVQQKExBDQ0Ug
        VGVjaG5vbG9naWVzMQwwCgYDVQQDEwNDQ0UwHhcNMjMwODA1MDk1OTU2WhcNNDMw
        ODA1MDk1OTU2WjApMRkwFwYDVQQKExBDQ0UgVGVjaG5vbG9naWVzMQwwCgYDVQQD
        EwNDQ0UwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGH8a7midOPfwq
        OixdAKHwKa2KW+QHxRHilNl3LaszkZ/q4Q5PQyzHQotON0VESo+Q6D8e5fiZsGaS
        mIrj4aH2eMUJOGeSHtOm7GrHnxzVxrdCL3D3vxe6Fr1wWhxqPeR81IOkUzwtfYs3
        UxRknQMh1Xb7FCLrsz8eLmC9TfTFBv+y8Iu42k5bTkju+fx6J1fwxenT/hVoMd79
        KmE1XCvXI2j07OgtKaorLzOhCP3wdXXYZeuZkJyxXfTdGVjFGhZB+VlsVl9Q6bia
        Q1JMwntLxBH1qkn+SlpzEK0AHiu4PgWJtx41CmO4wUxs5aBeuIjOzaPKPx/qfrxD
        +lY/RHMdAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/
        MB0GA1UdDgQWBBS47Min9DZ5LQbHYhthpPU8f3jxxDANBgkqhkiG9w0BAQsFAAOC
        AQEAoW6PBbQyXeqzGrmvCo+R3fciKw/sLC06PPh+l8GOihEkJExeipLPxcr9MZ0O
        aiiAJ6Mkb8w2Lze62NqZ+cIOSlQUOdQVKkQfsc867ydCJbPJ0zZ3uXCWI7qvy9Tv
        t4TyHvjBSsJ4Qr4Bf4kVohmclr+ZpwdAhlNCIKPn3AovW1lTHFGl1ZSiqo3qgfnr
        AkUUKqxw6ANDp4P6Gq9UEGaBW5Ui2myC69Z+NQvBT9PfqHJEjx/je0R/6mti0wt6
        8BpwsAy9bNtRLuoM5A4GS5t3pGelD0bwCfVMSBzXiEz52GpYoVOkxQKLnPWbow1j
        af5kiAJpysmNirs+gVOWYWGrqQ==
        -----END CERTIFICATE-----
  trusted_root_ca: |
    -----BEGIN CERTIFICATE-----
    MIIDBTCCAe2gAwIBAgIUM7cXY6k6RFZ4yks//+S3oP8pvHAwDQYJKoZIhvcNAQEL
    BQAwEjEQMA4GA1UEAwwHa3ViZS1jYTAeFw0yNDEwMTUwNjI1MzVaFw0yNDEwMjUw
    NjI1MzVaMBIxEDAOBgNVBAMMB2t1YmUtY2EwggEiMA0GCSqGSIb3DQEBAQUAA4IB
    DwAwggEKAoIBAQC5nSaj4YqzV0tt6ghPN3K6GZJe1UCfpqLbIlUMU+gg1/z/MnUK
    BaMyn1sFTIRR1ZzcSR6XmKY+6ERaQ+9wS0MUvqg6rK0PhVVwt8w3PTXkCdEGJM2v
    wZimq8+ikIrDOA7t2OKqbzUjtpSDJJVZY4336T3ZkkM0Bh6M7HXkRWxCtLhqhb6e
    BE64UQFntNMWOyBssF3O6MjyWSVq72qnA1KDBKft7QE9kzarJzVl4AO4E3WGIt0A
    2DNeUmlOEQqhSgQKjHceUB/Bwsc7ov5InwjvOfOkjmwrnNsA0oF8mhbB+toVGXTI
    NoWiOAQLybHOZ6vUgdqDldAj5mLtiSYtcmoxAgMBAAGjUzBRMB0GA1UdDgQWBBQw
    kwmRqyZUU/9ebqHYnKvEcCDqCjAfBgNVHSMEGDAWgBQwkwmRqyZUU/9ebqHYnKvE
    cCDqCjAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQBjp7DC6H2B
    C0YQxIgQkYoEKxARacwwazkkMBcG1P3VnFgwDA6t1H8Ph66Jr+LdHqIIBEeM2QVf
    fLEwnlJiO2/bslNYwwABU+U+qf91gSCjfpvnUrgwlqUzCaGoYi5LVjPYUU841yam
    YeT8c+X+KMIKlRe8SKf7bKVgc5Zk1BFrOaiT18yvCZotHnOqb2yiZfHeFvd0txt+
    dxa+MOgSNbcmXJWqriecY1eCneme7gim2ZnrI2ggt8qAGFzWLEeEG3GvK/BkxrmI
    jvskZfDA/QGmHTNbhMG9bwSJrIXJJVbbUxyVtlYTrX6FrsJu8iuifa48wfEyDQfm
    /5Ay29h9Ht4/
    -----END CERTIFICATE-----

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: login.uol-cce-poc.duck.tec.br
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
    - secretName: dex.example.com.tls
      hosts:
        - login.uol-cce-poc.duck.tec.br
```

