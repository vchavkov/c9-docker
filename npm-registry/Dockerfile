FROM mhart/alpine-node:8

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache bash bash-doc bash-doc bash-completion git supervisor curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++

# Add supervisord conf
ADD conf/app.ini /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdri -p /usr/lib/node_modules && \
chown nobody. -R /usr/lib/node_modules && \
mkdir -p /npm-register/cache
VOLUME /npm-register
WORKDIR /npm-register

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install -g npm-register

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000
