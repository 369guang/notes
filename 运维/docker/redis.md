# 获取镜像

```sh
docker pull redis
```



# 安装

```shell
docker run --name redis -p 6379:6379 \
-v $PWD/conf/redis.conf:/usr/local/etc/redis/redis.conf \
-v $PWD/data:/data \
-d redis redis-server /usr/local/etc/redis/redis.conf 
```



## 参考地址

```http
https://hub.docker.com/_/redis
```

