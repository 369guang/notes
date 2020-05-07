# Docker 容器操作

## 一、日常操作

1、初次启动Docker容器命令 
```sh
docker run -d (后台运行容器)  -p 8080:8080 (绑定端口)  centos-nodejs:1.0 (镜像)
```


2、启动已停止的Docker容器命令
```sh
docker stop 9f38484d220f
```


3、查看正在运行的容器
```sh
docker ps
```


4、查看所有容器（包括正在运行）
```sh
docker ps -a
```


5、删除已停止的容器
```sh
docker rm 9f38484d220f
```


6、登陆容器(类似SSH)
```sh
docker exec -it 9f38484d220f (容器ID)  bash (进入命令模式)
```






## 二、镜像操作



1、镜像市场搜索镜像
```sh
docker search centos
```

2、拉取镜像
```sh
docker pull centos
```


3、登陆公有仓库
```sh
docker login
```

4、推送镜像到公共仓库

1. 给自定义镜像打标签

```sh
docker tag centos-nodejs:1.0 av1254/centos-nodejs:1.0
```
2. 查看打好标签的本地镜像
```sh
docker image ls
```


5、上传镜像到 docker官方仓库
```sh
docker push av1254/centos-nodejs
```










​	