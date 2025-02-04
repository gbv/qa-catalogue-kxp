# QA catalogue for K10plus

This repository contains configuration for an instance of **QA catalogue** ([backend](https://github.com/pkiraly/qa-catalogue) and [frontend](https://github.com/pkiraly/qa-catalogue-web)) for K10plus catalogue.

- `default.env` contains environment variables to specify Docker images and container names

- `config` contains configuration of the frontend

- `test` contains sample data (sample of 1000 records from K10plus dump),
  created with `zcat kxp-title-noexp-*.dat.gz | head -1000000 | pica sample 1000 -o ~/kxp-title-noexp-sample.dat.gz`

## Requirements

- Docker with `docker compose` (Ubuntu: run `sudo apt install docker-compose-v2`)

## Usage

- Create local directories (or symlinks to directories) `input` and `output`

- Start solr: `rm -rf solrdata/*; docker compose --env-file default.env -f solr.yml up`

- `./run-analysis.sh`

- Start frontend with `start-frontend`

