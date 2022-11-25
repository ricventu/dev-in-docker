FROM php:8.1-cli-bullseye

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /app

RUN apt update && apt install -y libzip-dev unzip \
    && docker-php-ext-install zip

RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp  \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install \
    bcmath \
    pdo_mysql

ARG PHP_INSTALL_REDIS=true
RUN if [ ${PHP_INSTALL_REDIS} = true ]; then \
  pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis \
;fi

ARG PHP_INSTALL_MONGODB=false
RUN if [ "${PHP_INSTALL_MONGODB}" = "true" ]; then \
RUN apt update && apt install -y libssl-dev && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb \
;fi

ARG PHP_INSTALL_XDEBUG=true
COPY xdebug.ini "$PHP_INI_DIR/conf.d/xdebug.ini"
RUN if [ "${PHP_INSTALL_XDEBUG}" = "true" ]; then \
    pecl install xdebug \
    && sed -e "/^zend_extension/d" \
    && docker-php-ext-enable xdebug \
;fi

RUN apt -y autoremove \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
