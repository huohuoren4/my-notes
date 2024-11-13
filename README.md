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
```
# 创建networkpolicy网络策略

创建网络策略
```yaml
apiVersion: cilium.io/v2
kind: CiliumClusterwideNetworkPolicy
metadata:
  name: "internal-nginx-http"
spec:
  description: "Allow nginx http port"
  ingress:
  - fromEndpoints:
    - matchLabels:
        k8s:io.kubernetes.pod.namespace: default
        app: test
    toPorts:
      - ports:
          - port: "80"
            protocol: TCP
  endpointSelector:
    matchLabels:
      app: nginx
```

