#!/bin/bash

[ -e .env ] && . .env

COMPOSE_FILE=docker-compose.base.yml

[ "$ENABLE_MYSQL" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:mysql/docker-compose.yml

[ -f docker-compose.override.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:docker-compose.override.yml

export COMPOSE_FILE=$COMPOSE_FILE

docker-compose $*
