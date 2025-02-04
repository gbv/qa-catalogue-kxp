#!/bin/sh
#
# This script is run when the Solr container is started.
#
# It create cores on disk (unless they exist) and then runs Solr in the foreground.
#

cd docker/scripts

source run-initdb

precreate-core qa-catalogue
precreate-core qa-catalogue_dev
precreate-core k10plus_pica_grouped_validation

exec solr-fg --user-managed
