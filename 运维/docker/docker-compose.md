# Docker compose 安装教程 

 

## 方法一


```sh
安装 pip
yum install -y python-pip

安装Docker Compose
pip install docker-compose

查看版本
docker-compose version
```



## 方法二


官网安装
```http
https://github.com/docker/compose/releases
```

这里以1.251版本为例
```sh
curl -L https://github.com/docker/compose/releases/download/1.25.1-rc1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
```