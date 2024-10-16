#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)

##### 开源项目
- ldap: https://blog.csdn.net/weixin_42257195/article/details/102769495
- dex: https://dexidp.io/docs/guides/kubernetes/
- kubeconfig
```
kubectl config set-cluster dex-cluster \
    --server=https://192.168.0.188:5443

kubectl config set-credentials 674860357-dex-cluster \
    --auth-provider=oidc \
    --auth-provider-arg="idp-issuer-url=https://dex.uol-cce-poc.duck.tec.br" \
    --auth-provider-arg="client-id=kubernetes" \
    --auth-provider-arg="client-secret=ZXhhbXBsZS1hcHAtc2VjcmV0" \
    --auth-provider-arg="refresh-token=Chl3NHR2NmVtZTNieWt1NWV2Nm9sYWJuZTZsEhlrNnRkdGlsNHRqcDN2dnNmY2diYWtrbTYz" \
    --auth-provider-arg="id-token=eyJhbGciOiJSUzI1NiIsImtpZCI6ImFjZDM1ZjIwZTQ5MTY3MWQwYTdjNTBlZDM3OTc3NWE2N2RlOTVmYmUifQ.eyJpc3MiOiJodHRwczovL2RleC51b2wtY2NlLXBvYy5kdWNrLnRlYy5iciIsInN1YiI6IkNnZ3pORE16TVRFd01CSUdaMmwwYUhWaSIsImF1ZCI6Imt1YmVybmV0ZXMiLCJleHAiOjE3MjkxNTY2NDgsImlhdCI6MTcyOTA3MDI0OCwiYXRfaGFzaCI6Ii1Sa0gxWEJBZ1hUYlk4ZWRUc3gyakEiLCJjX2hhc2giOiJHOGtzdFltQzFSYy1yOG1pZEdUVEFRIiwiZW1haWwiOiI2NzQ4NjAzNTdAcXEuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJodW9odW9yZW40IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaHVvaHVvcmVuNCJ9.CTQ1tfSBXKJ6nJEjqwIJfvaPJ28X6nH1gcJe9ObmR37rUNa747JPhMSzzEzatSLnCUt32SIf0F5H0MQty8OZEidmG6VTm3OHCbiEMX89XNAHyCgBVLlvX3scYe0PcqKXYBR7TrKZmRnD_bWZLFkeTI1Vbnch83hiBhPGjDZFxCMCOFIbD0Ax459NXuN0rle9x4zLnX_L1m8t2BJqLuQ0DwnozveTKDZaWixnAITLLzhzlfPEnkapSDI9ZnTwOqkMXYiiWpm_27Wx2fvTnm7t0HZOsim3BPLLAkZBahH9PajfwqbFOPnO_f8O693Nys2YewHpubKcFsnbN3XRieyVKQ"
kubectl config set-context 674860357-dex-cluster \
    --cluster=dex-cluster \
    --user=674860357-dex-cluster

```
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
github 用户组权限
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dex-cluster-auth
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-read-all
subjects:
  - kind: Group
    name: "your-github-org:your-github-team"
    apiGroup: rbac.authorization.k8s.io
```
### dex ingress
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
    issuer: https://dex.uol-cce-poc.duck.tec.br
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
        redirectURI: https://dex.uol-cce-poc.duck.tec.br/callback
        orgs:
        - name: dex-test-2024
    oauth2:
      skipApprovalScreen: true

    # oidc-client-id
    staticClients:
    - id: kubernetes
      redirectURIs:
      - 'http://login.uol-cce-poc.duck.tec.br/callback'
      name: 'kubernetes'
      secret: ZXhhbXBsZS1hcHAtc2VjcmV0

    enablePasswordDB: true
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

---
metadata:
  name: dex-ingress
  namespace: dex
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - dex.uol-cce-poc.duck.tec.br
      secretName: dex.example.com.tls
  rules:
    - host: dex.uol-cce-poc.duck.tec.br
      http:
        paths:
          - path: /
            pathType: ImplementationSpecific
            backend:
              service:
                name: dex
                port:
                  number: 5556
            property:
              ingress.beta.kubernetes.io/url-match-mode: STARTS_WITH
apiVersion: networking.k8s.io/v1
kind: Ingress
```
### gangway ingress
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
    authorizeURL: "https:/dex.uol-cce-poc.duck.tec.br/auth"
    tokenURL: "https://dex.uol-cce-poc.duck.tec.br/token"
    redirectURL: "http://login.uol-cce-poc.duck.tec.br/callback"
    clientID: "kubernetes"
    clientSecret: "ZXhhbXBsZS1hcHAtc2VjcmV0"
    usernameClaim: "name"
    apiServerURL: "https://192.168.0.164:5443"
    trustedCAPath: "/cacerts/rootca.crt/ca.pem"


---
metadata:
  name: gangway-ingress
  namespace: dex
spec:
  ingressClassName: nginx
  rules:
    - host: login.uol-cce-poc.duck.tec.br
      http:
        paths:
          - path: /
            pathType: ImplementationSpecific
            backend:
              service:
                name: gangway-service
                port:
                  number: 8080
            property:
              ingress.beta.kubernetes.io/url-match-mode: STARTS_WITH
apiVersion: networking.k8s.io/v1
kind: Ingress

```
