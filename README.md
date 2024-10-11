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
- dex: https://dexidp.io/docs/guides/kubernetes/

---
#### 3. 补充内容
- [pytorch博客: https://blog.csdn.net/mengxianglong123/article/details/126034288
- python3 unittest模块解析：https://blog.csdn.net/qq_41437305/article/details/96368903
- python技术博客：https://www.cnblogs.com/wdliu/category/934310.html?page=1
- python HTTP代理：https://blog.csdn.net/xuezhangjun0121/article/details/128871916](https://dexidp.io/docs/guides/kubernetes/)

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

6. 安装dex
ssl.sh
```
#!/bin/bash

mkdir -p ssl

cat << EOF > ssl/req.cnf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name

[req_distinguished_name]

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = dex.example.com
IP.1 = 192.168.0.129
EOF

openssl genrsa -out ssl/ca-key.pem 2048
openssl req -x509 -new -nodes -key ssl/ca-key.pem -days 10 -out ssl/ca.pem -subj "/CN=kube-ca"

openssl genrsa -out ssl/key.pem 2048
openssl req -new -key ssl/key.pem -out ssl/csr.pem -subj "/CN=kube-ca" -config ssl/req.cnf
openssl x509 -req -in ssl/csr.pem -CA ssl/ca.pem -CAkey ssl/ca-key.pem -CAcreateserial -out ssl/cert.pem -days 10 -extensions v3_req -extfile ssl/req.cnf
```
dex.yaml
```
---
apiVersion: v1
kind: Namespace
metadata:
  name: dex
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: dex
  name: dex
  namespace: dex
spec:
  replicas: 1
  selector:
    matchLabels:
      app: dex
  template:
    metadata:
      labels:
        app: dex
    spec:
      serviceAccountName: dex # This is created below
      containers:
      - image: swr.cn-north-4.myhuaweicloud.com/testapp/ghcr.io/dexidp/dex:v2.32.0
        name: dex
        command: ["/usr/local/bin/dex", "serve", "/etc/dex/cfg/config.yaml"]

        ports:
        - name: https
          containerPort: 5556

        volumeMounts:
        - name: config
          mountPath: /etc/dex/cfg
        - name: tls
          mountPath: /etc/dex/tls

        env:
        - name: GITHUB_CLIENT_ID
          valueFrom:
            secretKeyRef:
              name: github-client
              key: client-id
        - name: GITHUB_CLIENT_SECRET
          valueFrom:
            secretKeyRef:
              name: github-client
              key: client-secret

        readinessProbe:
          httpGet:
            path: /healthz
            port: 5556
            scheme: HTTPS
      volumes:
      - name: config
        configMap:
          name: dex
          items:
          - key: config.yaml
            path: config.yaml
      - name: tls
        secret:
          secretName: dex.example.com.tls
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: dex
  namespace: dex
data:
  config.yaml: |
    issuer: https://dex.example.com:32000
    storage:
      type: kubernetes
      config:
        inCluster: true
    web:
      https: 0.0.0.0:5556
      tlsCert: /etc/dex/tls/tls.crt
      tlsKey: /etc/dex/tls/tls.key
    connectors:
    - type: github
      id: github
      name: GitHub
      config:
        clientID: $GITHUB_CLIENT_ID
        clientSecret: $GITHUB_CLIENT_SECRET
        redirectURI: https://dex.example.com:32000/callback
        org: kubernetes
    oauth2:
      skipApprovalScreen: true

    # oidc-client-id
    staticClients:
    - id: kubernetes
      redirectURIs:
      - 'http://dex.example.com:32001/callback'
      name: 'kubernetes'
      secret: ZXhhbXBsZS1hcHAtc2VjcmV0

    enablePasswordDB: true

    # dex 账号登录信息
    staticPasswords:
    - email: "admin@example.com"
      # bcrypt hash of the string "password": $(echo password | htpasswd -BinC 10 admin | cut -d: -f2)
      # password: 123456
      hash: "$2y$10$RP0xo4XscZfkLnYSNYQYAuqI04RFpWxum/agymQC8.J2nIeWPpQBy"
      username: "admin"
      userID: "08a8684b-db88-4b73-90a9-3cd1661f5466"
---
apiVersion: v1
kind: Service
metadata:
  name: dex
  namespace: dex
spec:
  type: NodePort
  ports:
  - name: dex
    port: 5556
    protocol: TCP
    targetPort: 5556
    nodePort: 32000
  selector:
    app: dex
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: dex
  name: dex
  namespace: dex
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: dex
rules:
- apiGroups: ["dex.coreos.com"] # API group created by dex
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["apiextensions.k8s.io"]
  resources: ["customresourcedefinitions"]
  verbs: ["create"] # To manage its own resources, dex must be able to create customresourcedefinitions
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dex
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: dex
subjects:
- kind: ServiceAccount
  name: dex           # Service account assigned to the dex pod, created above
  namespace: dex  # The namespace dex is running in
```

gangway.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gangway
  namespace: dex
  labels:
    app: gangway
spec:
  replicas: 1
  selector:
    matchLabels:
      app: gangway
  strategy:
  template:
    metadata:
      labels:
        app: gangway
        revision: "1"
    spec:
      containers:
      - name: gangway
        image: swr.cn-north-4.myhuaweicloud.com/testapp/gcr.io/heptio-images/gangway:v3.2.0
        imagePullPolicy: Always
        command: ["gangway", "-config", "/gangway/gangway.yaml"]
        env:
        - name: GANGWAY_SESSION_SECURITY_KEY
          valueFrom:
            secretKeyRef:
              name: gangway-key
              key: sessionkey
        ports:
        - name: http
          containerPort: 8080
          protocol: TCP
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "200m"
            memory: "512Mi"
        volumeMounts:
        - name: gangway
          mountPath: /gangway/
        - name: dex-cacert
          mountPath: /cacerts/rootca.crt
        livenessProbe:
          httpGet:
            path: /
            port: 8080
          initialDelaySeconds: 20
          timeoutSeconds: 1
          periodSeconds: 60
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /
            port: 8080
          timeoutSeconds: 1
          periodSeconds: 10
          failureThreshold: 3
      securityContext:
        runAsNonRoot: true
        runAsUser: 65534
        runAsGroup: 65534
      volumes:
      - name: gangway
        configMap:
          name: gangway
      - name: dex-cacert
        configMap:
          name: dex-cacert
---
kind: Service
apiVersion: v1
metadata:
  name: gangway-service
  namespace: dex
  labels:
    app: gangway
spec:
  type: NodePort
  ports:
    - name: "http"
      protocol: TCP
      port: 8080
      targetPort: 8080
      nodePort: 32001
  selector:
    app: gangway
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: gangway
  namespace: dex
data:
  gangway.yaml: |
    host: "0.0.0.0"
    port: 8080
    clusterName: "int32bit-gangway-cluster"
    serveTLS: false
    authorizeURL: "https:/dex.example.com:32000/auth"
    tokenURL: "https://dex.example.com:32000/token"
    redirectURL: "http://dex.example.com:32001/callback"
    clientID: "kubernetes"
    clientSecret: "ZXhhbXBsZS1hcHAtc2VjcmV0"
    usernameClaim: "name"
    apiServerURL: "https://192.168.0.164:5443"
    trustedCAPath: "/cacerts/rootca.crt/ca.pem"
```

dex.md
```
1. 创建证书
```shell
kubectl create ns dex
cd ssl
kubectl create secret tls -n dex dex.example.com.tls \
  --cert=tls.crt \
  --key=tls.key
```

2. 生成github 密钥
创建一个新的OAuth APP: https://github.com/settings/developers
```shell
GITHUB_CLIENT_ID=Ov23ctCcjLa57VXg4NZg
GITHUB_CLIENT_SECRET=870e71a8abfd1be517ff9ed162bbd49ac625b1d8
kubectl -n dex create secret \
    generic github-client \
    --from-literal=client-id=$GITHUB_CLIENT_ID \
    --from-literal=client-secret=$GITHUB_CLIENT_SECRET
```

3. 部署dex应用

4. 部署gangway应用

a. 创建密钥：kubectl create cm dex-cacert --from-file=ca.pem -n dex
b. kubectl -n dex create secret generic gangway-key \
  --from-literal=sessionkey=$(openssl rand -base64 32)

5. 修改apiserver
所有master节点修改/etc/kubernetes/manifests/kube-apiserver.yaml的启动参数

- --oidc-issuer-url=https://dex.example.com:32000
- --oidc-client-id=kubernetes
- --oidc-ca-file=/etc/kubernetes/ssl/ca.pem
- --oidc-username-claim=email
- --oidc-groups-claim=groups


```yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: steve-admin
subjects:
- kind: User
  name: admin@example.com  # third party account, such as Github account
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
```
```

