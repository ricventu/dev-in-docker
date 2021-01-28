ARG PHP_VERSION=7.3
FROM php:${PHP_VERSION}-fpm

WORKDIR /var/www

ENV DEBIAN_FRONTEND noninteractive
# ENV TZ=UTC

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

# XDEBUG
ARG INSTALL_XDEBUG=true
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  # Install the xdebug extension
  if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
    pecl install xdebug-2.5.5; \
  else \
    if [ $(php -r "echo PHP_MINOR_VERSION;") = "0" ]; then \
      pecl install xdebug-2.9.0; \
    else \
      pecl install xdebug; \
    fi \
  fi && \
  docker-php-ext-enable xdebug \
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


# GD
ARG INSTALL_GD=false
RUN if [ ${INSTALL_GD} = true ]; then \
    apt-get install -y sendmail libpng-dev && \
    docker-php-ext-install gd && docker-php-ext-enable gd \
;fi

RUN apt-get install -y \
      unzip \
      libzip-dev \
    && docker-php-ext-install zip

ARG INSTALL_SYSVSEM=false
RUN if [ ${INSTALL_SYSVSEM} = true ]; then \
    docker-php-ext-install sysvsem && docker-php-ext-enable sysvsem \
;fi

ARG INSTALL_COMPOSER=true
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
    curl https://getcomposer.org/composer-1.phar --output /usr/bin/composer \
    && chmod +x /usr/bin/composer \
;fi

ARG INSTALL_GIT=true
RUN if [ ${INSTALL_GIT} = true ]; then \
    apt-get install -y git \
;fi

ARG INSTALL_PYTHON=false
RUN if [ ${INSTALL_PYTHON} = true ]; then \
  apt-get install -y python python-pip \
;fi

# CONFIG FILE
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN sed -i \
  -e "s/short_open_tag.*/short_open_tag=On/" \
  -e "s/display_errors.*/display_errors=Off/" \
  -e "s/post_max_size.*/post_max_size=1024M/" \
  -e "s/upload_max_filesize.*/upload_max_filesize=1024M/" \
  -e "s/memory_limit.*/memory_limit=-1/" \
  -e "s/max_execution_time.*/max_execution_time=-1/" \
  "$PHP_INI_DIR/php.ini"

RUN sed -i \
  -e "s/pm\.max_children.*/pm.max_children=100/" \
  "$PHP_INI_DIR/../php-fpm.d/www.conf"

COPY ./install.d /opt/install.d
RUN for file in "/opt/install.d/*.sh" ; do \
      bash $file \
    ;done

# CLEANUP
RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
