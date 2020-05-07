# 添加用户
groupadd mysql
useradd mysql -g mysql
# 变更用户
chown -R mysql:mysql /usr/local/mysql/
chmod -R 755 /usr/local/mysql/
#!/bin/bash
# writen by: guang
# create: 2019-02-01
# version: 1.0.0
# update_log: 

# 创建data目录
mkdir -p /data/mysql
chown -R mysql:mysql /data/mysql
chmod -R 755 /data/mysql
# 创建socket目录
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql
cd /usr/local/mysql
./bin/mysqld --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql --initialize
if [ $? = 0 ];then
  printf "%10s \033[1;32m $1 mysql安装成功. \033[0m\n\n" 
else
  printf "%10s \033[1;32m $1 mysql安装失败. \033[0m\n\n" 
  exit 1
fi
# 创建软连接
ln -s /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
# 开机启动
chkconfig mysqld on

# 修改密码 
./bin/mysqld_safe --skip-grant-tables --skip-networking > /dev/null 2>&1 &
sleep 10
/usr/local/mysql/bin/mysql -u root << EOF
update mysql.user set authentication_string=password('123456') where user='root';
flush privileges;
EOF
if [ $? = 0 ];then
  printf "%10s \033[1;32m $1 mysql 初始化密码成功. \033[0m\n\n"
else
  printf "%10s \033[1;32m $1 mysql 初始化密码失败. \033[0m\n\n"
  exit 1
fi
sleep 5
kill -9 `ps -ef|grep -v grep|grep mysql|awk '{print $2}'`
sleep 2

service mysqld start
mysql --connect-expired-password -uroot -p123456 << EOF
alter user 'root'@'localhost' identified by 'abcdefghijklmnopqrstuvwxyz';
use mysql;
update user set user.Host='%' where user.User='root';
flush privileges;
EOF
if [ $? = 0 ];then
  printf "%10s \033[1;32m $1 mysql 变更密码成功. \033[0m\n\n"
else
  printf "%10s \033[1;32m $1 mysql 变更化密码失败. \033[0m\n\n" 
  exit 1
fi