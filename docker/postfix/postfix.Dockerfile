FROM php:7.4-fpm

#ENV COMPOSER_HOME /var/www/.composer

RUN apt-get update && \
    apt-get install -q -y  git zip postfix mailutils

RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer --version=1.10.16


#MAIL HOG

RUN apt-get update &&\
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git &&\
    rm -rf /var/lib/apt/lists/*
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini
    
RUN apt-get update && apt-get install -y \
  git \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libzip-dev \
  lsof \
  default-mysql-client \
  vim \
  zip \
  libonig-dev \
  procps \
  libcurl4-openssl-dev \
  curl

RUN  docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  intl \
  mbstring \
  mysqli \
  opcache \
  pcntl \
  pdo_mysql \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  xsl \
  zip


RUN rm -rf /var/lib/apt/lists/*
COPY ./scripts/*.sh /var/www/
COPY etc/ssmtp/ssmtp.cf  /etc/ssmtp/
#RUN chown www-data:www-data /var/www/*.sh && chmod +x /var/www/*.sh

USER www-data
   
WORKDIR /var/www/html    
