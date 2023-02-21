#!/bin/bash
# -*- coding:utf-8 -*-
# @Emoj: （￣︶￣）↗　
# @Time: DATE TIME
# @Author: wangxi
# @Email: 674860357@qq.com
# @File: go-install.sh
# @Description: 
# Go-1.18.4 的卸载
# linux 版本: Centos7.8-x86_x64

# 字符串转化成数组
tags1=($(docker images | awk '/ago/{print $1 }' | xargs))
tags2=($(docker images | awk '/ago/{print $2 }' | xargs))
len=${#tags1[*]}

# 数组遍历 01
for ((i=0;i<len;i++)); do
    echo ${tags1[i]}":"${tags2[i]}
done