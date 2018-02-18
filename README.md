# docker build
docker build - < Dockerfile

# docker stop all
docker stop $(docker ps -a -q)

# Must be run first because images are attached to containers
docker rm -f $(docker ps -a -q)

# Delete every Docker image
docker rmi -f $(docker images -q)

# create cloud9 container
docker run -it -d --restart=always -p 80 --name vchavkov -e C9_USER=vchavkov -e C9_PASS=vchavkov -v /ghost/customer/vchavkov/:/workspace/ vchavkov/c9-docker

docker run -it -d --restart=always -p 32770:80 --name vchavkov -e C9_USER=vchavkov -e C9_PASS=vchavkov -e LOG_LEVEL=debug -v /ghost:/ghost 54d498871860

docker run -it -d --restart=always -p 80 --user vchavkov --name vchavkov -e C9_USER=vchavkov -e C9_PASS=vchavkov -e LOG_LEVEL=debug -v /ghost:/ghost 54d498871860

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
