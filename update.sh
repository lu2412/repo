#!/bin/bash

# 切换到包含Packages文件的目录
cd /var/jb/var/mobile/liym

# 检查Packages文件是否存在，如果存在，则压缩为.gz格式，覆盖已存在的.gz文件
if [ -f Packages ]; then
    gzip -f Packages
fi

# 执行dpkg-scanpackages命令，生成Packages文件
dpkg-scanpackages . /dev/null > Packages
