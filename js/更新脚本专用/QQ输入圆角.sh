#!/bin/bash

# 1. 设置 deb 文件路径（替换为实际文件名）
DEB_DIR="/var/mobile/Documents/DebBackup"
DEB_FILE="$DEB_DIR/123.deb"  # 将 123.deb 替换为实际的 deb 文件名

# 2. 设置新的插件描述和更新时间及更新日志
NEW_DESCRIPTION="### 插件介绍\n- 修改QQ聊天输入框为圆角样式\n- 插件无设置项安装即可生效。"
UPDATE_DATE="2024年10月26日"
CURRENT_DATE=$(date +'%Y-%m-%d')
CHANGELOG="发布1.0初始版本\n- > $CURRENT_DATE"

# 3. 目标 control 文件内容
CONTROL_CONTENT="Package: qqshurukuang-Rootless
Name: QQ圆角输入框-Rootless
Version: 1.0
Section: 软件增强
Architecture: iphoneos-arm64
Maintainer: lym
Author: lym
Description: 插件介绍
 - 修改QQ聊天输入框为圆角样式
 - 插件无设置项安装即可生效
SileoDepiction: https://raw.githubusercontent.com/liym5238/liym/refs/heads/main/js/qqshurukuang-Rootless.json"

# 4. 提取字段信息
PACKAGE_FIELD=$(echo "$CONTROL_CONTENT" | grep -i "^Package:" | cut -d " " -f 2-)
VERSION_FIELD=$(echo "$CONTROL_CONTENT" | grep -i "^Version:" | cut -d " " -f 2-)
NAME_FIELD=$(echo "$CONTROL_CONTENT" | grep -i "^Name:" | cut -d " " -f 2-)

# 5. 删除旧的 deb 文件（如果存在）
OLD_DEB_FILE="$DEB_DIR/${NAME_FIELD}.deb"
if [ -f "$OLD_DEB_FILE" ]; then
  rm "$OLD_DEB_FILE"
  echo "已删除旧的 deb 文件: $OLD_DEB_FILE"
fi

# 6. 创建临时解包目录
TEMP_DIR=$(mktemp -d)
dpkg-deb -R "$DEB_FILE" "$TEMP_DIR" || { echo "解包失败，检查 deb 文件路径。"; exit 1; }

# 7. 检查 DEBIAN 目录是否存在
if [ ! -d "$TEMP_DIR/DEBIAN" ]; then
  echo "错误：DEBIAN 目录缺失。"; exit 1
fi

# 8. 替换 control 文件内容
echo "$CONTROL_CONTENT" > "$TEMP_DIR/DEBIAN/control"

# 9. 重新打包 deb 文件，命名为 Name 字段内容
NEW_DEB_FILE="$DEB_DIR/${NAME_FIELD}.deb"
dpkg-deb -b "$TEMP_DIR" "$NEW_DEB_FILE" || { echo "打包失败。"; exit 1; }

# 10. 删除临时文件夹
rm -rf "$TEMP_DIR"

# 11. 生成插件描述 JSON 文件
JSON_FILE="${PACKAGE_FIELD}.json"
cat <<EOF > "$JSON_FILE"
{
    "class": "DepictionTabView",
    "headerImage": "https://liym5238.github.io/liym/icon/hengfu.png",
    "tintColor": "#87A2FF",
    "minVersion": "0.3",
    "tabs": [
        {
            "class": "DepictionStackView",
            "tabname": "描述",
            "views": [
                {
                    "text": "捐赠给开发者",
                    "action": "https://qr.alipay.com/fkx19423rvx2js7rku0hk9f",
                    "openExternal": 1,
                    "class": "DepictionButtonView"
                },
                {
                    "class": "DepictionSeparatorView"
                },
                {
                    "markdown": "$NEW_DESCRIPTION",
                    "useSpacing": true,
                    "class": "DepictionMarkdownView"
                },
                {
                    "class": "DepictionSeparatorView"
                },
                {
                    "class": "DepictionSpacerView",
                    "spacing": 16
                },
                {
                    "class": "DepictionHeaderView",
                    "title": "详细信息",
                    "useBoldText": true,
                    "useBottomMargin": false
                },
                {
                    "class": "DepictionSpacerView",
                    "spacing": 8
                },
                {
                    "class": "DepictionSeparatorView"
                },
                {
                    "class": "DepictionTableTextView",
                    "text": "$VERSION_FIELD",
                    "title": "插件版本"
                },
                {
                    "class": "DepictionTableTextView",
                    "text": "iOS 15 - iOS 16.5",
                    "title": "支持的系统"
                },
                {
                    "class": "DepictionTableTextView",
                    "text": "$UPDATE_DATE",
                    "title": "最后更新时间"
                }
            ]
        },
        {
            "class": "DepictionStackView",
            "tabname": "更新日志",
            "views": [
                {
                    "class": "DepictionMarkdownView",
                    "markdown": "### 版本 $VERSION_FIELD\n- $CHANGELOG"
                }
            ]
        }
    ]
}
EOF

echo "已生成 JSON 文件: $JSON_FILE 和新的 deb 文件: $NEW_DEB_FILE"

# 12. 删除原始 123.deb 文件
if [ -f "$DEB_FILE" ]; then
  rm "$DEB_FILE"
  echo "已删除原始 deb 文件: $DEB_FILE"
fi