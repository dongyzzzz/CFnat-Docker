# CFnat-Docker

```shell
docker run -d --name mycfnat -p 1234:1234 cmliu/cfnat:latest
```
 
## **示例** 
- 数据中心(colo): HKG
- 有效延迟(delay): 160
- IP类型(ips): 6
```shell
docker run -d -e colo="HKG" -e delay=160 -e ips=6 -p 1234:1234 cmliu/cfnat:latest
```

- 数据中心(colo): SJC,LAX
- 有效延迟(delay): 300
- IP类型(ips): 4
```shell
docker run -d -e colo="SJC,LAX" -e delay=300 -e ips=4 -p 1234:1234 cmliu/cfnat:latest
```

- 数据中心(colo): LAX
- 有效延迟(delay): 300
- IP类型(ips): 4
- 转发端口(port): 80
- tls: false
- 随机IP(random): true
- 有效IP数(ipnum): 10
- 负载IP数(num): 10
- 最大并发请求数(task): 100
```shell
docker run -d \
-e colo="LAX" \
-e delay=300 \
-e ips=4 \
-e port=80 \
-e tls=false \
-e random=true \
-e ipnum=10 \
-e num=10 \
-e task=100 \
-p 1234:1234 \
cmliu/cfnat:latest
```

## 参数说明
```
  -addr string
        服务端口: 本地监听的 IP 和端口 (default "0.0.0.0:1234")
  -code int
        HTTP/HTTPS 响应状态码 (default 200)
  -colo string
        数据中心: 筛选数据中心例如 HKG,SJC,LAX (多个数据中心用逗号隔开,留空则忽略匹配)
  -delay int
        有效延迟（毫秒）: 超过此延迟将断开连接 (default 300)
  -domain string
        响应状态码检查的域名地址 (default "cloudflaremirrors.com/debian")
  -ipnum int
        有效IP数: 提取的有效IP数量 (default 20)
  -ips string
        转发IP类型: 指定生成IPv4还是IPv6地址 (4或6) (default "4")
  -num int
        负载IP数: 目标负载 IP 数量 (default 10)
  -port int
        转发目标端口 (default 443)
  -random
        是否随机生成IP，如果为false，则从CIDR中拆分出所有IP (default true)
  -tls
        是否为 TLS 端口 (default true)
  -task int
        最大并发请求数: 并发请求最大协程数 (default 100)
```