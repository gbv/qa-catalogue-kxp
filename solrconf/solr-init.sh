#!/bin/bash
# This script is executed *inside* Solr Docker container on startup.

cd docker/scripts
source run-initdb

# create cores on disk (unless they exist)
precreate-core qa-catalogue
precreate-core qa-catalogue_dev
precreate-core qa-catalogue_validation

# runs Solr in the foreground
exec solr-fg --user-managed
