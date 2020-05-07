# 1. Docker 安装



#### 一、 Centos 7 上安装

​	官方文档：https://docs.docker.com/install/linux/docker-ce/centos/

​	1.安装环境

```shell
yum install -y yum-utils device-mapper-persistent-data lvm2
```



​	2.设置源

```shell
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
```


​	3.关闭边缘版本

```shell
yum-config-manager --enable docker-ce-nightly
yum-config-manager --enable docker-ce-test
```


​	4.安装主体
```shell
yum install docker-ce docker-ce-cli containerd.io
```


​		5.开启服务
```shell
systemctl enable docker
systemctl start docker
```


​		6.验证是否安装正确
```shell
docker run hello-world
```


#### 二、Ubuntu 18

​	官方文档：https://docs.docker.com/install/linux/docker-ce/ubuntu/

 1.清除旧版本 
```shell
sudo apt-get remove docker docker-engine docker.io containerd runc
```

​	2.安装环境
```shell
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common
```
​	3.添加docker key
```shell
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
```


​	4.安装主体
```shell
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```