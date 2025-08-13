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
  - file `test/allfields.pp` contains one record generated from Avram with `npm run allfields` (requires `npm install` first)

## Installation and Usage

### Setup environment 

Create local directories (or symlinks) `input` and `output`:

~~~sh
mkdir input output 
ln -s $DIRECTORY_OF_PICA_DUMP input/qa-catalogue
~~~

PICA data must be stored in directory `input/qa-catalogue`. Records must be in `.dat.gz` format.
You can compress raw files with:

~~~sh
gzip -c raw-data.dat > raw-data.dat.gz
~~~

### Run Solr

Start Solr image (only required once). 
Make sure that port 8983 is free on your system:

~~~sh
cd ..
mkdir solrdata
sudo chown 8983:8983 solrdata
docker compose --env-file default.env -f solr.yml up -d
~~~

If Solr is not running during your analysis, you might have to start Solr again:

~~~sh
docker run -d --name qa-catalogue-solr -p 8983:8983 solr:9.8.0
~~~

### Run the analysis

Run analysis with Docker:

~~~sh
`./run-analysis`
~~~

### Start frontend

Optional and only required once, to inspect the results.

~~~sh
`./start-frontend`
~~~

