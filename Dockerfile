# 第一个阶段用于根据架构复制文件
FROM --platform=$TARGETPLATFORM alpine:3.19 AS builder

# 设置构建参数
ARG TARGETPLATFORM
ARG TARGETARCH

# 复制二进制文件 - 修改复制路径
COPY /cfnat/* ./app/
COPY /go.sh ./go.sh
COPY /ips-v4.txt ./ips-v4.txt
COPY /ips-v6.txt ./ips-v6.txt
COPY /locations.json ./locations.json

# 添加调试信息
RUN echo "Files in builder:" && ls -la

# 检查文件是否存在并根据目标架构重命名二进制文件
RUN ls -la && \
    case "$TARGETARCH" in \
        amd64) mv ./app/cfnat-linux-amd64 ./cfnat ;; \
        386) mv ./app/cfnat-linux-386 ./cfnat ;; \
        arm64) mv ./app/cfnat-linux-arm64 ./cfnat ;; \
        arm/v5) mv ./app/cfnat-linux-armv5 ./cfnat ;; \
        arm/v6) mv ./app/cfnat-linux-armv6 ./cfnat ;; \
        arm/v7) mv ./app/cfnat-linux-armv7 ./cfnat ;; \
    esac

# 第二个阶段：运行阶段
FROM --platform=$TARGETPLATFORM alpine:3.19

# 复制构建阶段的文件到运行阶段
COPY --from=builder /cfnat ./cfnat
COPY --from=builder /ips-v4.txt ./ips-v4.txt
COPY --from=builder /ips-v6.txt ./ips-v6.txt
COPY --from=builder /locations.json ./locations.json
COPY --from=builder /go.sh ./go.sh

# 赋予可执行权限
RUN chmod +x ./cfnat ./go.sh

# 设置环境变量默认值
ENV colo="SJC,LAX,HKG" \
    delay="300" \
    ipnum="10" \
    ips="4" \
    num="10" \
    port="443" \
    random="true" \
    task="100" \
    tls="true" \
    domain="cloudflaremirrors.com/debian"

# 暴露 1234 端口
EXPOSE 1234

# 运行 go.sh 脚本
CMD ["/bin/sh", "./go.sh"]