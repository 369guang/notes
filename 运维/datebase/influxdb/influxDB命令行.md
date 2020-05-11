# 命令行



1. ### 查看命令 -h
```shell
Usage of influx:
-version
	Display the version and exit.
-host 'host name'
	Host to connect to.
-port 'port #'
	Port to connect to.
-socket 'unix domain socket'
  Unix socket to connect to.
-database 'database name'
  Database to connect to the server.
-password 'password'
  Password to connect to the server.  Leaving blank will prompt for password (--password '').
-username 'username'
  Username to connect to the server.
-ssl
  Use https for requests.
-unsafeSsl
  Set this when connecting to the cluster using https and not use SSL verification.
-execute 'command'
  Execute command and quit.
-type 'influxql|flux'
  Type specifies the query language for executing commands or when invoking the REPL.
-format 'json|csv|column'
  Format specifies the format of the server responses:  json, csv, or column.
-precision 'rfc3339|h|m|s|ms|u|ns'
  Precision specifies the format of the timestamp:  rfc3339, h, m, s, ms, u or ns.
-consistency 'any|one|quorum|all'
  Set write consistency level: any, one, quorum, or all
-pretty
  Turns on pretty print for the json format.
-import
  Import a previous database export from file
-pps
  How many points per second the import will allow.  By default it is zero and will not throttle importing.
-path
	Path to file to import
-compressed
  Set to true if the import file is compressed

Examples:

# Use influx in a non-interactive mode to query the database "metrics" and pretty print json:
$ influx -database 'metrics' -execute 'select * from cpu' -format 'json' -pretty

# Connect to a specific database on startup and set database context:
$ influx -database 'metrics' -host 'localhost' -port '8086'
```



2. 日常使用

   ```sh
   $ influx -database 'metrics' -host 'localhost' -port '8086' -username 'admin' -password 'fffff'
   ```

   