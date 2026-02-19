#!/bin/bash
REPO_ROOT="$(dirname "$0")/.."
POOL_DIR="$REPO_ROOT/pool"
DEPICTIONS_DIR="$REPO_ROOT/depictions"
STATS_BASE_URL="https://lu2412.github.io/repo/stats"
DEB_BASE_URL="https://lu2412.github.io/repo/pool"

mkdir -p "$DEPICTIONS_DIR"

find "$POOL_DIR" -name "*.deb" | while read -r deb_path; do
  # 从 deb 提取信息
  pkg_id="$(dpkg-deb -I "$deb_path" 2>/dev/null | grep -A10 "Package:" | awk '/Package:/{print $2}')"
  version="$(dpkg-deb -I "$deb_path" 2>/dev/null | grep -A10 "Version:" | awk '/Version:/{print $2}')"
  author="$(dpkg-deb -I "$deb_path" 2>/dev/null | grep -A10 "Maintainer:" | awk '/Maintainer:/{sub(/^.*</,""); sub(/>.*$/,""); print $0}')"
  if [ -z "$author" ]; then author="MacXK"; fi

  # 计算 deb 文件名和 URL
  deb_name="$(basename "$deb_path")"
  deb_url="$DEB_BASE_URL/$deb_name"

  # 生成 depiction JSON 文件名
  dep_file="$DEPICTIONS_DIR/${pkg_id}.json"

  # 写入 JSON
  cat > "$dep_file" <<EOF
{
    "class": "DepictionTabView",
    "headerImage": "https://lu2412.github.io/repo/icon/hengfu.png",
    "tintColor": "#87A2FF",
    "minVersion": "0.3",
    "tabs": [
        {
            "class": "DepictionStackView",
            "tabname": "描述",
            "views": [
                {
                    "text": "App Store 下载",
                    "action": "https://apps.apple.com/cn/app/酷我音乐纯净版/id1594175673",
                    "openExternal": 1,
                    "class": "DepictionButtonView"
                },
                {
                    "class": "DepictionMarkdownView",
                    "markdown": "### 插件介绍\n- VIP 功能解锁\n- 无设置项，安装即生效\n- 仅供学习交流，24小时内删除"
                },
                {
                    "class": "DepictionScreenshotsView",
                    "itemCornerRadius": 15,
                    "itemSize": "{1, 1}",
                    "screenshots": []
                },
                {
                    "class": "DepictionHeaderView",
                    "title": "版本详细说明",
                    "useBoldText": true,
                    "useBottomMargin": false
                },
                {
                    "class": "DepictionStackView",
                    "orientation": "horizontal",
                    "views": [
                        {
                            "class": "DepictionStackView",
                            "views": [
                                {
                                    "class": "DepictionLabelView",
                                    "text": "插件版本",
                                    "textColor": "#8E8E93"
                                },
                                {
                                    "class": "DepictionLabelView",
                                    "text": "$version",
                                    "fontSize": 24
                                }
                            ]
                        },
                        {
                            "class": "DepictionSpacerView",
                            "flex": 1
                        },
                        {
                            "class": "DepictionStackView",
                            "views": [
                                {
                                    "class": "DepictionLabelView",
                                    "text": "插件更新时间",
                                    "textColor": "#8E8E93"
                                },
                                {
                                    "class": "DepictionLabelView",
                                    "text": "$(date +"%Y-%m-%d %H:%M:%S")",
                                    "fontSize": 24
                                }
                            ]
                        }
                    ]
                },
                {
                    "class": "DepictionStackView",
                    "orientation": "horizontal",
                    "views": [
                        {
                            "class": "DepictionStackView",
                            "views": [
                                {
                                    "class": "DepictionLabelView",
                                    "text": "插件大小",
                                    "textColor": "#8E8E93"
                                },
                                {
                                    "class": "DepictionTableTextView",
                                    "title": "",
                                    "action": "$deb_url",
                                    "openExternal": 0,
                                    "parse": 1,
                                    "pattern": "Content-Length:\\\\s*(\\\\d+)",
                                    "transform": "bytesToSize",
                                    "text": "加载中…"
                                }
                            ]
                        },
                        {
                            "class": "DepictionSpacerView",
                            "flex": 1
                        },
                        {
                            "class": "DepictionStackView",
                            "views": [
                                {
                                    "class": "DepictionLabelView",
                                    "text": "插件系统兼容",
                                    "textColor": "#8E8E93"
                                },
                                {
                                    "class": "DepictionLabelView",
                                    "text": "15 ~ 17",
                                    "fontSize": 24
                                }
                            ]
                        }
                    ]
                },
                {
                    "class": "DepictionStackView",
                    "orientation": "horizontal",
                    "views": [
                        {
                            "class": "DepictionStackView",
                            "views": [
                                {
                                    "class": "DepictionLabelView",
                                    "text": "下载次数",
                                    "textColor": "#8E8E93"
                                },
                                {
                                    "class": "DepictionTableTextView",
                                    "title": "",
                                    "action": "$STATS_BASE_URL/downloads.count",
                                    "openExternal": 0,
                                    "parse": 1,
                                    "pattern": "$(echo "$pkg_id" | sed 's/\./\\\\./g')=(\\\\d+)",
                                    "text": "加载中…"
                                }
                            ]
                        },
                        {
                            "class": "DepictionSpacerView",
                            "flex": 1
                        },
                        {
                            "class": "DepictionStackView",
                            "views": [
                                {
                                    "class": "DepictionLabelView",
                                    "text": "上个用户下载时间",
                                    "textColor": "#8E8E93"
                                },
                                {
                                    "class": "DepictionTableTextView",
                                    "title": "",
                                    "action": "$STATS_BASE_URL/last_download_time",
                                    "openExternal": 0,
                                    "parse": 1,
                                    "pattern": "$(echo "$pkg_id" | sed 's/\./\\\\./g')=(.+)",
                                    "text": "加载中…"
                                }
                            ]
                        }
                    ]
                },
                {
                    "class": "DepictionHeaderView",
                    "title": "详细信息",
                    "useBoldText": true,
                    "useBottomMargin": false
                },
                {
                    "class": "DepictionTableTextView",
                    "text": "$author",
                    "title": "插件作者"
                }
            ]
        },
        {
            "class": "DepictionStackView",
            "tabname": "更新日志",
            "views": [
                {
                    "class": "DepictionMarkdownView",
                    "markdown": "### 版本 $version\n- 初始版本 / 修复已知问题"
                }
            ]
        }
    ]
}
EOF

  echo "✅ 已生成：$dep_file"
done

echo "🎉 全部插件 Depiction 生成完成，路径：$DEPICTIONS_DIR"