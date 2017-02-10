FROM phusion/baseimage:0.9.19
MAINTAINER Victor Tran<baysao@gmail.com>
CMD ["/sbin/my_init"]

ENV VER xenial

RUN curl http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - && \
 echo "deb http://dl.hhvm.com/ubuntu ${VER} main" | tee /etc/apt/sources.list.d/hhvm.list && \
 apt-get update && apt-get install -y nginx hhvm
RUN apt-get install -y php-redis `apt-cache search php7.0 | awk '!/dev/ && !/apache/&& !/snmp/{print $1}' | tr -s '\n' ' '`
# nginx config
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./nginx-site.conf /etc/nginx/nginx-site.conf

RUN mkdir /usr/share/nginx/www -p && chown -R www-data:www-data /usr/share/nginx/www

# Start the services
RUN mkdir /etc/service/nginx
ADD nginx.sh /etc/service/nginx/run

RUN mkdir /etc/service/hhvm
ADD hhvm.sh /etc/service/hhvm/run
#ADD hhvm.sh /root/hhvm.sh

RUN /usr/share/hhvm/install_fastcgi.sh

RUN mkdir /etc/service/php-fpm
ADD php-fpm.sh /etc/service/php-fpm/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i '/daemonize /c \
  daemonize = no' /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i '/clear_env /c \
  clear_env = no' /etc/php/7.0/fpm/pool.d/www.conf

RUN ln -snf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && echo "Asia/Ho_Chi_Minh" > /etc/timezone
