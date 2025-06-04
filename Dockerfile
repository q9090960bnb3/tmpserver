# 基础构建阶段
FROM golang:alpine3.21 AS builder

# 设置工作目录
WORKDIR /workspace

# 复制源代码
COPY main.go .

# 构建Go应用
RUN go build -o /tmpserver -ldflags "-s -w" main.go

# 最终运行阶段
FROM alpine:3.21

# 从构建阶段复制可执行文件
COPY --from=builder /tmpserver /tmpserver

# 暴露默认端口
EXPOSE 8080

# 运行应用
CMD ["/tmpserver", "-port=8080"]