# 使用 Alpine Linux 64 位镜像
FROM alpine:latest

# 复制 cfnat-linux-amd64 文件到容器根目录
COPY cfnat-linux-amd64 ./cfnat-linux-amd64
COPY ips-v4.txt ./ips-v4.txt
COPY ips-v6.txt ./ips-v6.txt
COPY locations.json ./locations.json

# 赋予可执行权限
RUN chmod +x ./cfnat-linux-amd64

# 运行 cfnat-linux-amd64 并将输出写入日志
CMD ["./cfnat-linux-amd64"]
