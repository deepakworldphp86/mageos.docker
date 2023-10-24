FROM ubuntu:20.04 as php
RUN DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="Asia/Kolkata" apt-get install -y tzdata

RUN apt-get update && \
    apt-get install -q -y  curl git zip telnet

RUN apt-get install -q -y php7.4-fpm php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip php7.4-bcmath
RUN apt-get install  -q -y git curl software-properties-common


#COPY ssmtp.conf /etc/ssmtp/
#RUN apt-get install  -qy msmtp msmtp-mta


RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer --version=1.10.16

#POSTFIX CONFIG
#RUN ./config/bootstrap.sh

RUN echo "postfix postfix/mailname string smtp.mailtrap.io" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
RUN apt-get install --assume-yes postfix

#MAIL HOG
RUN apt-get update &&\
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git &&\
    rm -rf /var/lib/apt/lists/*
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /etc/php/7.4/fpm/php.ini

RUN apt-get update && apt-get install -y \
  git \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libmcrypt-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libzip-dev \
  lsof \
  mariadb-client \
  vim \
  zip \
  unzip \
  libonig-dev \
  procps \
  libcurl4-openssl-dev \
  ssmtp\
  mutt \
  mailutils 

RUN rm -rf /var/lib/apt/lists/*
COPY ./scripts/*.sh /var/www/html/
COPY ./etc/postfix/*.cf /etc/postfix/
RUN chown postfix /etc/postfix
#RUN postmap /etc/postfix/sasl_passwd.cf
RUN /etc/init.d/postfix restart
COPY ./etc/ssmtp/*.conf /etc/ssmtp/
RUN chown www-data:www-data /var/www/html/*.sh && chmod +x /var/www/html/*.sh

USER www-data
EXPOSE 9000
CMD ["php"]
WORKDIR /var/www/html