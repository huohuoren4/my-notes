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
- 接口自动化框架: [pytest-auto-api2](https://gitee.com/yu_xiao_qi/pytest-auto-api2?_from=gitee_search)
  - [接口自动化框架技术博客](https://blog.csdn.net/weixin_43865008/article/details/123904871?spm=1001.2014.3001.5501)
- web 自动化框架:  [WebUIAutoTest](https://gitee.com/azhengzz/WebUIAutoTest?_from=gitee_search)

---
#### 3. 补充内容
```shell
# 获取token
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | awk '/admin-user/{print $1}') | awk '/token:/{print $2}'

# 使用curl访问
curl -H "Authorization: Bearer ${token}" -k https://127.0.0.1:6443/api/

```