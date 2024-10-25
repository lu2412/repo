#!/bin/bash

# 定义要查找和替换的字符串
old_url="https://trollstorex.github.io/sileodepiction/repo/banner.png"
new_url="https://liym5238.github.io/liym/icon/hengfu.png"

# 查找当前目录及其子目录中的所有 JSON 文件，并替换旧链接为新链接
find . -name "*.json" -type f -exec sed -i '' "s|$old_url|$new_url|g" {} +

echo "链接替换完成。"