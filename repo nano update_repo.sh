#!/bin/zsh
# 屏蔽perl语言警告
export LC_ALL=C
# 进入仓库根目录
cd /var/jb/var/mobile/repo

echo "=== 1. 删除旧Packages索引 ==="
rm -f Packages

echo "=== 2. 扫描所有deb生成新Packages ==="
dpkg-scanpackages . /dev/null > Packages

echo "=== 3. 拉取远程GitHub最新代码 ==="
git pull -q

echo "=== 4. 提交改动到本地仓库 ==="
git add .
git commit -q -m "自动更新源Packages索引" || true

echo "=== 5. 推送至GitHub远程仓库 ==="
git push -q

echo "✅ 软件源更新全部完成！"