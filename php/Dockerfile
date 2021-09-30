ARG PHP_VERSION=7.3
FROM php:${PHP_VERSION}-fpm

WORKDIR /var/www

ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN pear config-set php_ini "$PHP_INI_DIR/php.ini"

RUN apt-get update
RUN docker-php-ext-install pdo pdo_mysql

# MONGO DB
ARG INSTALL_MONGO=false
RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongodb extension
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
      pecl install mongo && \
      docker-php-ext-enable mongo \
    ;fi && \
    apt-get install -y libssl-dev && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb \
;fi

# MYSQLI
ARG INSTALL_MYSQLI=false
RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli && docker-php-ext-enable mysqli \
;fi

# GETTEXT
ARG INSTALL_GETTEXT=false
RUN if [ ${INSTALL_GETTEXT} = true ]; then \
    docker-php-ext-install gettext && docker-php-ext-enable gettext \
    && apt-get install -y locales \
;fi

RUN apt-get install -y \
      sendmail \
      unzip \
      libzip-dev \
    && docker-php-ext-install zip

ARG INSTALL_SYSVSEM=false
RUN if [ ${INSTALL_SYSVSEM} = true ]; then \
    docker-php-ext-install sysvsem && docker-php-ext-enable sysvsem \
;fi

# GD
ARG INSTALL_GD=false
RUN if [ ${INSTALL_GD} = true ]; then \
    if [ $(php -r "echo PHP_MINOR_VERSION;") = "3" ]; then \
      apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-enable gd \
    ; else \
      apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev  libwebp-dev \
        && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-enable gd \
    ; fi \
;fi

ARG INSTALL_REDIS=true
RUN if [ ${INSTALL_REDIS} = true ]; then \
  pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis \
;fi

ARG INSTALL_COMPOSER=true
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
    curl https://getcomposer.org/composer-1.phar --output /usr/bin/composer1 \
    && chmod +x /usr/bin/composer1 \
;fi

COPY install-composer.sh  /opt/
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
    chmod +x /opt/install-composer.sh && /opt/install-composer.sh \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer \
;fi

# XDEBUG
ARG INSTALL_XDEBUG=true
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  pecl install xdebug \
  && sed -e "/^zend_extension/d" \
  && docker-php-ext-enable xdebug \
;fi

RUN sed -i \
  -e "s/pm\.max_children.*/pm.max_children=100/" \
  "$PHP_INI_DIR/../php-fpm.d/www.conf"

ARG INSTALL_PYTHON=false
RUN if [ ${INSTALL_PYTHON} = true ]; then \
  apt-get install -y python python3-pip \
;fi

ARG INSTALL_GIT=true
RUN if [ ${INSTALL_GIT} = true ]; then \
    apt-get install -y git \
;fi


ARG INSTALL_NODE=true
RUN if [ ${INSTALL_NODE} = true ]; then \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
      && export NVM_DIR="$HOME/.nvm" && \. "$NVM_DIR/nvm.sh" \
      && nvm install 14 && npm install -g yarn \
;fi

# Locales
RUN sed -i -e 's/.*it_IT/it_IT/' /etc/locale.gen && locale-gen

COPY install*.*  /opt/
RUN [ -f /opt/install.sh ] && chmod +x /opt/install*.* && /opt/install.sh

# CLEANUP
RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY php.ini "$PHP_INI_DIR/conf.d/99-php.ini"
COPY www.conf "$PHP_INI_DIR/../php-fpm.d/www.conf"

COPY ./bashrc /root/.bashrc

RUN echo "export PATH=~/.composer/vendor/bin/:\${PATH}" >> /root/.bashrc

COPY ./vimrc /root/.vimrc

