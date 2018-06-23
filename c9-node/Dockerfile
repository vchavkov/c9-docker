FROM mhart/alpine-node:8

ARG USER=vchavkov
ARG PUID=1000
ARG PGID=1000

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Install supervisor
RUN apk add --no-cache bash bash-completion git supervisor wget curl ca-certificates make gcc g++ python linux-headers binutils-gold gnupg libstdc++ && \
update-ca-certificates 2>/dev/null || true

# ------------------------------------------------------------------------------
# create user
RUN addgroup -g ${PGID} -S ${USER} && \
    adduser -u ${PUID} -S ${USER} -G ${USER}

# ------------------------------------------------------------------------------
# install NVM
RUN wget "https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh" --output-document=/home/${USER}/install.sh
RUN chown ${USER}:${USER} /home/${USER}/install.sh && \
chmod +x /home/${USER}/install.sh && \
/bin/bash /home/${USER}/install.sh

# ------------------------------------------------------------------------------
# .bashrc
ADD conf/.bashrc /home/${USER}/

# ------------------------------------------------------------------------------
# install node_modules
#RUN "source /home/${USER}/.bashrc" su - ${USER}
RUN "/bin/bash" su - ${USER}
RUN "/bin/bash nvm install 8" su - ${USER}
RUN "/bin/bash nvm alias default 8" su - ${USER}
RUN "/bin/bash npm install -g node-gyp bcrypt grunt-cli gulp knex-migrator sqlite3" su - ${USER}

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/vchavkov/c9-core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

# Add supervisord conf
ADD conf/cloud9.ini /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Add user vchavkov
RUN useradd -r -s /bin/false vchavkov

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80
