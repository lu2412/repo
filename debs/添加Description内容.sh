#!/bin/bash

# 目标追加的内容
append_text="\n- 源内所有插件仅供本人学习交流使用，下载后请于24小时内删除!"

# 遍历当前目录下的所有 .deb 文件
for deb_file in *.deb; do
  # 创建临时目录
  temp_dir=$(mktemp -d)

  # 解包 deb 文件
  dpkg-deb -R "$deb_file" "$temp_dir"

  # 定位 control 文件
  control_file="$temp_dir/DEBIAN/control"

  # 检查 control 文件是否存在
  if [ -f "$control_file" ]; then
    # 读取当前 Description 内容并追加新内容
    sed -i "/^Description:/ s/$/$append_text/" "$control_file"
  else
    echo "在 $deb_file 中未找到 control 文件，跳过..."
    rm -rf "$temp_dir"
    continue
  fi

  # 打包为新 deb 文件，命名为 original_name_modified.deb
  dpkg-deb -b "$temp_dir" "${deb_file%.deb}_modified.deb"

  # 清理临时目录
  rm -rf "$temp_dir"
done

echo "所有 .deb 文件已处理完毕。"