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
# 删除英文版netdata
rm -rf feeds/luci/applications/luci-app-netdata
# 拉取定时设置
git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
# 拉取argon主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# 拉取sirpdboy主题
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
# 拉取中文版netdata
git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
# 添加系统高级设置
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# 添加ddns-go
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
# 添加应用管理
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# 添加vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb
git clone https://github.com/free-diy/luci-app-vssr.git package/lean/luci-app-vssr
# eqosplus定时限速
git clone https://github.com/sirpdboy/luci-app-eqosplus.git package/luci-app-eqosplus
# 管控过滤及访问限制
git clone --depth 1 --filter=blob:none --sparse https://github.com/281677160/openwrt-package.git;Lede package/cache
pushd package/cache
git sparse-checkout set luci-app-control-weburl \
luci-app-control-webrestriction \
mv -f */ ../../../
popd
popd && rm -rf package/cache
# 添加adguardhome，smartdns，bypass，poweroff
git clone --depth 1 --filter=blob:none --sparse https://github.com/kenzok8/small-package.git package/cache
pushd package/cache
git sparse-checkout set luci-app-adguardhome \
luci-app-smartdns \
luci-app-bypass \
luci-app-poweroff \
mv -f */ ../../../../
popd
popd && rm -rf package/cache
# 添加OpenClash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# 添加istore
svn export https://github.com/linkease/istore/trunk/luci/taskd package/taskd
svn export https://github.com/linkease/istore/trunk/luci/luci-lib-xterm package/luci-lib-xterm
svn export https://github.com/linkease/istore/trunk/luci/luci-lib-taskd package/luci-lib-taskd
svn export https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
svn export https://github.com/linkease/istore/trunk/luci/luci-app-store package/luci-app-store
