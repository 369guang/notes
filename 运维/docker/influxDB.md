# 获取镜像

```sh
docker pull influxdb
```



# 获取配置

```shel
mkdir conf
docker run --rm influxdb influxd config > conf/influxdb.conf	 
```



# 安装

```shell
docker run -p 8086:8086 -p 12003:2003 --name influxdb \
-e INFLUXDB_GRAPHITE_ENABLED=true \
-e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=123456789 \
-e INFLUXDB_USER=guang -e INFLUXDB_USER_PASSWORD=123456789 \
-v $PWD:/var/lib/influxdb \
-v $PWD/conf/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
-d influxdb -config /etc/influxdb/influxdb.conf
```



## 参考地址

```http
https://hub.docker.com/_/influxdb
```

