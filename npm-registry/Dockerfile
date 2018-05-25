FROM mhart/alpine-node

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache supervisor

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install -g npm-register

# Add supervisord conf
ADD conf/app.ini /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /npm-registry
VOLUME /npm-registry

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000
