FROM alpine:3.9

# 设置环境变量默认值
ENV colo="SJC,LAX,HKG" \
    delay="300" \
    ipnum="10" \
    ips="4" \
    num="10" \
    port="443" \
    random="true" \
    task="100" \
    tls="true"

# 复制相关文件到容器根目录
COPY cfnat-linux-amd64 ./cfnat-linux-amd64
COPY go.sh ./go.sh
COPY ips-v4.txt ./ips-v4.txt
COPY ips-v6.txt ./ips-v6.txt
COPY locations.json ./locations.json

# 安装 bash，因为 Alpine 默认没有 bash
RUN apk add --no-cache bash

# 赋予可执行权限
RUN chmod +x ./cfnat-linux-amd64 ./go.sh

# 暴露 1234 端口
EXPOSE 1234

# 运行 go.sh 脚本
CMD ["/bin/bash", "./go.sh"]