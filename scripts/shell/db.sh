#!/bin/bash
# -*- coding:utf-8 -*-
# description: 创建redis, mysql, phpmyadmin镜像

# 创建mysql文件夹
mkdir -p  /etc/mysql/conf.d/ /var/lib/mysql/  /var/log/mysql/
chmod 777 /var/lib/mysql/  /var/log/mysql/ /etc/mysql/
# 创建mysql配置文件
touch /etc/mysql/conf.d/my.conf
cat > /etc/mysql/conf.d/my.conf <<EOF
[client]
#password	= your_password
port		= 3306
socket		= /var/run/mysqld/mysqld.sock

[mysqld]
port		= 3306
# 在容器"/etc/mysql/mysql.conf.d/mysqld.cnf"中已经设置
# pid-file        = /var/run/mysqld/mysqld.pid
# socket          = /var/run/mysqld/mysqld.sock
# datadir         = /var/lib/mysql
# log-error      = /var/log/mysql/error.log
default_storage_engine = InnoDB
performance_schema_max_table_instances = 400
table_definition_cache = 400
skip-external-locking
key_buffer_size = 32M
max_allowed_packet = 100G
table_open_cache = 128
sort_buffer_size = 768K
net_buffer_length = 4K
read_buffer_size = 768K
read_rnd_buffer_size = 256K
myisam_sort_buffer_size = 8M
thread_cache_size = 16
query_cache_size = 16M
tmp_table_size = 32M
sql-mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

explicit_defaults_for_timestamp = true
#skip-name-resolve
max_connections = 500
max_connect_errors = 100
open_files_limit = 65535

log-bin=mysql-bin
binlog_format=mixed
server-id = 1
expire_logs_days = 10
# 慢查询开关
slow_query_log=1
# 慢查询日志文件
slow-query-log-file=/var/log/mysql/mysql-slow.log
# 慢查询时间设置
long_query_time=3
# 未使用索引的语句也记录到慢查询日志
#log_queries_not_using_indexes=on
early-plugin-load = ""

innodb_data_home_dir = /var/lib/mysql
innodb_data_file_path = ibdata1:10M:autoextend
innodb_log_group_home_dir = /var/lib/mysql
innodb_buffer_pool_size = 128M
innodb_log_file_size = 64M
innodb_log_buffer_size = 16M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 50
innodb_max_dirty_pages_pct = 90
innodb_read_io_threads = 1
innodb_write_io_threads = 1

[mysqldump]
quick
max_allowed_packet = 500M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 32M
sort_buffer_size = 768K
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout
EOF

# 创建redis文件夹
mkdir -p  /etc/redis/conf.d/ /var/lib/redis/  /var/log/redis/
chmod 777 /var/lib/redis/  /var/log/redis/ /etc/redis/
# 创建redis配置文件
touch /etc/redis/conf.d/redis.conf
cat > /etc/redis/conf.d/redis.conf <<EOF
# 详细配置参考官方文档: https://redis.io/docs/management/config-file/
# 默认只允许本机访问, 注释后允许所有主机访问
# bind 127.0.0.1

protected-mode yes
# 默认端口
port 6379

tcp-backlog 511

# 空闲连接超时时间,0表示不断开
timeout 0
tcp-keepalive 300

# daemonize即后台模式，如果为YES 会的导致 redis 无法启动，因为后台会导致docker无任务可做而退出
daemonize no 
supervised no
pidfile /var/run/redis.pid 

# Specify the server verbosity level.
# This can be one of:
# debug (a lot of information, useful for development/testing)
# verbose (many rarely useful info, but not a mess like the debug level)
# notice (moderately verbose, what you want in production probably)
# warning (only very important / critical messages are logged)
loglevel notice
logfile "/var/log/redis/redis.log"

# 数据库数量
databases 16

# 启动时, 是否显示redis的logo
always-show-logo yes

#   In the example below the behaviour will be to save:
#   after 900 sec (15 min) if at least 1 key changed
#   after 300 sec (5 min) if at least 10 keys changed
#   after 60 sec if at least 10000 keys changed
save 900 1
save 300 10
save 60 10000

stop-writes-on-bgsave-error yes
rdbcompression yes
rdbchecksum yes

# The filename where to dump the DB
dbfilename dump.rdb

# The working directory.
dir /var/lib/redis/

# 数据库主从复制
# replica-serve-stale-data yes
# replica-read-only yes
# repl-diskless-sync no
# repl-diskless-sync-delay 5
# repl-disable-tcp-nodelay no
# replica-priority 100
# 设置密码
requirepass 123456
# 最大连接数
maxclients 10000
# 最大使用内存，0表示不限制
maxmemory 0

lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
replica-lazy-flush no

# 追加模式保存数据
# appendonly no
# appendfilename "appendonly.aof"
# appendfsync everysec
# no-appendfsync-on-rewrite no
# auto-aof-rewrite-percentage 100
# auto-aof-rewrite-min-size 64mb
# aof-load-truncated yes
# aof-use-rdb-preamble yes
# lua-time-limit 5000

# 慢查询: 默认为microseconds
slowlog-log-slower-than 10000

# There is no limit to this length. Just be aware that it will consume memory.
# You can reclaim memory used by the slow log with SLOWLOG RESET.
slowlog-max-len 128

# latency-monitor-threshold 0

# 时间通知
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
stream-node-max-bytes 4096
stream-node-max-entries 100
activerehashing yes

client-output-buffer-limit normal 0 0 0
client-output-buffer-limit replica 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
dynamic-hz yes
aof-rewrite-incremental-fsync yes
rdb-save-incremental-fsync yes
EOF

# 创建docker-compose.yaml文件
mkdir -p $HOME/db
touch $HOME/db/docker-compose.yaml
cat > $HOME/db/docker-compose.yaml <<EOF
version: '3'
services:
  mysql:
    image: swr.cn-north-4.myhuaweicloud.com/wx-2022/mysql-x86_x64:5.7
    ports:
    - "3306:3306"
    volumes:                   
    - /etc/localtime:/etc/localtime:ro          # 容器同步宿主机时间
    - /etc/mysql/conf.d/:/etc/mysql/conf.d/:ro  # mysql配置文件
    - /var/lib/mysql/:/var/lib/mysql/:rw        # mysql数据文件, 需要手动赋予文件夹777权限
    - /var/log/mysql/:/var/log/mysql/:rw        # mysql日志文件, 需要手动赋予文件夹777权限
    environment:
    - MYSQL_ROOT_PASSWORD=123456
    networks:
    - mynet

  redis:
    image: swr.cn-north-4.myhuaweicloud.com/wx-2022/redis-x86_x64:6.2
    volumes:                   
    - /etc/localtime:/etc/localtime:ro
    - /etc/redis/conf.d/:/etc/redis/conf.d/:ro  # redis配置文件
    - /var/lib/redis/:/var/lib/redis/:rw        # redis数据文件, 需要手动赋予文件夹777权限
    - /var/log/redis/:/var/log/redis/:rw        # redis日志文件, 需要手动赋予文件夹777权限
    ports:
    - "6379:6379"
    command: redis-server /etc/redis/conf.d/redis.conf
    networks:
    - mynet

  myadmin:
    image: swr.cn-north-4.myhuaweicloud.com/wx-2022/phpmyadmin-x86_x64:5.2
    volumes:                   
    - /etc/localtime:/etc/localtime:ro
    ports:
    - "8888:80"
    environment:
    - PMA_HOST=mysql
    networks:
    - mynet
    depends_on:
    - mysql

networks:
  mynet:
EOF

echo -e "\033[32m数据库全部文件安装成功!!!(^_^)\033[0m"
cd $HOME/db && docker-compose up -d
echo -e "\033[32m所有数据库镜像创建成功!!!(^_^)\033[0m"