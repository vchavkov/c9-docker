# Pull base image.
FROM debian
LABEL maintainer="vchavkov@assistance.bg"

ENV C9_USER=${C9_USER};
ENV C9_PASS=${C9_PASS};

# Install Supervisor.
RUN \
    apt-get update && apt-get -y install curl build-essential supervisor git && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf && \
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    apt-get install -y nodejs

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
RUN scripts/install-sdk.sh

# ------------------------------------------------------------------------------
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

# Add supervisord conf
ADD conf/cloud9.conf /etc/supervisor/conf.d/

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