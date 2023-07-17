#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Modify default IP
sed -i 's/192.168.1.1/192.168.100.252/g' package/base-files/files/bin/config_generate
#
########### 设置密码为空（可选） ###########
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
#
# 删除老argon
rm -rf feeds/luci/themes/luci-theme-argon
# 拉取argon主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# 拉取sirpdboy主题
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
#
#添加应用管理
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#添加vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb
git clone https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr
#添加adguardhome
svn co https://github.com/kenzok8/small-package/trunk/luci-app-adguardhome package/luci-app-adguardhome
#添加系统高级设置
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
#添加alist
git clone https://github.com/sbwml/luci-app-alist package/alist
#添加smartdns
svn co https://github.com/kenzok8/small-package/trunk/luci-app-smartdns package/luci-app-smartdns
#添加bypass
svn co https://github.com/kenzok8/small-package/trunk/luci-app-bypass package/luci-app-bypass
#添加passwall2
svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
#添加poweroff
svn co https://github.com/kenzok8/small-package/trunk/luci-app-poweroff package/luci-app-poweroff
#添加OpenClash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
#添加istore
svn co https://github.com/linkease/istore/trunk/luci/taskd package/taskd
svn co https://github.com/linkease/istore/trunk/luci/luci-lib-xterm package/luci-lib-xterm
svn co https://github.com/linkease/istore/trunk/luci/luci-lib-taskd package/luci-lib-taskd
svn co https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
svn co https://github.com/linkease/istore/trunk/luci/luci-app-store package/luci-app-store
