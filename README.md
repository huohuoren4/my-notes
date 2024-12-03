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

```
apiVersion: v1
kind: Service
metadata:
  labels:
    component: apiserver
    provider: kubernetes
  name: kubernetes
  namespace: default
spec:
  clusterIP: 10.247.0.1
  clusterIPs:
  - 10.247.0.1
  internalTrafficPolicy: Cluster
  ports:
  - name: https
    port: 443
    protocol: TCP
    targetPort: 5444
  sessionAffinity: None
  type: ClusterIP

```


