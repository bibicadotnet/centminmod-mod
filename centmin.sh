locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
timedatectl set-timezone Asia/Ho_Chi_Minh
mkdir -p /etc/centminmod
touch /etc/centminmod/custom_config.inc
echo "PUREFTPD_DISABLED='y'" >> /etc/centminmod/custom_config.inc
echo "PHP_PGO_ALWAYS='y'" >> /etc/centminmod/custom_config.inc
echo "PHP_PGO='y'" >> /etc/centminmod/custom_config.inc
echo "PHP_BROTLI='y'" >> /etc/centminmod/custom_config.inc
echo "PHP_LZFOUR='y'" >> /etc/centminmod/custom_config.inc
echo "PHP_LZF='y'" >> /etc/centminmod/custom_config.inc
echo "PHP_ZSTD='y'" >> /etc/centminmod/custom_config.inc
echo "SET_DEFAULT_MYSQLCHARSET='utf8mb4'" >> /etc/centminmod/custom_config.inc
echo "NGINX_LIBBROTLI='y'" >> /etc/centminmod/custom_config.inc
echo "NGXDYNAMIC_BROTLI='y'" >> /etc/centminmod/custom_config.inc
echo "WPCLI_CE_QUERYSTRING_INCLUDED='y'" >> /etc/centminmod/custom_config.inc
echo "NGINX_SSLCACHE_ALLOWOVERRIDE='y'" >> /etc/centminmod/custom_config.inc
echo "NGINX_STAPLE_CACHE_OVERRIDE='y'" >> /etc/centminmod/custom_config.inc
echo "NGINX_STAPLE_CACHE_TTL='86400'" >> /etc/centminmod/custom_config.inc
echo "AUTOHARDTUNE_NGINXBACKLOG='y'" >> /etc/centminmod/custom_config.inc
echo "ZSTD_LOGROTATE_NGINX='y'" >> /etc/centminmod/custom_config.inc
echo "ZSTD_LOGROTATE_PHPFPM='y'" >> /etc/centminmod/custom_config.inc
yum -y update; curl -O https://centminmod.com/betainstaller82.sh && chmod 0700 betainstaller82.sh && bash betainstaller82.sh
