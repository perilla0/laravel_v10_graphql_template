#!/bin/bash

cd `dirname $0`
cd ../../

source .env

docker compose down
docker rmi -f ${PROJECT_NAME}_app
docker rmi -f ${PROJECT_NAME}_web
docker builder prune

sudo rm -rf src