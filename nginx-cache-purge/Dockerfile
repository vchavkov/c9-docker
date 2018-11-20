FROM debian:jessie
LABEL maintainer="vchavkov@assistance.bg"

ENV DOCKER_IMAGE=""
ENV VHOST=""

ENV NGINX_VERSION=1.9.9
ENV NGX_CACHE_PURGE_VERSION=2.3

# Install basic packages and build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libpcre3 \
    libpcre3-dev \
    curl \
    wget \
    htop \
    dnsutils \
    sed \
    vim-tiny && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------------------------------------------------------------------------------
# configure DNS
RUN echo "nameserver 192.169.3.60" > /etc/resolv.conf

# ------------------------------------------------------------------------------
# configure /etc/hosts
RUN echo "DOCKER_IMAGE: ${DOCKER_IMAGE}" && \
echo "VHOST: ${VHOST}" && \
sed -i -e "s|${DOCKER_IMAGE}|${VHOST}|g" /etc/hosts

# Get sources
RUN cd /tmp && wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz http://labs.frickle.com/files/ngx_cache_purge-$NGX_CACHE_PURGE_VERSION.tar.gz && \
    tar -zxvf nginx-$NGINX_VERSION.tar.gz && mv nginx-$NGINX_VERSION nginx && rm nginx-$NGINX_VERSION.tar.gz && \
    tar -zxvf ngx_cache_purge-$NGX_CACHE_PURGE_VERSION.tar.gz && mv ngx_cache_purge-$NGX_CACHE_PURGE_VERSION ngx_cache_purge && rm ngx_cache_purge-$NGX_CACHE_PURGE_VERSION.tar.gz

# Configure and build software
RUN cd /tmp/nginx && ./configure \
    --sbin-path=/usr/local/sbin \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --user=www-data \
    --group=www-data \
    --with-http_gzip_static_module \
    --with-http_ssl_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --add-module=/tmp/ngx_cache_purge && \
    make && make install


# Copy configuration files into /etc/nginx and clean up config file to point to
# correct root
RUN mv /usr/local/nginx/html /var/www && \
    chown -R www-data:www-data /var/www && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /etc/nginx/sites-available && \
    mkdir -p /etc/nginx/sites-enabled && \
    sed -i 's/root\s*html;.*$/root \/var\/www;/' /etc/nginx/nginx.conf && \
    echo "\ninclude /etc/nginx/conf.d/\*.conf;" >> /etc/nginx/nginx.conf

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# nginx conf files
COPY etc/nginx /etc/nginx

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir -p /var/cache/nginx/one && \
    mkdir -p /var/cache/nginx/two && \
    mkdir -p /var/cache/nginx/three && \
    chown ${USER}:${USER} -R /var/cache/nginx 

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]