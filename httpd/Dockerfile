FROM httpd:2.4

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo 'Include /usr/local/apache2/conf/sites/*.conf' >> /usr/local/apache2/conf/httpd.conf

RUN sed -i \
    -e "s/#LoadModule proxy_module modules\/mod_proxy.so/LoadModule proxy_module modules\/mod_proxy.so/" \
    -e "s/#LoadModule proxy_http2_module modules\/mod_proxy_http2.so/LoadModule proxy_http2_module modules\/mod_proxy_http2.so/" \
    -e "s/#LoadModule proxy_fcgi_module modules\/mod_proxy_fcgi.so/LoadModule proxy_fcgi_module modules\/mod_proxy_fcgi.so/" \
    -e "s/#LoadModule rewrite_module modules\/mod_rewrite.so/LoadModule rewrite_module modules\/mod_rewrite.so/" \
    /usr/local/apache2/conf/httpd.conf

