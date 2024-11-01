# 自定义插件源创建与上传指南

本指南将帮助您在 GitHub 上创建一个自定义插件源，并将其添加到 Sileo 中。

---

## 一、在 GitHub 上创建仓库

1. 登录 [GitHub](https://github.com/)，点击右上角头像，选择 “+ Create new(新建)” 再选择 “New repository”（新存储库）。
2. 在 `Repository name`（存储库名称）中输入仓库名称（如 `shaoxia`）。确保出现绿色对勾，表示名称可用。
3. 设置为 `Public`（公开）仓库。
4. 点击页面底部的 `Create repository` 按钮，完成仓库创建。
5. 在仓库首页的蓝色框中，点击 `creating a new file` 进入编辑页面。
6. 粘贴以下内容作为仓库的 Release 信息（前两行可自定义）：

   ```plaintext
   Origin: - 少侠的源
   Label: - 少侠的源
   Description: 本人自用, 收藏备份。
   Suite: stable
   Version: 1.0
   Architectures: iphoneos-arm64
   Components: main

	7.	滑到页面顶部，在 shaoxia 后输入 shaoxia/Release。
	8.	点击 Commit changes 提交文件。
	9.	点击右上角头像 > Settings > Pages，找到 Build and deployment，选择 main 并保存。
	10.等待几分钟后刷新页面，在 GitHub Pages 下方生成的链接即为源地址。复制该链接后，可在 Sileo 中添加并验证源。

二、安装依赖
打开 Sileo，搜索并安装以下插件：
    
   •	NewTerm 3 Beta
  	•	git
  	•	dpkg-dev
  	•	dpkg-repack
   • libdpkg-dev
  	•	openssh
	2.	插件安装完成后，进入 GitHub 仓库主页，点击绿色的 Code 按钮 > HTTPS，复制下方的链接。

三、克隆仓库到本地

	1.	打开 NewTerm 3 Beta，输入以下命令将仓库克隆到本地（将链接替换为你复制的链接），按下回车：

   
   git clone https://github.com/liym5238/shaoxia.git


	2.	等待克隆完成后，输入以下命令查看本地仓库路径：

   pwd


3.	在 Filza 文件管理器中，进入显示的路径
（例如：/var/jb/var/mobile），可以看到名为 shaoxia 的文件夹，即本地仓库。

四、配置 Git 用户信息

1.	在 NewTerm 3 Beta 中运行以下命令绑定 Git 用户名和邮箱：

   git config --global user.name "你的用户名"
   git config --global user.email "你的邮箱"



五、管理和上传插件

	1.	在 shaoxia 文件夹下新建一个 debs 文件夹。
	2.	使用 Filza 文件管理器，将 .deb 插件包复制到 shaoxia/debs 文件夹。
	3.	打开 NewTerm 3 Beta，输入以下命令进入 debs 文件夹（将 shaoxia 替换为你的仓库名称）：

cd /var/jb/var/mobile/shaoxia/debs


4.	运行以下命令生成 Packages 文件：

   
   dpkg-scanpackages . /dev/null > ../Packages


5.	使用 Filza 检查 shaoxia 文件夹内是否生成了 Packages 文件，确保内容包含插件信息。

六、上传更新到 GitHub

1.	在 NewTerm 3 Beta 中进入 shaoxia 文件夹，并执行以下命令：

   cd /var/jb/var/mobile/shaoxia
   git pull
   git add .
   git commit -m "xxx"
   git push


2.	按提示输入 GitHub 用户名，回车后输入访问令牌，等待上传完成。
	
3.	上传完成后，在 Sileo 中刷新源，查看插件是否出现。

至此，自定义插件源的创建、配置和上传流程完成！

