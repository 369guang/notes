# 存储策略	

##### 自动删除一个小时以上的原始2分钟间隔数据

CREATE RETENTION POLICY "one_hours" ON "game_ops" DURATION 1h REPLICATION 1 DEFAULT

##### 自动删除超过60天的数据

CREATE RETENTION POLICY "two_month" ON "game_ops" DURATION 60d REPLICATION 1

##### 自动删除超过1个星期的数据

CREATE RETENTION POLICY "a_week" ON "game_ops" DURATION 1w REPLICATION 1

##### 自动删除超过1天的数据

CREATE RETENTION POLICY "a_day" ON "game_ops" DURATION 1d REPLICATION 1

-----

# 连续查询

##### 自动将2分钟间隔数据聚合到5分钟的间隔数据

`CREATE CONTINUOUS QUERY "cq_5m" ON "game_ops" BEGIN SELECT game_id, mean("cpu") AS "cpu",mean("memory") AS "memory",mean("online") AS "online" INTO game1h FROM "game" GROUP BY time(5m) END`

##### 自动将5分钟间隔数据聚合到1小时的间隔数据

`CREATE CONTINUOUS QUERY "cq_1h" ON "game_ops" BEGIN SELECT mean("cpu") AS "mean_cpu",mean("memory") AS "mean_memory",mean("online") AS "mean_online" INTO "a_week"."downsampled_week_game" FROM "game" GROUP BY time(1h) END`

##### 自动将1小时间隔数据聚合到2小时的间隔数据

`CREATE CONTINUOUS QUERY "cq_2h" ON "game_ops" BEGIN SELECT mean("cpu") AS "mean_cpu",mean("memory") AS "mean_memory",mean("online") AS "mean_online" INTO "two_month"."downsampled_month_game" FROM "game" GROUP BY time(2h) END`