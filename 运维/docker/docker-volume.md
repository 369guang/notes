# Docker 数据管理



## 一、数据卷

####   1. 创建数据卷

```sh
docker volume create my-vol
```

####   2. 查看所有数据卷
```sh
docker volume ls

[root@localhost ~]# docker volume ls
DRIVER       VOLUME NAME
local        my-vol
```
####   3. 查看数据卷的详细信息
```sh
docker volume inspect my-vol

[root@localhost ~]# docker volume inspect my-vol

[
  	 {
    		"CreatedAt": "2019-04-09T19:40:08+08:00",
    		"Driver": "local",
    		"Labels": {},
    		"Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
    		"Name": "my-vol",
    		"Options": {},
    		"Scope": "local"
  	 }
]
```

####   4.挂载带有数据卷的容器
```sh
docker run -p 8080:8080 -d —mount source=my-vol,target=/webapp centos-nodejs:1.0
```
##### 	进去验证一下

```sh
[root@localhost ~]# docker exec -it e42c4e6f6da3 bash

[root@e42c4e6f6da3 app]# df -h
​		Filesystem       			Size 	Used 	Avail 	Use% 	Mounted on
​		overlay          			13G 	4.0G 	8.6G 	32%		/
​		tmpfs           			64M  	0  		64M  	0% 		/dev
​		tmpfs          			496M   	0 		496M  	0% 		/sys/fs/cgroup
​		shm            			64M   	0  		64M  	0% 		/dev/shm
​		/dev/mapper/centos-root  	13G 	4.0G 	8.6G 	32%		/webapp  ###### 这里已经挂上
​		tmpfs          			496M   	0 		496M  	0% 		/proc/asound
​		tmpfs          			496M   	0 		496M  	0% 		/proc/acpi
​		tmpfs          			496M   	0 		496M  	0% 		/proc/scsi
​		tmpfs          			496M   	0 		496M  	0% 		/sys/firmware
```





## 二、网络配置

​	

#### 	1. Docker 基础网络配置

##### 	  外部访问容器

​	  启动容器时，使用-P 或 -p 参数来指定端口映射，-P 随机生成本地端口绑定容器指定端口

​		  							     -p 手动指定本地端口映射容器端口
```sh
	  docker run -p 8080:8080 -d centos-nodejs:1.0
```
​	

##### 	  查看端口映射信息 看PORTS栏

```sh
[root@localhost ~]# docker ps 
CONTAINER ID    IMAGE          	 COMMAND          CREATED        STATUS          PORTS               NAMES
e42c4e6f6da3    centos-nodejs:1.0    "node /app/index.js"   12 minutes ago   Up 12 minutes    0.0.0.0:8080->8080/tcp  busy_shannon
```
​	

#### 	2. 容器互联

​		1. 创建一个自己的虚拟网桥
```sh
docker network create -d bridge my-bridge
docker network ls  # 查看是否创建成功
```


​		2. 创建两个链接到新网桥的两个容器


```sh
docker run -it -name test1 —network my-bridge centos
docker run -it -name test2 —network my-bridge centos	
```

###### 			最后容器互相 ping