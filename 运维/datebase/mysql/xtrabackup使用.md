
## 一、 安装

```shell
    1.安装关联包
        yum -y install perl perl-devel libaio libaio-devel perl-Time-HiRes perl-DBD-MySQL
        rpm -ivh libev-4.03-3.el6.x86_64.rpm 
    2.安装xtrabackup
        rpm -ivh percona-xtrabackup-24-2.4.8-1.el6.x86_64.rpm
```

## 二、使用
​    1.参数使用 (可参考 --help 内容)

```shell
		innobackupex [--compress] [--compress-threads=NUMBER-OF-THREADS] [--compress-chunk-size=CHUNK-SIZE]
                 [--encrypt=ENCRYPTION-ALGORITHM] [--encrypt-threads=NUMBER-OF-THREADS] [--encrypt-chunk-size=CHUNK-SIZE]
                 [--encrypt-key=LITERAL-ENCRYPTION-KEY] | [--encryption-key-file=MY.KEY]
                 [--include=REGEXP] [--user=NAME]
                 [--password=WORD] [--port=PORT] [--socket=SOCKET]
                 [--no-timestamp] [--ibbackup=IBBACKUP-BINARY]
                 [--slave-info] [--galera-info] [--stream=tar|xbstream]
                 [--defaults-file=MY.CNF] [--defaults-group=GROUP-NAME]
                 [--databases=LIST] [--no-lock] 
                 [--tmpdir=DIRECTORY] [--tables-file=FILE]
                 [--history=NAME]
                 [--incremental] [--incremental-basedir]
                 [--incremental-dir] [--incremental-force-scan] [--incremental-lsn]
                 [--incremental-history-name=NAME] [--incremental-history-uuid=UUID]
                 [--close-files] [--compact]     
                 BACKUP-ROOT-DIR
```

```shell
2.普通备份

    1).备份所有数据库
        I. # innobackupex --defaults-file=/etc/mysql/my.cnf --user=root --password=123456 --host=127.0.0.1 /root/backup/
        
        II. 利用--apply-log的作用是通过回滚未提交的事务及同步已经提交的事务至数据文件使数据文件处于一致性状态
            # innobackupex --apply-log /root/backup/2019-02-26_16-19-28/

        III. 开始恢复(其实只是把文件复制到 /data/mysql/data/ 目录去) 注：恢复前，先清空 /data/mysql/data 目录 (这步开始需要关闭数据库)
            # service mysqld stop
            # innobackupex --defaults-file=/etc/mysql/my.cnf --copy-back /root/backup/2019-02-26_16-19-28/

        IV. 修改权限
            # chown mysql:mysql -R /data/mysql/data/

        V. # service mysqld start

    2).指定数据库备份
        I. # innobackupex --defaults-file=/etc/mysql/my.cnf --user=root --password=123456 --host=127.0.0.1 --no-timestamp --databases="test_db1 test_db2" /root/backup/

        II. 利用--apply-log的作用是通过回滚未提交的事务及同步已经提交的事务至数据文件使数据文件处于一致性状态
            # innobackupex --apply-log /root/backup/
        
        III.
            注意：这步开始需要关闭数据库
                # serivce mysqld stop 
            cp，因为是部分备份，不能直接用--copy-back，只能手动来复制需要的库，也要复制ibdata(数据字典)
            # cp -r /root/backup/test_db1/ /data/mysql/data/
            # cp -r /root/backup/test_db2/ /data/mysql/data/
            # cp -r /root/backup/ibdata1 /data/mysql/ibdata1

        IV. 修改权限
            # chown mysql:mysql -R /data/mysql/data/test_db1
            # chown mysql:mysql -R /data/mysql/data/test_db2
            # chown mysql:mysql ibdata1

        V. # service mysqld start

3.增量备份

    设计增量备份两次，每次都添加新的数据
    备份阶段
    1).先全量备份一个库
        # xtrabackup --defualts-file=/etc/my.cnf  --user=root --password=`cat /data/mysql_root` --databases="test_db" --backup --target-dir=/root/backup

    2).第一次增量备份
        # xtrabackup --defualts-file=/etc/my.cnf  --user=root --password=`cat /data/mysql_root` --databases="test_db" --backup --target-dir=/root/backup/inc1 --incremental-basedir=/root/backup

    3).第二次增量备份
        # xtrabackup --defualts-file=/etc/my.cnf  --user=root --password=`cat /data/mysql_root` --databases="test_db" --backup --target-dir=/root/backup/inc2 --incremental-basedir=/root/backup/inc1

    恢复阶段
    4).先 准备 恢复全量备份
        # xtrabackup --defualts-file=/etc/my.cnf  --user=root --password=`cat /data/mysql_root` --databases="test_db" --prepare --apply-log-only --target-dir=/root/backup

    5).准备 恢复第一次增量备份
        # xtrabackup --defualts-file=/etc/my.cnf  --user=root --password=`cat /data/mysql_root` --databases="test_db" --prepare --apply-log-only --target-dir=/root/backup --incremental-dir=/root/backup/inc1
```


```shell
    6).准备 恢复第二次增量备份
        # xtrabackup --defualts-file=/etc/my.cnf  --user=root --password=`cat /data/mysql_root` --databases="test_db" --prepare --target-dir=/root/backup --incremental-dir=/root/backup/inc2

    7).注意：这步开始需要关闭数据库
        # service mysqld stop
        # cp -r /root/backup/test_db/ /data/mysql/data/
        # cp -r /root/backup/ibdata1 /data/mysql/ibdata1

    8).修改权限
        # chown mysql:mysql -R /data/mysql/data/test_db
        # chown mysql:mysql ibdata1

    9). # service mysqld start
```