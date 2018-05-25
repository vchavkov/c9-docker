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
# RUN echo "deb http://deb.nodesource.com/node_8.x stretch main" >> /etc/apt/sources.list
# RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
# RUN apt-get install -y nodejs

# ------------------------------------------------------------------------------
# yarn
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list
RUN wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# install global nodejs modules
RUN apt-get update && \
apt-get -y install yarn

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir -p /npm-register/cache
WORKDIR /npm-register
VOLUME /npm-register

# Add supervisord conf
ADD conf/etc/supervisor/conf.d/cloud9.conf /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# Install npm-registry
RUN npm install node-gyp && \
npm install bcrypt && \
npm install npm-register

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
