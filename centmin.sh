#!/bin/bash
# Установка дополнительных приложений и утилит
yum -y install nano yum-utils
yum -y upgrade
# create initial persistent config file to override centmin.sh defaults
# https://centminmod.com/upgrade.html#persistent
mkdir -p /etc/centminmod
wget https://raw.githubusercontent.com/sanikovich/centminmod/main/custom_config.inc -O /etc/centminmod/custom_config.inc

# install centmin mod latest beta with php-fpm 7.4 default
yum -y update
curl -O https://raw.githubusercontent.com/centminmod/centminmod/123.09beta01/installer74.sh && chmod 0700 installer74.sh && bash installer74.sh

# pre-create Nginx HTTPS site’s dhparam file before hand to speed up subsequent Nginx vhost creation routines. On slow systems, this command will take a few minutes to complete.
openssl dhparam -out /usr/local/nginx/conf/ssl/dhparam.pem 2048

# setup extended CSF Firewall blocklists https://community.centminmod.com/posts/50060/
/usr/local/src/centminmod/tools/csf-advancetweaks.sh

# enable CSF Firewall native fail2ban like support
# https://community.centminmod.com/posts/62343/
csf --profile backup backup-b4-customregex
cp -a /usr/local/csf/bin/regex.custom.pm /usr/local/csf/bin/regex.custom.pm.bak
egrep 'CUSTOM1_LOG|CUSTOM2_LOG|CUSTOM3_LOG|CUSTOM4_LOG' /etc/csf/csf.conf
sed -i "s|CUSTOM1_LOG = .*|CUSTOM1_LOG = \"/home/nginx/domains/\*/log/access.log\"|" /etc/csf/csf.conf
sed -i "s|CUSTOM2_LOG = .*|CUSTOM2_LOG = \"/home/nginx/domains/\*/log/error.log\"|" /etc/csf/csf.conf
sed -i "s|CUSTOM3_LOG = .*|CUSTOM3_LOG = \"/var/log/nginx/localhost.access.log\"|" /etc/csf/csf.conf
sed -i "s|CUSTOM4_LOG = .*|CUSTOM4_LOG = \"/var/log/nginx/localhost.error.log\"|" /etc/csf/csf.conf
egrep 'CUSTOM1_LOG|CUSTOM2_LOG|CUSTOM3_LOG|CUSTOM4_LOG' /etc/csf/csf.conf
wget -O /usr/local/csf/bin/regex.custom.pm https://gist.github.com/centminmod/f5551b92b8aba768c3b4db84c57e756d/raw/regex.custom.pm
csf -ra

# cloudflare cronjob
# https://community.centminmod.com/threads/6241/
crontab -l > cronjoblist
sed -i '/csfcf.sh/d' cronjoblist
echo "23 */12 * * * /usr/local/src/centminmod/tools/csfcf.sh auto >/dev/null 2>&1" >> cronjoblist
crontab cronjoblist


# MALDET 
wget https://raw.githubusercontent.com/sanikovich/centminmod/main/maldet.sh -O /usr/local/src/centminmod/addons/maldet.sh
/usr/local/src/centminmod/addons/maldet.sh

cd /usr/local/src/centminmod/addons/; ./customcurl.sh
yum update -y --enablerepo=city-fan.org --disableplugin=priorities
package-cleanup -y --oldkernels --count=1

echo "Done!"
