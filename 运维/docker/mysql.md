# 获取镜像

```shell
docker pull mysql:5.7
```



# 创建路径

```shell
mkdir -p {conf,data,logs}
```



# 创建容器

```shel
docker run --name mysql \
-e MYSQL_ROOT_PASSWORD=1234567890 \
-p 3306:3306 \
--restart=always \
-e TZ=Asia/Shanghai \
-v /xx/conf/:/etc/mysql/conf.d \
-v /xx/data:/var/lib/mysql \
-v /xx/logs:/var/log/mysql \
-d mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

```



# 进入数据库

```shel
docker exec -it mysql env LANG=C.UTF-8 bash sh -c 'exec mysql -uroot -p"1234567890"' 
```



## 参考地址

```http
https://hub.docker.com/_/mysql
```

