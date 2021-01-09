FROM nginx:stable-alpine

RUN apk update \
    && apk upgrade \
    && apk --update add logrotate \
    && apk add --no-cache openssl \
    && apk add --no-cache curl \
    && apk add --no-cache bash

RUN mkdir /etc/nginx/ssl/ && \
    openssl genrsa -out "/etc/nginx/ssl/default.key" 2048 && \
    openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK" && \
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"

COPY nginx.conf /etc/nginx/
