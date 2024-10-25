#!/bin/bash

# JSON 文件夹路径
JSON_DIR="/var/jb/var/mobile/liym/js"

# 查找并替换 "tabname": "更新" 为 "tabname": "更新日志"
for file in "$JSON_DIR"/*.json; do
    if [[ -f "$file" ]]; then
        sed -i '' 's/"tabname": "更新"/"tabname": "更新日志"/g' "$file"
        echo "已修改文件: $file"
    fi
done

echo "所有JSON文件已处理完成。"