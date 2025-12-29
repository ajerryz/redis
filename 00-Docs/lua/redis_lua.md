# Redis Lua
Redis 中使用 Lua 主要是通过 EVAL 和 EVALSHA 两个命令，用于执行 Lua 脚本。这种方式的优势在于：
- 原子性：脚本中的所有命令会作为一个整体执行，不会被其他客户端中断。
- 减少网络开销：将多个 Redis 命令打包到一个脚本中执行，减少客户端与 Redis 服务器的通信次数。
- 灵活性：利用 Lua 语言的强大功能，可以实现复杂的逻辑，例如条件判断、循环等。

# EVAL 命令
基本用法:
```shell
EVAL script numkeys key [key ...] [arg ...]

script: lua脚本
numkeys: 指后续有几个是redis的key
key [key ...]: redis的key
arg: 附加参数，通过脚本中ARGV[1],ARGV[2]获取
```

案例:
```text
# 1.案例1
127.0.0.1:6379> EVAL "return 'hello,Redis!'" 0
"hello,Redis!"

# 2.案例2
# 通过Lua将本 执行 set name zs
127.0.0.1:6379> EVAL "return redis.call('SET',KEYS[1], ARGV[1])" 1 name zs
OK
127.0.0.1:6379> get name
"zs"

#3.案例
127.0.0.1:6379> EVAL "return {KEYS[1],KEYS[2],ARGV[1],ARGV[2]}" 2 k1 v1 k2 v2
1) "k1"
2) "v1"
3) "k2"
4) "v2"
```

# EVALSHA 命令
如果脚本较长，可以先将脚本加载到 Redis 中，生成一个 SHA1 校验和，之后通过校验和执行脚本，避免每次传输脚本内容。
```text
# 1.加载脚本
127.0.0.1:6379> SCRIPT LOAD "return redis.call('GET',KEYS[1])"
"620cd258c2c9c88c9d10db67812ccf663d96bdc6"

# 2.执行脚本
127.0.0.1:6379> EVALSHA "620cd258c2c9c88c9d10db67812ccf663d96bdc6" 1 name
"zs"
```