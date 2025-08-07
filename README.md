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
cd qa-catalogue
make build
~~~

Create local directories (or symlinks to directories) `input` and `output`:

~~~sh
cd qa-catalogue-kxp/qa-catalogue
mkdir input output 
ln -s $DIRECTORY_OF_PICA_DUMP input/qa-catalogue
~~~

Link input and output directory in qa-catalogue:

~~~sh
cd qa-catalogue-kxp/qa-catalogue
ln -s ../input input
ln -s ../output output
~~~

Start Solr image (only required once) 
~~~
cd ..
mkdir solrdata
sudo chown 8983:8983 solrdata
docker compose --env-file default.env -f solr.yml up -d
~~~
Make sure that port 8983 is free on your system before you start Solr.

Prepare input data and create executable JAR and Java Maven project.

Place your .dat.gz files inside the ./input/qa-catalogue/ directory. The analysis expects files at /opt/qa-catalogue/marc/qa-catalogue/*.dat.gz inside the container

Run the container with the input directory mounted to /opt/qa-catalogue/marc

After that:
~~~sh
target/qa-catalogue-0.8.0-SNAPSHOT-jar-with-dependencies.jar
mvn clean package
~~~

Now you can start the validator directly with Java
~~~sh
java -Xmx8g -cp target/qa-catalogue-0.8.0-SNAPSHOT-jar-with-dependencies.jar de.gwdg.metadataqa.marc.cli.ValidatorCli --details --trimId --summary --format csv --defaultRecordType BOOKS --outputDir ../output/25-08911-005 --detailsFileName issue-details.csv --summaryFileName issue-summary.csv --schemaType PICA --marcFormat PICA_NORMALIZED --emptyLargeCollectors ../input/25-08911-005/kxp_sample.dat.gz
~~~

Run analysis

~~~sh
chmod +x run-analysis
`./run-analysis`
~~~
PICA data must be stored in qa-catlogue-kxp/input in a separate folder. 
They must be in .dat.gz format.

Start frontend (only required once)

~~~sh
`./start-frontend`
~~~

