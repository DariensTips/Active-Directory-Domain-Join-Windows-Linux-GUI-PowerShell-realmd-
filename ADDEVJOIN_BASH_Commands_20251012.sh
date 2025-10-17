myDomain="dariens.tips"
nslookup $myDomain
dig $myDomain
sudo hostnamectl set-hostname lin24.$myDomain
realm discover $myDomain
sudo realm -v join --membership-software=samba $myDomain -U professa.ea
realm list $myDomain
id “subscribe.to@$myDomain”