FROM daocloud.io/library/centos:7
MAINTAINER Feng <fengit@outlook.com>
##
# Nginx: 1.9.14
# PHP  : 7.0.5
##
#Install system library
#RUN yum update -y

ENV PHP_VERSION 7.0.5
ENV NGINX_VERSION 1.9.14

RUN yum install -y gcc \
    gcc-c++ \
    autoconf \
    automake \
    libtool \
    make \
    cmake \ 
    git && \
    yum clean all

#Install PHP library
## libmcrypt-devel DIY
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
    yum install -y wget \
    zlib \
    zlib-devel \
    openssl \
    openssl-devel \
    pcre-devel \
    libxml2 \
    libxml2-devel \
    libcurl \
    libcurl-devel \
    libpng-devel \
    libjpeg-devel \
    freetype-devel \
    libmcrypt-devel \
    openssh-server \
    python-setuptools && \
    yum clean all

#Add user
RUN groupadd -r www && \
    useradd -M -s /sbin/nologin -r -g www www

#Download nginx & php
RUN mkdir -p /home/nginx-php && cd $_ && \
    wget -c -O nginx.tar.gz http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && \
    wget -O php.tar.gz http://php.net/distributions/php-$PHP_VERSION.tar.gz && \
    curl -O -SL https://github.com/xdebug/xdebug/archive/XDEBUG_2_4_0RC3.tar.gz

#Make install nginx
RUN cd /home/nginx-php && \
    tar -zxvf nginx.tar.gz && \
    cd nginx-$NGINX_VERSION && \
    ./configure --prefix=/usr/local/nginx \
    --user=www --group=www \
    --error-log-path=/var/log/nginx_error.log \
    --http-log-path=/var/log/nginx_access.log \
    --pid-path=/var/run/nginx.pid \
    --with-pcre \
    --with-http_ssl_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --with-http_gzip_static_module && \
    make && make install

#Make install php
RUN cd /home/nginx-php && \
    tar zvxf php.tar.gz && \
    cd php-$PHP_VERSION && \
    ./configure --prefix=/usr/local/php \
    --with-config-file-path=/usr/local/php/etc \
    --with-config-file-scan-dir=/usr/local/php/etc/php.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --with-mcrypt=/usr/include \
    --with-mysqli \
    --with-pdo-mysql \
    --with-openssl \
    --with-gd \
    --with-iconv \
    --with-zlib \
    --with-gettext \
    --with-curl \
    --with-png-dir \
    --with-jpeg-dir \
    --with-freetype-dir \
    --with-xmlrpc \
    --with-mhash \
    --enable-fpm \
    --enable-xml \
    --enable-shmop \
    --enable-sysvsem \
    --enable-inline-optimization \
    --enable-mbregex \
    --enable-mbstring \
    --enable-ftp \
    --enable-gd-native-ttf \
    --enable-mysqlnd \
    --enable-pcntl \
    --enable-sockets \
    --enable-zip \
    --enable-soap \
    --enable-session \
    --enable-opcache \
    --enable-bcmath \
    --enable-exif \
    --enable-fileinfo \
    --disable-rpath \
    --enable-ipv6 \
    --disable-debug \
    --without-pear && \
    make && make install


#Add xdebug extension
#RUN cd /home/nginx-php && \
#    tar -zxvf XDEBUG_2_4_0RC3.tar.gz && \
 #   cd xdebug-XDEBUG_2_4_0RC3 && \
 #   /usr/local/php/bin/phpize && \
#    ./configure --enable-xdebug --with-php-config=/usr/local/php/bin/php-config && \
#    make && \
#    cp modules/xdebug.so /usr/local/php/lib/php/extensions/xdebug.so

RUN	cd /home/nginx-php/php-$PHP_VERSION && \
    cp php.ini-production /usr/local/php/etc/php.ini && \
    cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf

# vhost
RUN mkdir /etc/nginx/sites-enabled/ -p && mkdir /etc/nginx/sites-available/ -p
Add vhost-nginx.sh /usr/local/bin/vhost.sh
Add nginx-ci.conf /usr/local/nginx/conf/nginx-ci.conf
Add nginx-laravel.conf /usr/local/nginx/conf/nginx-laravel.conf
RUN chmod +x /usr/local/bin/vhost.sh


#Install supervisor
RUN easy_install supervisor && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/run/sshd && \
    mkdir -p /var/run/supervisord

#Add supervisord conf
ADD supervisord.conf /etc/supervisord.conf

#Remove zips
RUN cd / && rm -rf /home/nginx-php

#Create web folder
VOLUME ["/data/www", "/usr/local/nginx/conf/ssl", "/usr/local/nginx/conf/vhost", "/usr/local/php/etc/php.d"]

ADD index.php /data/www/index.php

ADD xdebug.ini /usr/local/php/etc/php.d/xdebug.ini

#Update nginx config
ADD nginx.conf /usr/local/nginx/conf/nginx.conf

# 
RUN ln -s /usr/local/php/bin/php /usr/local/bin/php && ln -s /usr/local/php/bin/phpize /usr/local/bin/phpize

#Install Composer & Laravel
RUN curl -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin --filename=composer && \
        composer config -g repo.packagist composer https://packagist.phpcomposer.com && \
        echo "export PATH=$PATH:/usr/local/php/bin:/root/.composer/vendor/bin" >> ~/.bashrc && \
        composer global require "laravel/installer" 

#Install Memcached support
#COPY libevent-2.0.22-stable.tar.gz /tmp/libevent-2.0.22-stable.tar.gz
RUN cd /tmp && \ 
	wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz && \ 
	tar -zxvf libmemcached-1.0.18.tar.gz && \ 
	cd libmemcached-1.0.18 && \ 
	./configure --prefix=/usr/local/libmemcached && \ 
	make && make install && \
	cd /tmp && \
	git clone https://github.com/php-memcached-dev/php-memcached -b php7 && \
	cd php-memcached && phpize && \ 
	./configure --with-libmemcached-dir=/usr/local/libmemcached --with-php-config=/usr/local/php/bin/php-config --disable-memcached-sasl && \ 
	make && make install
	

#Start
ADD start.sh /start.sh
ADD etc_nginx /etc/init.d/nginx
RUN chmod +x /start.sh && chmod +x /etc/init.d/nginx

#Set port
EXPOSE 80 443 9000

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]
