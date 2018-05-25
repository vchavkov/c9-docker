FROM mhart/alpine-node

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache supervisor

# Add supervisord conf
ADD conf/app.ini /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir -p /npm-registry/cache
VOLUME /npm-registry
WORKDIR /npm-registry

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install npm-register --save

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000
