#!/bin/bash

# 设置需要替换的内容
OLD_TEXT="liym5238/liym"
NEW_TEXT="lu2412/repo"

# 检查是否有 .deb 文件
if ! ls *.deb >/dev/null 2>&1; then
    echo "当前文件夹中没有 .deb 文件"
    exit 1
fi

# 遍历当前目录下的所有 .deb 文件
for deb_file in *.deb; do
    echo "正在处理文件: $deb_file"

    # 创建临时目录
    temp_dir=$(mktemp -d)

    # 解压 .deb 文件
    dpkg-deb -R "$deb_file" "$temp_dir" || { echo "解压失败: $deb_file"; rm -rf "$temp_dir"; continue; }

    # 检查 control 文件是否存在
    control_file="$temp_dir/DEBIAN/control"
    if [ -f "$control_file" ]; then
        echo "找到 control 文件，开始替换字符"
        
        # 输出替换前内容，使用 cat -v 显示特殊字符
        echo "替换前内容:"
        cat -v "$control_file"

        # 替换字符
        if grep -q "$OLD_TEXT" "$control_file"; then
            sed -i "" "s|$OLD_TEXT|$NEW_TEXT|g" "$control_file" && \
            echo "已替换字符: $OLD_TEXT -> $NEW_TEXT" || \
            echo "替换失败: $deb_file"
        else
            echo "未找到字符: $OLD_TEXT，可能存在编码或换行符问题"
        fi

        # 输出替换后内容
        echo "替换后内容:"
        cat -v "$control_file"
    else
        echo "未找到 control 文件，跳过: $deb_file"
    fi

    # 重新打包 .deb 文件
    dpkg-deb -b "$temp_dir" "$deb_file" && echo "已更新并重新打包: $deb_file" || echo "打包失败: $deb_file"

    # 清理临时目录
    rm -rf "$temp_dir"
done

echo "所有文件处理完成！"