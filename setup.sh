#!/bin/sh

rm -rf *.zip
echo "删除历史压缩zip文件"
rm -rf *.ipa
echo "删除历史ipa文件"

#配置version_number
echo "配置version_number"
version_number=$1

bundle install
#
echo "开始打包"
fastlane beta version:$version_number

# curl -F ""
echo "打开网页"
# open https://www.pgyer.com/qxMY
