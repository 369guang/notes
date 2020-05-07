## 一、git仓库创建

#### 1.安装对应的包

```sh
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel
yum install git
```

#### 2.创建git用户

```sh
groupadd git
adduser git -g git
passwd git
```

#### 3.创建证书登录

```sh
cd /home/git/
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
```

#### 4.初始化Git仓库

```sh
cd /home
mkdir gitrepo
chown git:git gitrepo/
cd gitrepo

git init --bare runoob.git
    -> Initialized empty Git repository in /home/gitrepo/runoob.git/
```

5.克隆仓库
```sh
git clone git@192.168.45.4:/home/gitrepo/runoob.git
```

## 二、Git迁移

#### 1). 从原地址克隆一份裸版本库，比如原本托管于 GitHub，或者是本地的私有仓库

```sh
    git clone --bare git://192.168.10.XX/git_repo/project_name.git
```

#### 2).然后到新的 Git 服务器上创建一个新项目，比如 GitCafe，亦或是本地的私有仓库，如192.168.20.XX

####    创建新仓库参考 一 

#### 3).迁移

```sh
    cd project_name.git
    git git push --mirror git@192.168.45.4:/home/gitrepo/runoob.git
```