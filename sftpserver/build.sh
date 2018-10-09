#!/bin/bash

docker build .

docker push 172.31.0.157:31292/sftpserver:1.0.0
