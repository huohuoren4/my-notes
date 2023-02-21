FROM swr.cn-north-4.myhuaweicloud.com/wx-2022/golang-arm64:1.19.5-alpine3.17 As buildStage
WORKDIR /go/src
ADD . /go/src
RUN  go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct; \
     go mod tidy; \
     go build -o main

FROM swr.cn-north-4.myhuaweicloud.com/wx-2022/alpine-arm64:3.17
WORKDIR /app
COPY --from=buildStage /go/src/main /app/
RUN mkdir -p /var/golang-demo/log
EXPOSE 80
EXPOSE 8080
ENTRYPOINT ./main

