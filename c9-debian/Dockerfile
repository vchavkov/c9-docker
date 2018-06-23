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
#RUN echo "deb http://deb.nodesource.com/node_8.x stretch main" >> /etc/apt/sources.list
#RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
#RUN apt-get install -y nodejs

# ------------------------------------------------------------------------------
# yarn
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list
RUN wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# install global nodejs modules
RUN apt-get update && \
apt-get -y install yarn

# ------------------------------------------------------------------------------
# create user vchavkov
RUN useradd -m -p vchavkov -s /bin/bash vchavkov
RUN echo "vchavkov ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# ------------------------------------------------------------------------------
# install NVM
RUN  su -c "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash" - vchavkov

# ------------------------------------------------------------------------------
# .bashrc
ADD conf/.bashrc /home/vchavkov/

RUN su -c "nvm install 8" - vchavkov
RUN su -c "nvm alias default 8" - vchavkov
RUN su -c "npm install -g grunt-cli gulp knex-migrator sqlite3" - vchavkov

# Determine runlevel and services at startup [BOOT-5180]
RUN update-rc.d supervisor defaults

# Add supervisord conf
ADD conf/etc/supervisor/conf.d/cloud9.conf /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# enable ghost cli
ADD conf/etc/profile.d/ghost.sh /etc/profile.d/
RUN chmod 0755 /etc/profile.d/ghost.sh

# ------------------------------------------------------------------------------
# add ssh keys
ADD conf/.ssh /home/vchavkov/.ssh
RUN chmod 0600 /home/vchavkov/.ssh/id_rsa

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
RUN ./scripts/install-sdk.sh && \
sed -i -e 's_127.0.0.1_0.0.0.0_g' configs/ghost.js && \
chown vchavkov. -R /workspace

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
