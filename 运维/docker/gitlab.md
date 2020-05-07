# Docker gitlab-ce安装


1. ### 拉取镜像
```sh
docker pull gitlab/gitlab-ce
```


2. ### 创建目录
```
mkdir -p {config,logs,data}
```

3. ### 创建容器
```sh
sudo docker run -d -p 50443:443 -p 50080:80 -p 50022:22 \
--name gitlab --restart always \
-v /home/docker/gitlab/config:/etc/gitlab \
-v /home/docker/gitlab/logs:/var/log/gitlab \
-v /home/docker/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce

# -d：后台运行
# -p：将容器内部端口向外映射
# --name：命名容器名称
# -v：将容器内数据文件夹或者日志、配置等文件夹挂载到宿主机指定目录
```



##### 修改端口后需要修改 config/gitlab.rb

```sh
external_url 'http://192.168.0.8:50080'
nginx['listen_port'] = 80
gitlab_rails['gitlab_ssh_host'] = ‘192’.168.0.8
gitlab_rails['gitlab_shell_ssh_port'] = 50022 # 此端口是run时22端口映射的222端口
```



### 4.重启

```sh
docker restart gitlab
```