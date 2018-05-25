FROM mhart/alpine-node:8

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache bash bash-doc bash-doc bash-completion git supervisor curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir -p /etc/supervisor.d && \
mkdir -p  /var/log/supervisor && \
mkdir -p /npm-register/cache
WORKDIR /npm-register

# Add supervisord conf
ADD conf/app.ini /etc/supervisor.d/

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install node-gyp && \
npm install bcrypt && \
npm install npm-register

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000

# Start supervisor, define default command.
CMD ["bash" "supervisord", "-c", "/etc/supervisord.conf"]
