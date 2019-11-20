FROM phusion/baseimage
MAINTAINER Miguel Neyra <mneyra@americatel.com.pe>
# Based on work done by Based on work done by (https://github.com/vbkunin/itop-docker)

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:ondrej/php \
	&& apt-get update

RUN apt-get install -y \
    apache2 \
    php7.1 php7.1-xml php7.1-mysql php7.1-json php7.1-mcrypt php7.1-mbstring php7.1-ldap php7.1-soap php7.1-zip php7.1-gd \
    graphviz \
	mariadb-server pwgen \
    git wget unzip nano

# Copy configs and scripts
COPY artifacts/setup-itop-cron.sh /setup-itop-cron.sh
COPY artifacts/itop-cron.logrotate /etc/logrotate.d/itop-cron

# Copy iTop config-file rights management scripts
COPY artifacts/make-itop-config-writable.sh /make-itop-config-writable.sh
COPY artifacts/make-itop-config-read-only.sh /make-itop-config-read-only.sh

RUN chmod +x /*.sh
# Create shortcuts for the right management scripts
RUN ln -s /make-itop-config-writable.sh /usr/local/bin/conf-w
RUN ln -s /make-itop-config-read-only.sh /usr/local/bin/conf-ro

# Get iTop
RUN mkdir -p /tmp/itop
RUN wget --no-check-certificate -O /tmp/itop/itop.zip https://sourceforge.net/projects/itop/files/itop/2.5.1/iTop-2.5.1-4123.zip
RUN unzip /tmp/itop/itop.zip -d /tmp/itop/
RUN mkdir /var/www/html/itop
RUN cp -R /tmp/itop/web/* /var/www/html/itop

RUN chown -R www-data:www-data /var/www/html

COPY service /etc/service/
RUN chmod +x -R /etc/service

RUN mkdir /etc/itop && ln -s /etc/itop /var/www/html/itop/conf && chown -R www-data: /etc/itop

# Configure Timezone America/Lima
RUN sed -i 's/;date.timezone =/date.timezone = America\/Lima/g' /etc/php/7.1/apache2/php.ini
RUN cp /usr/share/zoneinfo/America/Lima /etc/localtime
RUN echo "America/Lima" > /etc/timezone

RUN apt-get clean

EXPOSE 80 3306
