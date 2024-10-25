#!/bin/sh
#标题
perl -p -i -e "s/111111/ColorFlow4/g"  sileo.json
#描述
perl -p -i -e "s/222222/彩色音乐4/g"  sileo.json
#支持系统
perl -p -i -e "s/333333/ios:11-12/g"  sileo.json
#更新日期
perl -p -i -e "s/444444/2020-3-1/g"  sileo.json
#插件版本
perl -p -i -e "s/555555/0.3-5/g"  sileo.json



#插件标识符
#mv cydia ColorFlow4
mv sileo.json s.json


#cp cydia样本 cydia
cp sileo样本.json sileo.json




