#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)

##### 开源项目
- dex: https://dexidp.io/docs/guides/kubernetes/
```

echo "-----BEGIN CERTIFICATE-----
MIIDDzCCAfegAwIBAgIBADANBgkqhkiG9w0BAQsFADApMRkwFwYDVQQKExBDQ0Ug
VGVjaG5vbG9naWVzMQwwCgYDVQQDEwNDQ0UwHhcNMjQxMDE0MTQ1MjQzWhcNNDQx
MDE0MTQ1MjQzWjApMRkwFwYDVQQKExBDQ0UgVGVjaG5vbG9naWVzMQwwCgYDVQQD
EwNDQ0UwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvyeUOXfkUV2SO
VMAVzncsRYMIf3Rx2SeivdzZn85XNeRJZ4yKp5ykOXHbL5LSMDy+WIKfsIKuDeJR
XWS3JtJuoyzy4FnpRl/wNoZyM/TvmGWTAgIRLxwYxkph61zhAxLPZn5qCsvaezDV
lqBx56kwblH/xh8D0vnSKLfUA79Hm9sKwtPoc5gWnmqqzwHs5dx+ALXJJ3Y0taMc
fDaMSGzCwWCmYDjhPSysiiNkXbKRrsIKxl+bg7go9TIi5EgGUT8KOqojDsIfKS8r
F/yq3x8QIUMKPs2fii2vnhmwHIdBI+WjxZeyS7EWngFz/YxRFCsRH6mlqlhzGG2v
rBoJ+UTVAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/
MB0GA1UdDgQWBBSoHuT2PXo1+f+89yhifpo1fDGHCTANBgkqhkiG9w0BAQsFAAOC
AQEADPhyDSAZMp7h/PPBUzBsNDSzk+bzoujdswAwGOYKGkyZK6/kUJ87X9NxMOBG
ajtER9ZI0AkOzmOQGXZFvGUmG1PXYvs2mk/DY4h/+NgFaQ1rhscLXIAogPwRazmg
zmOoV6SPbxD26tY6fP/zIeRTCwZwIHmeF7jbJqE7HvQbcFYM/rUAXF4rMeH/WtO1
a1p6HOO2RHuqHTk2tzcqxbUgRn3BwGMwiiveP4BVs6US6ss4elOkl/lRVo8wORlB
PPP71uSecilPYt/wJqZV0t0ltbiZT3YiAsqhS+qCjOFTpX1e44SKs298cawYtj5o
gknFGA7BaVGZiqwKXZZqRtcqkA==
-----END CERTIFICATE-----
" \ > ca-int32bit-gangway-cluster.pem
kubectl config set-cluster int32bit-gangway-cluster --server=https://192.168.0.164:5443 --certificate-authority=ca-int32bit-gangway-cluster.pem --embed-certs
kubectl config set-credentials huohuoren4@int32bit-gangway-cluster  \
    --auth-provider=oidc  \
    --auth-provider-arg='idp-issuer-url=https://dex.uol-cce-poc.duck.tec.br'  \
    --auth-provider-arg='client-id=kubernetes'  \
    --auth-provider-arg='client-secret=ZXhhbXBsZS1hcHAtc2VjcmV0' \
    --auth-provider-arg='refresh-token=ChlzeXdpenk2am82NWhxbGl1N3dlY3gzbmxwEhlnNTVjYzMzdGs3d2ppYWFpbWNnc2Q0NGZi' \
    --auth-provider-arg='id-token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjI5NGFkZmZlMDcwMDkxYWJiM2Y4Nzk3MGFkNGE2NmJmODFhZGY2MzQifQ.eyJpc3MiOiJodHRwczovL2RleC51b2wtY2NlLXBvYy5kdWNrLnRlYy5iciIsInN1YiI6IkNnZ3pORE16TVRFd01CSUdaMmwwYUhWaSIsImF1ZCI6Imt1YmVybmV0ZXMiLCJleHAiOjE3MjkwNjUwMjMsImlhdCI6MTcyODk3ODYyMywiYXRfaGFzaCI6IjhBVks5R1ZjaDQ2OWI4R0NwZnFqb0EiLCJjX2hhc2giOiJMajcxenRwcUlZaXNOdEp0M05jVlZ3IiwiZW1haWwiOiI2NzQ4NjAzNTdAcXEuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJodW9odW9yZW40IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaHVvaHVvcmVuNCJ9.aW15lq-q-j50opW5x4pKdHF5o5Pbq2u2NVKIOM01J21hPo1yBsEM6mswB-HQh9LqCpZplTpjoITo9OTWCG8seArbltHk_5VL21AZraJjIT5Jae0z_jA9vS-mchmYkCcesUbGxxdYhGBlDcgAIxGwOwF34rKqJKIELxRzksDw-IBpOhlzGvTgaJ8IGgN8Bso566dzq3KCjTQC-fT6WBR-gnIbQRj39hbM8e9xo8875zCuElLr5onVDZ9wozsaFnALzEMgB62ucvfL3qZlFa0XhXwn-2GoZ409fV1RcIHj5QeJYJ9zpbZxjmO74VwV3JEOsq2Orvm16UPac7HYthvs2g'
kubectl config set-context int32bit-gangway-cluster --cluster=int32bit-gangway-cluster --user=huohuoren4@int32bit-gangway-cluster
kubectl config use-context int32bit-gangway-cluster
rm ca-int32bit-gangway-cluster.pem
              
```

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
