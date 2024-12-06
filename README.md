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

# 创建命名空间
kubectl create namespace cribl-stream
# 添加cribl仓库
helm repo add cribl https://criblio.github.io/helm-charts/

# 安装cribl-leader
```
helm install ls-leader cribl/logstream-leader \
  --set config.scName='csi-disk' \
   -n cribl-stream
```

# 安装cribl-worker
```
helm install ls-wg-pci cribl/logstream-workergroup -n cribl-stream
```



