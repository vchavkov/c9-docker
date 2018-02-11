# Pull base image.
FROM debian
LABEL maintainer="vchavkov@assistance.bg"

ENV C9_USER=${C9_USER};
ENV C9_PASS=${C9_PASS};

# Install Supervisor.
RUN apt-get update && \
    apt-get -y install \
    curl \
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
    vim-tiny \
    supervisor \
    git && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------------------------------------------------------------------------------
# nodejs
RUN echo "deb http://deb.nodesource.com/node_4.x stretch main" >> /etc/apt/sources.list
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -   

# ------------------------------------------------------------------------------
# yarn
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

# install global nodejs modules
RUN apt-get update && apt-get -y install nodejs yarn && \
npm install -g grunt-cli bower grunt-sass

# Define mountable directories.
VOLUME ["/etc/supervisor/conf.d"]

# Determine runlevel and services at startup [BOOT-5180]
RUN update-rc.d supervisor defaults

# Define working directory.
WORKDIR /etc/supervisor/conf.d
# Add supervisord conf
ADD conf/cloud9.conf /etc/supervisor/conf.d/

# ------------------------------------------------------------------------------
# ssh keys
WORKDIR /root
RUN mkdir .ssh
ADD ssh/id_rsa .ssh/id_rsa
ADD ssh/id_rsa.pub .ssh/id_rsa.pub
ADD ssh/authorized_keys .ssh/authorized_keys
ADD ssh/known_hosts .ssh/known_hosts
RUN chmod 0600 .ssh/id_rsa

# ------------------------------------------------------------------------------
# Add .bashrc configuration
ADD conf/.bashrc /root/

WORkDIR /tmp

# ------------------------------------------------------------------------------
# pkg-config
#RUN curl https://pkg-config.freedesktop.org/releases/pkg-config-0.29.tar.gz -o pkgconfig.tgz && tar -zxf pkgconfig.tgz
#WORkDIR pkg-config-0.29
#RUN ./configure && make install

# ------------------------------------------------------------------------------
# wachman
RUN git clone https://github.com/facebook/watchman.git
WORkDIR /tmp/watchman
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/vchavkov/c9-core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh && \
sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80
EXPOSE 2368

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]