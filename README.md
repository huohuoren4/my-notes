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
docker login -u cn-north-4@ZKCGOV77QO2ZU7SR8AHW -p 84bf692d3a48617e534cafd2fe0a4c2fae6300edf9658d5dd1cd4967237a5d3f \
    swr.cn-north-4.myhuaweicloud.com
images="kibana:7.12.1 elasticsearch:7.12.1";
image_url="swr.cn-north-4.myhuaweicloud.com/testapp"
for image in ${images}; do \
docker pull $image && docker tag $image ${image_url}/$image &&  docker push  ${image_url}/$image; done; 
```


