
一、数据库连接
    
    mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]

    mongodb:// 这是固定的格式，必须要指定。

    username:password@ 可选项，如果设置，在连接数据库服务器之后，驱动都会尝试登陆这个数据库

    host1 必须的指定至少一个host, host1 是这个URI唯一要填写的。它指定了要连接服务器的地址。如果要连接复制集，请指定多个主机地址。

    portX 可选的指定端口，如果不填，默认为27017

    /database 如果指定username:password@，连接并验证登陆指定数据库。若不指定，默认打开 test 数据库。

    ?options 是连接选项。如果不使用/database，则前面需要加上/。所有连接选项都是键值对name=value，键值对之间通过&或;（分号）隔开

    使用用户名和密码连接登陆到指定数据库，格式如下：
    如. mongodb://admin:123456@localhost/test


二、命令操作

1.查看所有数据库

    show dbs

    > show dbs
    admin   0.000GB
    config  0.000GB
    local   0.000GB

2.创建数据库
    (注意: 在 MongoDB 中，集合只有在内容插入后才会创建! 就是说，创建集合(数据表)后要再插入一个文档(记录)，集合才会真正创建。)

    use < database_name >

    use guang (注：此时show dbs还没有给你创建数据库)

    db.guang.insert({"name":"first insert"})

    > show dbs
    admin   0.000GB
    config  0.000GB
    guang   0.000GB
    local   0.000GB

3. 删除数据库

    db.dropDatabase()


    > use guang
    > db.dropDatabase()
    { "dropped" : "guang", "ok" : 1 }

    > show dbs
    admin   0.000GB
    config  0.000GB
    local   0.000GB

4. 删除集合

    db.collection.drop()

    use guang
    > show tables;
    guang
    site
    > db.site.drop()
    true

    > show tables;
    guang

5. 创建集合

    db.createCollection(name, options)

    name 要创建集合的名称
    options 可选参数

    字段             类型     描述
    capped           布尔   （可选）如果为 true，则创建固定集合。固定集合是指有着固定大小的集合，当达到最大值时，它会自动覆盖最早的文档。当该值为 true 时，必须指定 size 参数。
    autoIndexId      布尔   （可选）如为 true，自动在 _id 字段创建索引。默认为 false。
    size             数值   （可选）为固定集合指定一个最大值（以字节计）。如果 capped 为 true，也需要指定该字段。
    max              数值   （可选）指定固定集合中包含文档的最大数量。

    > db.createCollection("sited")
    { "ok" : 1 }
    > show collections
    guang
    sited

    创建固定集合 mycol，整个集合空间大小 6142800 KB, 文档最大个数为 10000 个。
    > db.createCollection("mycol", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )
    { "ok" : 1 }
    
    在 MongoDB 中，你不需要创建集合。当你插入一些文档时，MongoDB 会自动创建集合。
    > db.mycol2.insert({"name" : "菜鸟教程"})
    > show collections
    mycol2

6.插入文档

    MongoDB 使用 insert() 或 save() 方法向集合中插入文档，语法如下：

    db.COLLECTION_NAME.insert(document)

    > db.col.insert({title:'mysql', desc:'good'})
    WriteResult({ "nInserted" : 1 })
    > 
    > db.col.find()
    { "_id" : ObjectId("5cb04187b2cb6b4796e9d402"), "title" : "mysql", "desc" : "good" }


    作为变量插入
    > document=({title:'mongodb',desc:'goods'})
    { "title" : "mongodb", "desc" : "goods" }
    > 
    > db.col.insert(document)
    WriteResult({ "nInserted" : 1 })
    
    > db.col.find()
    { "_id" : ObjectId("5cb04187b2cb6b4796e9d402"), "title" : "mysql", "desc" : "good" }
    { "_id" : ObjectId("5cb04239b2cb6b4796e9d403"), "title" : "mongodb", "desc" : "goods" }