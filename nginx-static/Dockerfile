FROM debian:jessie
LABEL maintainer="vchavkov@assistance.bg"

COPY ./bin/install.sh /tmp/install.sh
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /tmp/install.sh \
  && rm -rf /var/lib/apt/lists/*

# nginx conf files
COPY etc/nginx /etc/nginx

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443 22

# CMD ["nginx", "-g", "daemon off;"]

# CMD ["/usr/sbin/sshd", "-D"]