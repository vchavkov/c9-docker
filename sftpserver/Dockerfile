FROM frolvlad/alpine-oraclejdk8
LABEL maintainer="vchavkov@assistance.bg"

env SFTPD_HOME=/opt/sftpd
env SFTPD_LOG=FILE
env SFTPD_OPTS="-showversion -XX:+PrintCommandLineFlags -XX:-PrintFlagsFinal"
env SFTPD_MEM_MB=64

RUN mkdir -p ${SFTPD_HOME}
# ADD sftpserver-1.2.3.tar.gz $SFTPD_HOME
ADD sftpd $SFTPD_HOME

# ------------------------------------------------------------------------------
# Add volumes
VOLUME $SFTPD_HOME/home

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 22222

# ENTRYPOINT [ "sh", "-c", "${SFTPD_HOME}/bin/sftpd.sh run" ]
