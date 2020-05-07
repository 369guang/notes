
在centos6.9安装

一、 MongoDB安装 (以4.0版本为例)

1).使用yum安装

    1.添加yum源

    vim /etc/yum.repos.d/mongodb-org-4.0.repo

    [mongodb-org-4.0]
    name=MongoDB Repository
    baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.0/x86_64/
    gpgcheck=1
    enabled=1
    gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc


    2.安装社区版MongoDB

        yum install -y mongodb-org

        或者你指定某个版本来安装
            yum install -y mongodb-org-4.0.8 mongodb-org-server-4.0.8 mongodb-org-shell-4.0.8 mongodb-org-mongos-4.0.8 mongodb-org-tools-4.0.8

    3.添加开机启动

        chkconfig mongod on

    4.开启服务

        service mongod start

2).使用二进制文件安装
    
    可能你缺少某些支持库(作者目前没有缺少这两个库)
    yum install libcurl openssl

    1.下载二进制文件 (注:要对应系统安装)
      
        wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-rhel62-4.0.8.tgz

    2.解压 和 添加用户组
        
        tar xf mongodb-linux-x86_64-rhel62-4.0.8.tgz

        groupadd mongod
        useradd mongod -g mongod

    3.添加环境变量

        可以加入到 ~/.bashrc 或者 /etc/profile
        export PATH=/usr/local/mongodb/bin:$PATH

    4.添加目录 (生产服务器并不推荐按照官方配置来定义目录)

        mkdir -p /var/lib/mongo      # 数据目录
        mkdir -p /var/log/mongodb    # 日志目录

        chown -R mongod:mongod /var/lib/mongo 
        chown -R mongod:mongod /var/log/mongodb

    5.添加启动文件

        ln -s /usr/local/mongodb/bin/mongod  /etc/init.d/mongod

    6.添加开机启动

        chkconfig mongod on

    7.开启服务

        service mongod start

二、 MongoDB的卸载

1.停止服务

    service mongod stop

2.卸载包

    yum erase $(rpm -qa | grep mongodb-org)

3.清除数据库及其日志文件

    /bin/rm -rf /var/log/mongodb
    /bin/rm -rf /var/lib/mongo


三、关于集群
    非常详细
    https://www.cnblogs.com/clsn/p/8214345.html#auto_id_0