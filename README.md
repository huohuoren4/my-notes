#### 1. 👻常用网址
##### 代理服务器
```
# 香港节点squid代理服务，部分国外网站无法登录：google, dockerhub等
# 如果使用代理出现无法访问， 可能是内网域名和私网ip无法识别
proxy_addr=http://159.138.153.190:3128
export HTTP_PROXY=${proxy_addr}   
export HTTPS_PROXY=${proxy_addr}    
```

##### 开源项目
https://github.com/dignajar/another-ldap/archive/refs/heads/main.zip


# 修改插件yaml

kubectl -n kube-system edit deploy cilium-operator
```yaml
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: os.name
                operator: In
                values:
                - Huawei_Cloud_EulerOS_2.0_x86_64   # modify label
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app: cilium-operator
            topologyKey: kubernetes.io/hostname
```

kubectl -n kube-system edit ds yangtse-cilium
```yaml
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: os.name
                operator: In
                values:
                - Huawei_Cloud_EulerOS_2.0_x86_64  # modify label
      containers:

```
# 创建应用
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: default
spec:
  selector:
    matchLabels:
      app: nginx
      version: v1
  template:
    metadata:
      labels:
        app: nginx
        version: v1
    spec:
      containers:
        - name: container-1
          image: nginx:latest
          imagePullPolicy: IfNotPresent
          resources:
            requests:
              cpu: 100m
              memory: 50Mi
            limits:
              cpu: 250m
              memory: 512Mi
  replicas: 1

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  namespace: default
spec:
  selector:
    matchLabels:
      app: test
      version: v1
  template:
    metadata:
      labels:
        app: test
        version: v1
    spec:
      containers:
        - name: container-1
          image: nginx:latest
          imagePullPolicy: IfNotPresent
          resources:
            requests:
              cpu: 100m
              memory: 50Mi
            limits:
              cpu: 250m
              memory: 512Mi
  replicas: 1

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test02
  namespace: default
spec:
  selector:
    matchLabels:
      app: test02
      version: v1
  template:
    metadata:
      labels:
        app: test02
        version: v1
    spec:
      containers:
        - name: container-1
          image: nginx:latest
          imagePullPolicy: IfNotPresent
          resources:
            requests:
              cpu: 100m
              memory: 50Mi
            limits:
              cpu: 250m
              memory: 512Mi
  replicas: 1

```
# 创建networkpolicy网络策略

创建网络策略
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-nginx
  namespace: elk
spec:
  replicas: 2
  selector:
    matchLabels:
      project: www
      app: php-demo
  template:
    metadata:
      labels:
        project: www
        app: php-demo
    spec:
      imagePullSecrets:
      - name: default-secret
      containers:
      - name: nginx
        image: nginx:perl
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: web
          protocol: TCP
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 500m
            memory: 1Gi
        volumeMounts:
        - name: nginx-logs
          mountPath: /var/log/nginx/
      - name: fluent-bit
        image: cr.fluentbit.io/fluent/fluent-bit:3.2.1
        imagePullPolicy: IfNotPresent
        resources:
          limits:
            cpu: 250m
            memory: 500Mi
          requests:
            cpu: 100m
            memory: 100Mi
        volumeMounts:
        - name: fluent-bit-config
          mountPath: /fluent-bit/etc/fluent-bit.conf
          subPath: fluent-bit.conf
        - name: nginx-logs
          mountPath: /var/log/nginx/
      volumes:
      - name: nginx-logs
        emptyDir: {}
      - name: fluent-bit-config
        configMap:
          name: fluent-bit-nginx-config
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluent-bit-nginx-config
  namespace: elk

data:
  fluent-bit.conf: |-
    [INPUT]
        Name tail
        Path /var/log/nginx/*.log
        Tag nginx

    [OUTPUT]
        Name  es
        Match *
        Host  192.168.2.3
        Port  9200
        Index my_index
        Type  my_type

```

