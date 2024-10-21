#### 1. 👻常用网址
- [我的 Github](https://github.com/huohuoren4)
- [我的 Gitee](https://gitee.com/shushuiren4)

##### 开源项目
部署openldap服务

```
kind: Ingress
apiVersion: networking.k8s.io/v1
metadata:
  name: my-app
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"

Administrators
---
kind: Ingress
apiVersion: networking.k8s.io/v1
metadata:
  name: my-app
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/auth-url: https://another-ldap.another.svc.cluster.local/auth
    nginx.ingress.kubernetes.io/auth-snippet: |
      proxy_set_header Ldap-Allowed-Groups "DevOps production environment";
    nginx.ingress.kubernetes.io/server-snippet: |
      error_page 401 = @login;
      location @login {
        return 302 https://another-ldap.testmyldap.com/?protocol=$pass_access_scheme&callback=$host;
      }
spec:
  rules:
  - host: my-app.testmyldap.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
    nginx.ingress.kubernetes.io/server-snippet: |
      error_page 401 = @login;
      location @login {
        return 302 https://another-ldap.testmyldap.com/?protocol=$pass_access_scheme&callback=$host;
      }
spec:
  rules:
  - host: my-app.testmyldap.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
```
