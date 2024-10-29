#!/bin/bash

# 切换到包含Packages文件的目录
cd cd /var/jb/var/mobile/liym

# 执行dpkg-scanpackages命令，生成Packages文件
dpkg-scanpackages . /dev/null > Packages