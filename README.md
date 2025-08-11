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

Install QA catalogue backend:

~~~sh
git clone https://github.com/pkiraly/qa-catalogue.git
cd ~/qa-catalogue
make build
~~~

Create local directories (or symlinks to directories) `input` and `output`:

~~~sh
mkdir input output 
ln -s $DIRECTORY_OF_PICA_DUMP input/qa-catalogue
~~~

PICA data must be stored in the directory symlinked via `input/qa-catalogue`. Records must be in `.dat.gz` format.

Link input and output directory in qa-catalogue:

~~~sh
cd ~/qa-catalogue-kxp/qa-catalogue
ln -s ../input input
ln -s ../output output
~~~

Start Solr image (only required once). Make sure that port 8983 is free on your system before you start Solr:

~~~
cd ..
mkdir solrdata
sudo chown 8983:8983 solrdata
docker compose --env-file default.env -f solr.yml up -d
~~~

Run the container with the input directory mounted to `/opt/qa-catalogue/marc`. The analysis expects files at `/opt/qa-catalogue/marc/qa-catalogue/*.dat.gz` inside the container

~~~sh
docker pull ghcr.io/pkiraly/qa-catalogue-slim:main
docker run -d --name qa-catalogue-slim \
  -v /home/schaeferd/qa-catalogue-kxp/input:/opt/qa-catalogue/input \
  -v /home/schaeferd/qa-catalogue-kxp/output:/opt/qa-catalogue/output \
  -v /home/schaeferd/qa-catalogue-kxp/logs:/opt/qa-catalogue/logs \
  -v /home/schaeferd/qa-catalogue-kxp/web-config:/var/www/html/qa-catalogue/config \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  ghcr.io/pkiraly/qa-catalogue-slim:main tail -f /dev/null
~~~

If necessary install R and install required R packages
~~~sh
sudo apt update
sudo apt install r-base
Rscript -e "install.packages('tidyverse', repos='https://cran.r-project.org')"
~~~

If necessary install mvn
~~~sh
cd ~/qa-catalogue-kxp/qa-catalogue
mvn clean package -DskipTests
~~~

Run analysis
~~~sh
`./run-analysis`
~~~

Start frontend (only required once)

~~~sh
`./start-frontend`
~~~

