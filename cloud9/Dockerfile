# Pull base image.
FROM debian
LABEL maintainer="vchavkov@assistance.bg"

# Install Supervisor.
RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get dist-upgrade -y && \
    apt-get -y install \
    sudo \
    curl \
    wget \
    gnupg \
    gnupg1 \
    gnupg2 \
    build-essential \
    python-dev \
    automake \
    autoconf \
    libtool \
    m4 \
    autotools-dev \
    libssl-dev \
    pkg-config \
    libev-dev \
    libncurses5-dev \
    vim-tiny \
    supervisor \
    tmux \
    sqlite3 \
    git \
    htop \
    nmap \
    tcpdump \
    mc \
    moreutils \
    dos2unix \
    unrar-free \
    zip && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------------------------------------------------------------------------------
# nodejs
RUN echo "deb http://deb.nodesource.com/node_8.x stretch main" >> /etc/apt/sources.list
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt-get install -y nodejs

# ------------------------------------------------------------------------------
# yarn
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list
RUN wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# install global nodejs modules
RUN apt-get update && \
apt-get -y install yarn

# ------------------------------------------------------------------------------
# .bashrc
ADD conf/.bashrc /root/

# ------------------------------------------------------------------------------
# .netrc
ADD conf/.netrc /root/
RUN chmod 0600 /root/.netrc

# ------------------------------------------------------------------------------
# .gitconfig
ADD conf/.gitconfig /root/

# ------------------------------------------------------------------------------
# install npm global modules
# RUN chmod +x /root/.nvm/nvm.sh && \
# /root/.nvm/nvm.sh install 8.11.2 && \
# /root/.nvm/nvm.sh alias default 8.11.2 && \
# /root/.nvm/versions/node/v8.11.2/bin/npm install -g grunt-cli gulp knex-migrator node-sass

# Define mountable directories.
VOLUME ["/etc/supervisor/conf.d"]

# Determine runlevel and services at startup [BOOT-5180]
RUN update-rc.d supervisor defaults

# Define working directory.
WORKDIR /etc/supervisor/conf.d
# Add supervisord conf
ADD conf/etc/supervisor/conf.d/cloud9.conf /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# enable ghost cli
ADD conf/etc/profile.d/ghost.sh /etc/profile.d/
RUN chmod 0755 /etc/profile.d/ghost.sh

# ------------------------------------------------------------------------------
# add ssh keys
ADD conf/.ssh /root/.ssh
RUN chmod 0600 /root/.ssh/id_rsa

# ------------------------------------------------------------------------------
# wachman
WORKDIR /tmp
RUN git clone https://github.com/facebook/watchman.git
WORKDIR /tmp/watchman
RUN ./autogen.sh
RUN ./configure
RUN make -j 32
RUN make install

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone http://git.assistance.bg:8080/c9-core /cloud9
WORKDIR /cloud9
RUN ./scripts/install-sdk.sh
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' configs/ghost.js

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
