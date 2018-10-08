# docker build
docker build - < Dockerfile

# docker stop all
docker stop $(docker ps -a -q)

# Must be run first because images are attached to containers
docker rm -f $(docker ps -a -q)

# Delete every Docker image
docker rmi -f $(docker images -q)

# create cloud9 container
docker run -it -d --restart=always -p 40000:80 --name vchavkov -e C9_USER=vchavkov -e C9_PASS=aiTh3oop -v /ghost:/workspace a2851b65e353
docker run -it -d --restart=always -p 31000:80 --name ndemirev -e C9_USER=ndemirev -e C9_PASS=jo2eeLah -v /ghost/customer:/workspace a2851b65e353
docker run -it -d --restart=always -p 31001:80 --name asaraliyski -e C9_USER=asaraliyski -e C9_PASS=Eijo6eek -v /ghost/customer/asaraliyski:/workspace a2851b65e353

# create debian container
docker run -it debian /bin/bash

docker run -it busybox  # CTRL-P/Q to quit
docker attach <container id>  # then you have root user
/ # id
uid=0(root) gid=0(root) groups=10(wheel)

docker run -it --user nobody busybox # CTRL-P/Q to quit
docker attach <container id>
/ $ id
uid=99(nobody) gid=99(nogroup)


docker run -it alpine /bin/sh
