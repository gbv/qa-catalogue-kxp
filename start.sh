#!/usr/bin/bash

FRONTEND_IMAGE=ghcr.io/pkiraly/qa-catalogue-web:main
SOLR_IMAGE=solr

docker pull $FRONTEND_IMAGE
docker pull $SOLR_IMAGE

# no backend-only docker image yet, so we use sources
if [ -d qa-catalogue ]; then git -C qa-catalogue pull ; else git clone https://github.com/pkiraly/qa-catalogue.git; fi

# start frontend
# WEBPORT=83 IMAGE=FRONTEND_IMAGE docker compose up -f frontend.yml -d

# start Solr (TODO: with volume)
# docker run -p 8983:8983 -t solr

# TODO: requires backend image without solr included (https://github.com/pkiraly/qa-catalogue/issues/437)
# BACKEND_IMAGE=ghcr.io/pkiraly/qa-catalogue:main
# docker pull $BACKEND_IMAGE
# 
# start backend (Why WEBCONFIG & WEBPORT?!)
# CONTAINER=$BACKEND_CONTAINER
# IMAGE=$BACKEND_IMAGE WEBCONFIG=config WEBPORT=$WEBPORT docker compose -f backend.yml up

