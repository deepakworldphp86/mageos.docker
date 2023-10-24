FROM php:7.4.16-fpm-alpine

RUN apk add --update mysql-client && rm -rf /var/cache/apk/*

RUN apk update  && apk upgrade\
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS gcc g++ autoconf tar \
        libxslt-dev \
        tidyhtml-dev \
        net-snmp-dev \
        aspell-dev \
        freetds-dev \
        openldap-dev \
        gettext-dev \
        imap-dev \
        openssh \
        sudo \
        make \
        shadow \
        libmcrypt-dev \
        gmp-dev \
        openssl \
        curl \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        libzip-dev \
        bzip2-dev \
        postgresql-dev \
        supervisor \
        bash \
        telnet \
        network-manager \
        iproute2 \
        net-tools \
        git \
        default-mysql-client \
        pngquant \
        jpegoptim \
        zip \
        icu-dev \
        libxml2-dev \
        dcron \
        wget \
        ssmtp \
        mutt \
        rsync \
        ca-certificates \
        oniguruma-dev \
    && phpModules=" \
            bcmath \
            bz2 \
            calendar \
            exif \
            gd \
            gettext \
            gmp \
            imap \
            intl \
            ldap \
            mysqli \
            pcntl \
            pdo_dblib \
            pdo_mysql \
            pdo_pgsql \
            pgsql \
            pspell \
            shmop \
            snmp \
            soap \
            sockets \
            sysvmsg \
            sysvsem \
            sysvshm \
            zip \
            tidy \
            xsl " \
    && NPROC=$(getconf _NPROCESSORS_ONLN) \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j${NPROC} $phpModules

    RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer --version=1.10.16

    COPY --from=golang:1.13-alpine /usr/local/go/ /usr/local/go/
    ENV PATH="/usr/local/go/bin:${PATH}"
    RUN go version
    RUN go get github.com/mailhog/mhsendmail
    RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
    RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini

#    RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
#    RUN echo "postfix postfix/mailname string smtp.mailtrap.io" | debconf-set-selections
#    RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
#    RUN apt-get --update --no-cache add --assume-yes postfix

    ENV PHP_MEMORY_LIMIT 2G
    ENV PHP_PORT 9000
    ENV PHP_PM dynamic
    ENV PHP_PM_MAX_CHILDREN 10
    ENV PHP_PM_START_SERVERS 4
    ENV PHP_PM_MIN_SPARE_SERVERS 2
    ENV PHP_PM_MAX_SPARE_SERVERS 6
    ENV APP_MAGE_MODE default

    COPY ./bin/startup.sh /usr/local/bin/startup.sh
    COPY ./conf/php.ini /usr/local/etc/php/php.ini
    COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
    RUN rm -rf /var/lib/apt/lists/*
    COPY ./scripts/*.sh /var/www/html/
    COPY ./etc/ssmtp/*.conf /etc/ssmtp/
    RUN chown www-data:www-data /var/www/html/*.sh && chmod +x /var/www/html/*.sh

    USER www-data
    EXPOSE 9000
    WORKDIR /var/www/html
    CMD [ "sh", "/usr/local/bin/startup.sh" ]