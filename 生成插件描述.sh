#!/bin/bash

# 切换到包含Packages文件的目录
cd /path/to/your/packages/directory

# 执行dpkg-scanpackages命令，生成Packages文件
dpkg-scanpackages . /dev/null > Packages