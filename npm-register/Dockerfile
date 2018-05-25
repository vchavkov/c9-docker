FROM mhart/alpine-node:8

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache bash bash-doc bash-doc bash-completion git supervisor curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++

# Add supervisord conf
ADD conf/app.ini /etc/supervisor.d/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir -p /npm-register/cache
WORKDIR /npm-register

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install npm-register --save

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000

# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
