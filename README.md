# GitHub 仓库创建与 Sileo 源上传教程

本教程帮助您在 GitHub 上创建仓库，生成个人访问令牌，上传 `.deb` 文件到 GitHub，并将其添加到 Sileo 中。

---

## 创建 GitHub 仓库

1. 在浏览器中打开 [GitHub](https://github.com/) 并登录您的账户。
2. 点击右上角头像，选择 `+ Create new` 然后选择`New repository`。（创建新仓库）
3. 在 `Repository name` 中输入仓库名称（如 `shaoxia`），确认名称可用（会出现绿色对勾）。
4. 选择 `Public` 作为仓库类型（公开仓库），然后点击 `Create repository`。（创建仓库）
5. 会跳转到新页面,在新页面中，点击 `creating a new file` 创建文件。（创建新文件）
6. 在编辑页面粘贴以下内容：

   ```plaintext
   Origin: - 少侠的源(可自行修改)
   Label: - 少侠的源(可自行修改)
   Description: 本人自用, 收藏备份。(可自行修改)
   Suite: stable
   Version: 1.0
   Architectures: iphoneos-arm64
   Components: main

7.	然后在页面最上方将文件命名为 shaoxia/Release，然后点击 Commit changes。（提交更改）
8.	在仓库页面点击 ... > Settings，进入 Pages。（仓库设置 > 页面）
9.	在 Build and deployment(构建和部署)下选择 main，点击 Save(存储)
10.	等待 2 分钟，刷新页面。找到 GitHub Page 下的链接并复制，作为源地址添加到 Sileo 进行使用。

## 创建 GitHub 个人访问令牌

1.	点击 GitHub 网站右上角头像 > Settings。（设置）
2.	在其中找到并依次点击它 `Developer settings (开发者设置)>`Personal access tokens (个人访问令牌 )>`Generate new token（生成新令牌）

3.	输入描述性名称（如 iOS 开发），至少选择 repo 权限。（设置令牌权限）(也可以全部选择)也就是全部打上✅

4.	点击 Generate token(生成令牌)并将生成的令牌复制到剪贴板，自行进行保存（页面关闭后无法再次查看）。

### 安装所需插件
1.打开 Sileo，搜索并安装以下插件：

     -  NewTerm 3 Beta （命令行终端）
     -  git （版本控制工具）
     -  dpkg-dev （Debian 软件包开发工具）
     -  dpkg-repack （重新打包已安装的 .deb 文件）
     -  libdpkg-dev （dpkg 开发库）
     -  openssh （SSH 连接工具）

### 克隆 GitHub 仓库
1. 查看仓库HTTPS链接

在自己的GitHub仓库主页。页面中央偏右的位置
会看到一个标有“Code”（代码）的绿色按钮。
点击该按钮旁边的倒三角图标，选择“HTTPS”选项，
然后复制显示在下方的URL链接。



2.	打开 NewTerm 3 Beta，输入以下命令将仓库克隆到本地
（此处替换为自己的 HTTPS 链接，将仓库克隆到本地）


         git clone https://github.com/liym5238/shaoxia.git


2.	克隆完成后，输入 pwd 命令查看本地路径（如 /var/jb/var/mobile）。（显示当前目录路径）
使用 Filza 文件管理器进入此路径，确认 shaoxia 文件夹已创建。
	3.	绑定 Git 用户信息：

git config --global user.name "用户名"
git config --global user.email "您的邮箱"

（绑定 Git 用户名和邮箱）

生成 Packages 文件

	1.	在 shaoxia 文件夹中创建 debs 文件夹。
	2.	将 .deb 插件包复制到 shaoxia/debs 文件夹中。
	3.	在 NewTerm 3 Beta 中，输入以下命令生成 Packages 文件：

cd /var/jb/var/mobile/shaoxia/debs
dpkg-scanpackages . /dev/null > ../Packages

（生成 Packages 文件）

	4.	使用 Filza 查看 shaoxia 文件夹下的 Packages 文件，确保内容显示 .deb 插件包的信息。（确认文件内容）

更新仓库到 GitHub

	1.	在 NewTerm 3 Beta 中，输入以下命令初始化 Git 并将文件推送到 GitHub：

cd /var/jb/var/mobile/shaoxia
git pull
git add .
git commit -m "更新"
git push

（添加、提交并推送到 GitHub）

	2.	系统将提示输入 GitHub 用户名和令牌。在提示输入 Username 时输入 GitHub 用户名，输入 Password 时粘贴令牌。
	3.	完成上传后，在 Sileo 刷新源并验证是否成功添加 .deb 文件。

至此，您的 GitHub 仓库已成功创建，并且可以在 Sileo 中访问并更新源！

