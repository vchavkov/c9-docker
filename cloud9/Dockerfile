# Pull base image.
FROM debian
LABEL maintainer="vchavkov@assistance.bg"

ENV C9_USER=${C9_USER};
ENV C9_PASS=${C9_PASS};

# Install Supervisor.
RUN \
    echo "deb http://deb.nodesource.com/node_4.x stretch main" >> /etc/apt/sources.list && \
    apt-get update && apt-get -y --allow-unauthenticated install \
    curl \
    gnupg \
    gnupg1 \
    gnupg2 \
    build-essential \
    supervisor \
    git \
    nodejs \
    vim-tiny && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    apt-get update && apt-get -y install yarn && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm install grunt-cli bower grunt-sass

# Define mountable directories.
VOLUME ["/etc/supervisor/conf.d"]

# Determine runlevel and services at startup [BOOT-5180]
RUN update-rc.d supervisor defaults

# Define working directory.
WORKDIR /etc/supervisor/conf.d

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/vchavkov/c9-core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh && \
sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js

# Add supervisord conf
ADD conf/cloud9.conf /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# Define working directory.
WORKDIR /root

# ------------------------------------------------------------------------------
# Add ssh keys
RUN mkdir .ssh
ADD ssh/id_rsa /root/.ssh/id_rsa
ADD ssh/id_rsa.pub /root/.ssh/id_rsa.pub
ADD ssh/authorized_keys /root/.ssh/authorized_keys
ADD ssh/known_hosts /root/.ssh/known_hosts
RUN chmod 0600 /root/.ssh/id_rsa

# ------------------------------------------------------------------------------
# Add .bashrc configuration
ADD conf/.bashrc /root/

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80
EXPOSE 2368

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]