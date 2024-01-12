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

#####
function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/
    rm -rf $repo
}
# 添加管控过滤,访问限制,adguardhome,smartdns,bypass,poweroff,istore,OpenClash
merge_package https://github.com/281677160/openwrt-package.git openwrt-package/luci-app-control-webrestriction
merge_package https://github.com/281677160/openwrt-package.git openwrt-package/luci-app-control-weburl
merge_package https://github.com/kenzok8/small-package.git small-package/luci-app-adguardhome
merge_package https://github.com/kenzok8/small-package.git small-package/luci-app-smartdns
merge_package https://github.com/kenzok8/small-package.git small-package/luci-app-bypass
merge_package https://github.com/kenzok8/small-package.git small-package/luci-app-poweroff
merge_package https://github.com/vernesong/OpenClash.git OpenClash/luci-app-openclash
merge_package https://github.com/linkease/istore.git istore/luci/taskd
merge_package https://github.com/linkease/istore.git istore/luci/luci-lib-xterm
merge_package https://github.com/linkease/istore.git istore/luci/luci-lib-taskd
merge_package https://github.com/linkease/istore.git istore/luci/luci-app-store
merge_package https://github.com/linkease/istore-ui.git istore-ui/app-store-ui
