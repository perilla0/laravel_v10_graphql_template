#!/bin/bash

cd `dirname $0`
cd ../

docker compose down --rmi all --volumes

# docker compose down --rmi all --volumes --remove-orphans
# docker system prune
# docker image prune -a
# docker builder prune
# docker volume prune
# rm -R ~/.docker/