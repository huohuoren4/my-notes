#!/bin/bash
# -*- coding:utf-8 -*-

# 字符串转化成数组
tags1=($(docker images | awk '/ago/{print $1 }' | xargs))
tags2=($(docker images | awk '/ago/{print $2 }' | xargs))
len=${#tags1[*]}

# 数组遍历 01
for ((i=0;i<len;i++)); do
    echo ${tags1[i]}":"${tags2[i]}
done