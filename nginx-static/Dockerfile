FROM debian:jessie
LABEL maintainer="vchavkov@assistance.bg"

COPY ./bin/install.sh /tmp/install.sh
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /tmp/install.sh \
  && rm -rf /var/lib/apt/lists/*

# copy etc
COPY etc /etc

# configure .bashrc
ADD .bashrc /root/

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443 22 5353

ENTRYPOINT ["bin/entrypoint.sh"]

# CMD ["nginx", "-g", "daemon off;"]

# CMD ["/usr/sbin/sshd", "-D"]