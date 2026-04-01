#!/bin/bash


#
# 从redis源码构建输出到bin目录
#

set -x
SOURCE_HOME="$PWD/0/redis-bin"


make & make PREFIX="$SOURCE_HOME" install
cp redis.conf sentinel.conf "$SOURCE_HOME"
#make clean