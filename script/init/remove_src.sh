#!/bin/bash

cd `dirname $0`
cd ../../

source .env

docker compose down
docker rmi -f ${PROJECT_NAME}_backend
# docker rmi -f ${PROJECT_NAME}_web
docker rmi -f ${PROJECT_NAME}_frontend
docker builder prune

sudo rm -rf src