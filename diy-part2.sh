# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Modify default IP
sed -i 's/192.168.1.1/192.168.100.252/g' package/base-files/files/bin/config_generate
#
########### 设置密码为空（可选） ###########
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

##### 移除要替换的包
# 删除老argon
rm -rf feeds/luci/themes/luci-theme-argon
# 删除英文版netdata
rm -rf feeds/luci/applications/luci-app-netdata

##### Git稀疏克隆
# 参数1是分支名, 参数2是仓库地址, 参数3是子目录，同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

##### Themes
# 拉取argon主题
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# 拉取sirpdboy主题
#git clone --depth=1 https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd

##### 添加额外插件
# 拉取中文版netdata
git clone --depth=1 -b master https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
# 添加系统高级设置
git clone --depth=1 https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
# 拉取定时设置
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
# eqosplus定时限速
git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus
# 添加管控过滤,访问限制
git_sparse_clone Lede https://github.com/281677160/openwrt-package luci-app-control-weburl luci-app-control-webrestriction
# 添加adguardhome,smartdns,poweroff
git_sparse_clone main https://github.com/kenzok8/small-package luci-app-adguardhome luci-app-smartdns luci-app-poweroff
# 添加ddns-go
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go package/ddns-go
# 添加istore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci
# 添加应用管理
#git clone --depth=1 -b master https://github.com/destan19/OpenAppFilter package/OpenAppFilter
# 添加vssr
#git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
#git clone --depth=1 https://github.com/free-diy/luci-app-vssr package/luci-app-vssr

# 科学上网插件
git clone --depth=1 -b master https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
