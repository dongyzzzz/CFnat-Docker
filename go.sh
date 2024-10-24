#!/bin/bash

# 记录启动信息
echo "使用以下配置启动 cfnat:" >> cfnat.log
echo "IP类型(ips): $ips" >> cfnat.log
echo "TLS: $tls" >> cfnat.log
echo "随机IP(random): $random" >> cfnat.log
echo "数据中心(colo): $colo" >> cfnat.log
echo "有效延迟(delay): $delay" >> cfnat.log
echo "转发端口(port): $port" >> cfnat.log
echo "有效IP数(ipnum): $ipnum" >> cfnat.log
echo "负载IP数(num): $num" >> cfnat.log
echo "最大并发请求数(task): $task" >> cfnat.log
echo "检查域名(domain): $domain" >> cfnat.log

while true
do
    # 记录每次启动时间
    echo "$(date '+%Y-%m-%d %H:%M:%S') - cfnat 启动 ..." >> cfnat.log
    # 运行主程序 - 只在需要的参数上使用引号
    ./cfnat-linux-amd64 \
		-colo="${colo^^}" \
		-port="$port" \
        -delay="$delay" \
        -ips="$ips" \
        -addr="0.0.0.0:1234" \
        -ipnum="$ipnum" \
        -num="$num" \
        -random="$random" \
        -task="$task" \
        -tls="$tls" \
        -domain="$domain"
    # 记录崩溃信息
    echo "$(date '+%Y-%m-%d %H:%M:%S') - cfnat 崩溃，5 秒后重启..." >> cfnat.log
    # 等待 5 秒后重启
    sleep 5
done
