# Version Control Arg
ARG VERSION=latest
# Base
FROM amazonlinux:${VERSION}
# Enable PHP 7.3 Repo
RUN ["amazon-linux-extras","enable","php7.3"]
# Clean Repo Metadata
RUN ["yum","clean","metadata"]
# Install PHP 7.3
RUN ["yum","install","php","php-{pear,cgi,devel,json,mysqlnd,pdo,fpm,mbstring,pecl-imagick,pecl-redis,pecl-zip}"]
# Install httpd
RUN ["yum","install","httpd"]
# PHP increase upload size limits
COPY ["uploads.ini","/etc/php.d/"]
# Install elasticache PHP extension
COPY ["amazon-elasticache-cluster-client.so","/etc/php.d/"]
# Prepare WordPress Themes and Plugins folders for efs
RUN ["mkdir","/var/www/html/wp-content/themes"]
RUN ["mkdir","/var/www/html/wp-content/plugins"]
# Start Apache
CMD ["systemctl","restart",'httpd']
