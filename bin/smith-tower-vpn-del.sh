#!/bin/bash 
#
# fix route to smith tower vpn after PPP is connected..
# (connect first)
#
# ifconfig ppp0
# (shoudl return 17.16.1.16 as the gateway IP)
#
# NOTE: route is removed automatically (os-x) with ppp0 is disconnected
#
smithtowernet=192.168.0.0
ifppp=$(ifconfig ppp0)
if [ $? -ne 0 ]; then
    echo "VPN Not Connected"
    exit 1
fi
vpngw=$(ifconfig ppp0 | grep 'inet' | cut -d' ' -f2 | awk '{ print $1}')
sudo route -n delete -net $smithtowernet/16 $vpngw
