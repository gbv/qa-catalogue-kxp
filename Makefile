ENV=default.env

default:
	@echo ...

solr-start:
	docker compose --env-file ${ENV} -f solr.yml up -d

solr-stop:
	docker compose --env-file ${ENV} -f solr.yml down

solr-reset: solr-stop
	docker run --rm -v ./solrdata:/solr alpine rm -rf /solr

web-start:
	./start-frontend

web-stop:
	docker compose --env-file ${ENV} --file frontend.yml down -d


