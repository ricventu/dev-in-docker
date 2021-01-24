FROM nginx:stable-alpine

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
