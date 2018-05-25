FROM mhart/alpine-node:8

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache bash bash-doc bash-doc bash-completion git supervisor curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++

# Add supervisord conf
ADD conf/app.ini /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir -p /npm-register/cache

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install npm-register --save

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000
