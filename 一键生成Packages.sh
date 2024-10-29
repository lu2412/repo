#!/bin/bash

# 切换到包含 Packages 文件的目录
cd /var/jb/var/mobile/liym

# 删除原有的 Packages 文件（如果存在）
if [ -f Packages ]; then
    rm Packages
fi

# 执行 dpkg-scanpackages 命令，生成新的 Packages 文件
dpkg-scanpackages . /dev/null > Packages

