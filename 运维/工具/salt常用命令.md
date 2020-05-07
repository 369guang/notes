##### 文件同步：

​    其实在做openstack的运维对一些文件的同步其实是很繁琐。有一个配置项或者一行代码的源码文件进行同步。那么现在我们就开始介绍saltstack的文件同步功能

##### 环境说明：操作系统版本：rhel6.5x64

1、master配置同步根目录
     在开始saltstack的配置管理之前，要首先指定saltstack所有状态文件的根目录，在master上做如下操作

#### 首先修改master的配置文件，指定根目录，注意缩进全部使用两个空格来代替Tab
#### 确定指定的目录是否存在，如果不存在，需要手动来创建目录
```sh
[iyunv@controller1 ~]# vim /etc/salt/master 
file_roots:
  base:
    - /srv/salt
  dev:
    - /srv/salt/dev/

[iyunv@controller1 ~]# mkdir -p /srv/salt/dev
[iyunv@controller1 ~]# ls -ld /srv/salt/dev
drwxr-xr-x 2 root root 4096 Feb  3 21:49 /srv/salt/dev
```


重启master服务
```sh
[iyunv@controller1 ~]# service salt-master restart
Stopping salt-master daemon:                               [  OK  ]
Starting salt-master daemon:                               [  OK  ]
```


2、介绍cp.get_file

   首先介绍cp.get_file，用来从master端下载文件到minion的指定目录下，如下
#### 在master上创建测试用的文件
```sh
[iyunv@controller1 ~]# echo 'This is test file with saltstack module to  cp.get_file' >/opt/getfile.txt        
[iyunv@controller1 ~]# cat /opt/getfile.txt 
This is test file with saltstack module to  cp.get_file
```


将文件拷贝到master的同步根目录下
[iyunv@controller1 ~]# cp /opt/getfile.txt /srv/salt/



在master上执行文件下发
1
2
3
[iyunv@controller1 ~]# salt 'computer3' cp.get_file salt://getfile.txt /tmp/getfile.txt  
computer3:
    /tmp/getfile.txt



登录到computer3上查看同步情况
1
2
[iyunv@computer3 ~]# cat /tmp/getfile.txt 
This is test file with saltstack module to  cp.get_file




分发文件的一些属性：
（1）压缩  gzip
使用gzip的方式进行压缩，数字越大，压缩率就越高，9代表最大的压缩率
[iyunv@controller1 ~]# salt 'computer8' cp.get_file salt://getfile.txt /tmp/getfile.txt gzip=9
computer8:
    /tmp/getfile.txt




（2）创建目录 makedirs（当分发的位置在目标主机上不存在时，自动创建该目录）
[iyunv@controller1 ~]# salt 'computer8' cp.get_file salt://getfile.txt /tmp/srv/getfile.txt makedirs=True
computer8:
    /tmp/srv/getfile.txt

[iyunv@computer8 opt]# ll /tmp/srv/getfile.txt 
-rw-r--r-- 1 root root 56 Feb  3 22:14 /tmp/srv/getfile.txt

