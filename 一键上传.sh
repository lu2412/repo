#!/bin/bash

# GitHub仓库地址，将<your_access_token>替换为你的个人访问令牌
REMOTE_REPO="https://liym5238:<your_access_token>@github.com/liym5238/liym.git"

# 切换到Git仓库目录
cd /var/jb/var/mobile/liym || exit

# 拉取远程仓库的最新更改
git pull origin main

# 添加所有更改到暂存区
git add .

# 提交更改到本地仓库
git commit -m "xxx"

# 推送更改到远程仓库
git push origin main
