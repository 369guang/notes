# 监控工具Telegraf使用



## Install

#### 1. 添加源

```shell
cat <<EOF > /etc/yum.repos.d/influxdb.repo 
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```



#### 2. 安装

##### centos 6

```sh
sudo yum install telegraf
sudo service telegraf start
```

##### Centos 7

```sh
sudo yum install telegraf
sudo systemctl start telegraf
```



#### 3.配置

```sh
vim /etc/telegraf/telegraf.conf
[[outputs.influxdb]]
  urls = ["http://127.0.0.1:8086"]
  database = "telegraf"
  retention_policy = ""
  timeout = "5s"
  username = "telegraf"
  password = "metricsmetricsmetricsmetrics"
```



#### 4.重启

##### centos 6

```sh
sudo service telegraf restart
```

##### centos 7

```sh
sudo systemctl restart telegraf
```



## 对influxDB的配置

##### 创建用户

```sh
create user "telegraf" with password 'metricsmetricsmetricsmetrics'
create database telegraf
```

