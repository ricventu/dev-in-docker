FROM nginx:stable-alpine

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk update \
    && apk upgrade \
    && apk --update add logrotate \
    && apk add --no-cache openssl \
    && apk add --no-cache curl \
    && apk add --no-cache bash

COPY ./scripts/create-certificate.sh /opt/
RUN mkdir /etc/nginx/ssl/ && \
    bash ./opt/create-certificate.sh default

COPY nginx.conf /etc/nginx/
