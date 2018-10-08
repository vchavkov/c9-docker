FROM frolvlad/alpine-oraclejdk8

ADD sftpserver-1.2.3.tar.gz /
RUN tar -xvf sftpserver-1.2.3.tar.gz

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /data
VOLUME /data

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 22222