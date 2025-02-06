# QA catalogue for K10plus

This repository contains configuration for an instance of **QA catalogue** ([backend](https://github.com/pkiraly/qa-catalogue) and [frontend](https://github.com/pkiraly/qa-catalogue-web)) for K10plus catalogue.

## Requirements

- Docker with `docker compose` (Ubuntu: run `sudo apt install docker-compose-v2`)

## Outline

- [webconf](webconf) configuration of the frontend
- [solrconf](solrconf) configuration of Solr
- `default.env` contains environment variables to specify Docker images and container names
- `test` contains sample data (sample of 1000 records from K10plus dump),
  created with `zcat kxp-title-noexp-*.dat.gz | head -1000000 | pica sample 1000 -o ~/kxp-title-noexp-sample.dat.gz`

## Installation and Usage

Install QA catalogue backend:

~~~sh
git clone https://github.com/pkiraly/qa-catalogue.git
cd qa-catalogue
make build
~~~

Create local directories (or symlinks to directories) `input` and `output`:

~~~sh
mkdir output
ln -s $DIRECTORY_OF_PICA_DUMP input
~~~

Start Solr image (only required once): 

~~~
mkdir solrdata
sudo chown 8983:8983 solrdata
docker compose --env-file default.env -f solr.yml up -d
~~~

Run analysis

~~~sh
`./run-analysis`
~~~

Start frontend (only required once)

~~~sh
`start-frontend`
~~~

