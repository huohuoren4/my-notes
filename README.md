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

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dex-internal
  namespace: dex
spec:
  ingressClassName: nginx
  rules:
  - host: dex.matheus.duck.tec.br
    http:
      paths:
      - backend:
          service:
            name: dex
            port:
              number: 5556
        path: /
        pathType: ImplementationSpecific
  tls:
  - hosts:
    - dex.matheus.duck.tec.br
    secretName: dex.matheus.duck.tec.br

```
