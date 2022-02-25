FROM php:8.1-cli

WORKDIR /app

ENV DEBIAN_FRONTEND noninteractive

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get install -y \
    sendmail \
    libzip-dev unzip \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev \
    git

RUN docker-php-ext-install pdo pdo_mysql zip \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install opcache

RUN pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis

ARG INSTALL_COMPOSER=false
COPY install-composer.sh  /opt/
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
    chmod +x /opt/install-composer.sh && /opt/install-composer.sh \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer \
;fi

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    pecl install xdebug \
    && sed -e "/^zend_extension/d" \
    && docker-php-ext-enable xdebug \
;fi

RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

