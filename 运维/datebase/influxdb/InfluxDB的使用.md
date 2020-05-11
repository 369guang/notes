

# InfluxDB时序数据库的使用

-----

## InfluxDB与传统数据库的关系

| influxDB 中的名词 | 传统数据库中的概念 |
| :---------------: | :----------------: |
|     database      |       数据库       |
|    measurement    |    数据库中的表    |
|      Points       |    表数据中的行    |

小提示：ON后面接的都是数据库名称

----

## 1.数据库管理

#### 	(1). 创建数据库

`create database game_ops`

#### 	(2). 查看所有数据库

> `show databases`

#### 	(3). 删除数据库

> `drop database game_ops`

#### (4). 进入该数据库

> `use game_ops`

##### (5). 查询数据库中所有的表

> `SHOW MEASUREMENTS`

#### (6).插入数据

##### 			注意：game为表名

>  `insert game,cpu=10,memory=20,online=30,game_id=1`

#### (7). 删除表

​			`drop measurement "game_ops"`

----

## 2. 数据保存策略

#### (1).查询当前的Retention Policies (简称RP)

> SHOW RETENTION POLICIES ON "game_ops"	
>
> 一般默认一个
>
> ```bash
> name   duration shardGroupDuration replicaN default
> 
> ----   -------- ------------------ -------- -------
> 
> autogen  0s    168h0m0s      1    false
> ```

#### (2). 创建新的RP

> `create retention rolicy "rp_name" on "db_name" DURATION 30d REPLICATION 1 DEFAULT`
>
> 1. ##### rp_name:：策略名称
>
> 2. ##### db_name：具体应用到数据库名
>
> 3. ##### 30d：保存30天，30天之前的数据将被删除，他的单位还有（h：小时，w：星期）
>
> 4. ##### REPLICATION 1 ：副本个数，因为是单节点，所以填1
>
> 5. ##### DEFAULT：设置为默认策略

#### (3). 修改RP

```mysql
ALTER RETENTION POLICY "rp_name" ON "db_name" DURATION 3w DEFAULT
```

#### (4). 删除RP

```mysql
DROP RETENTION POLICY "rp_name" on "db_name"
```

----



## 3.连续查询（Continuous Queries）

#### 	(1). 当前数据库的CQ

```sql
SHOW CONTINUOUS QUERIES
```

#### 	(2). 创建新的CQ

	create continuous query cq_30m on game_ops BEGIN SELECT mean(cpu) INTO game30m FROM game GROUP BY TIME(5m) END`
	
	##### 1. cq_30m： 连续查询的名字
	
	##### 2. game_ops: 数据库名称
	
	##### 3. mean(cpu): 求平均值
	
	##### 4. game : 当前表名
	
	##### 5. game30m： 存新数据的表名
	
	##### 6. 30m：时间间隔为30分钟
	
		>```bash
		>> SHOW MEASUREMENTS
		>name: measurements
		>------------------
		>name
		>weather
		>weather30m
		>```

#### 	(3). 删除CQ

	DROP CONTINUOUS QUERY <cq_name> ON <database_name>