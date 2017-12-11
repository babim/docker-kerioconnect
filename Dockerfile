FROM babim/debianbase

RUN apt-get update && \
    apt-get install -y git wget build-essential libpcre3 libpcre3-dev libssl-dev libtool autoconf apache2-dev libxml2-dev libcurl4-openssl-dev

#make modsecurity
RUN cd /usr/src/ && \
    git clone https://github.com/SpiderLabs/ModSecurity.git /usr/src/modsecurity && \
    cd /usr/src/modsecurity && \
    ./autogen.sh && \
    ./configure --enable-standalone-module --disable-mlogc && \
    make

#make nginx
ENV NGINXVERSION 1.13.7
RUN cd / && \
    wget http://nginx.org/download/nginx-$NGINXVERSION.tar.gz && \
    tar xvzf nginx-$NGINXVERSION.tar.gz && \
    cd ../nginx-$NGINXVERSION && \
    ./configure --user=root --group=root --with-debug --with-ipv6 --with-http_ssl_module --add-module=/usr/src/modsecurity/nginx/modsecurity --with-http_ssl_module --without-http_access_module --without-http_auth_basic_module --without-http_autoindex_module --without-http_empty_gif_module --without-http_fastcgi_module --without-http_referer_module --without-http_memcached_module --without-http_scgi_module --without-http_split_clients_module --without-http_ssi_module --without-http_uwsgi_module && \
    make && \
    make install
RUN rm /nginx-$NGINXVERSION.tar.gz

#configure env
RUN ln -s /usr/local/nginx/sbin/nginx /bin/nginx && \
    cp /usr/src/modsecurity/unicode.mapping /usr/local/nginx/conf/ && \
    mkdir -p /opt/modsecurity/var/audit/

#install signature
RUN git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/src/owasp-modsecurity-crs && \
    cp -R /usr/src/owasp-modsecurity-crs/rules/ /usr/local/nginx/conf/
#    mv /usr/local/nginx/conf/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf{.example,} && \
#    mv /usr/local/nginx/conf/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf{.example,}

# clean
RUN apt-get purge -y build-essential wget git

# add config
ADD nginx.conf /usr/local/nginx/conf/nginx.conf
ADD modsec_includes.conf /usr/local/nginx/conf/modsec_includes.conf
ADD modsecurity.conf /usr/local/nginx/conf/modsecurity.conf
ADD crs-setup.conf /usr/local/nginx/conf/rules/crs-setup.conf

# Copy include file
COPY include/*.conf /usr/local/nginx/conf/include/
COPY conf.d/ /usr/local/nginx/conf/conf.d

# prepare start
RUN mkdir -p /etc-start/nginx \
	&& cp -R /usr/local/nginx/* /etc-start/nginx
	
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Define default command.
CMD nginx -g 'daemon off;'

EXPOSE 80
