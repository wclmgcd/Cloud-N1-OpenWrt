#!/bin/bash

sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

#修改密码
sed -i 's/^root:.*:/root:$1$q6Qf.IUu$Bd2tIMFHYYNOsmsIRBwHC0:19650:0:99999:7:::/g' package/base-files/files/etc/shadow

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release

# geodata
# wget -q -cP files/usr/share/v2ray https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
# wget -q -cP files/usr/share/v2ray https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat

# Add luci-app-amlogic
git clone --single-branch --depth=1 https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic

# Set kernel md5 to pass opkg dependency check
K_MD5=$(curl -sL "https://downloads.immortalwrt.org/releases/$REPO_VER/targets/armsr/armv8/immortalwrt-$REPO_VER-armsr-armv8.manifest" | grep kernel immortalwrt-$REPO_VER-armsr-armv8.manifest | awk -F- '{print $NF}')
sed -i -e "s/^\(.\).*vermagic$/\1echo $K_MD5 > \$(LINUX_DIR)\/.vermagic/" include/kernel-defaults.mk



