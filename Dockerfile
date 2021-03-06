# Version Control Arg
ARG VERSION=latest
# Base
FROM amazonlinux:${VERSION}
# Enable PHP 7.3 Repo
RUN ["amazon-linux-extras","enable","php7.3"]
# Clean Repo Metadata
RUN ["yum","-y","clean","metadata"]
# Install PHP 7.3 and httpd
RUN ["yum","-y","install","php","php-{pear,cgi,devel,json,mysqlnd,pdo,fpm,mbstring,pecl-imagick,pecl-redis,pecl-zip}"]
# PHP increase upload size limits
COPY ["uploads.ini","/etc/php.d/"]
# Install elasticache PHP extension
COPY ["amazon-elasticache-cluster-client.so","/etc/php.d/"]
# Prepare WordPress Themes and Plugins folders for efs
RUN ["mkdir","/var/www/html/wp-content"]
RUN ["mkdir","/var/www/html/wp-content/themes"]
RUN ["mkdir","/var/www/html/wp-content/plugins"]
# Start Apache
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
# 503147990211.dkr.ecr.us-east-1.amazonaws.com/emslynk-dev-docker-imgs