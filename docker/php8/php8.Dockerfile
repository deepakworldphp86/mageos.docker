FROM php:8.2-fpm

#ENV COMPOSER_HOME /var/www/.composer
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd


RUN apt-get update && \
    apt-get install -y git zip

RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer --version=2.2.9

   

RUN composer config --global process-timeout 2000
    
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
  default-mysql-client \
  libxslt1-dev \
  libzip-dev \
  lsof \
  telnet \
  network-manager \
  iproute2 \
  net-tools \
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

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_PORT 9008
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 4
ENV PHP_PM_MIN_SPARE_SERVERS 2
ENV PHP_PM_MAX_SPARE_SERVERS 6
ENV APP_MAGE_MODE default
RUN rm -rf /var/lib/apt/lists/*

COPY ../../env.sample /var/www/.env
COPY ../scripts/*.sh /var/www/
RUN chown www-data:www-data /var/www/*.sh && chmod +x /var/www/*.sh

USER www-data
   
WORKDIR /var/www/html   