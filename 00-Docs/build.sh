#!/bin/bash


#
# 从redis源码构建输出到bin目录
#

set -x
cd ..
SOURCE_HOME="$PWD"

make & make PREFIX="$SOURCE_HOME" install
cp redis.conf sentinel.conf "$SOURCE_HOME/bin"
make clean