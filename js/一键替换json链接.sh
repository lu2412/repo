#!/bin/bash

# 要替换的旧字符串
old_string="liym5238.github.io/liym"

# 要替换成的新字符串
new_string="lu2412.github.io/repo"

# 查找当前目录下所有的 JSON 文件，并替换字符串
find . -type f -name "*.json" -print0 | while IFS= read -r -d '' file; do
    echo "正在处理文件: $file"
    
    # 使用 sed 替换文件中的旧字符串为新字符串，适用于 macOS 和 Linux
    sed -i '' "s|$old_string|$new_string|g" "$file" 2>/dev/null || sed -i "s|$old_string|$new_string|g" "$file"

    # 检查替换是否成功
    if grep -q "$new_string" "$file"; then
        echo "替换成功: $file"
    else
        echo "替换失败: $file"
    fi
done

echo "替换完成。"