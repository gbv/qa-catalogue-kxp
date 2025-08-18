#!/usr/bin/env bash
set -o allexport

# -----------------------------
# Solr-Host
# -----------------------------
SOLR_HOST=http://172.17.0.1:8983

SCHEMA=PICA
MASK="*.dat.gz"
AVRAM=`pwd`/avram-k10plus-title.json

TYPE_PARAMS="$TYPE_PARAMS --schemaType PICA"
TYPE_PARAMS="$TYPE_PARAMS --marcFormat PICA_NORMALIZED"
TYPE_PARAMS="$TYPE_PARAMS --emptyLargeCollectors"

# TODO: this does not work yet
#TYPE_PARAMS="$TYPE_PARAMS --groupBy 001@\$0"
#TYPE_PARAMS="$TYPE_PARAMS --groupListFile src/main/resources/k10plus-libraries-by-unique-iln.txt"

TYPE_PARAMS="$TYPE_PARAMS --ignorableFields 001@,001E,001L,001U,001U,001X,001X,002V,003C,003G,003Z,008G,017N,020F,027D,031B,037I,039V,042@,046G,046T,101@,101E,101U,102D,201E,201U,202D,1...,2..."
#TYPE_PARAMS="$TYPE_PARAMS --ignorableIssueTypes undefinedField"
TYPE_PARAMS="$TYPE_PARAMS --allowableRecords base64:"$(echo '002@.0 !~ "^L" && 002@.0 !~ "^..[iktN]" && (002@.0 !~ "^.v" || 021A.a?)' | base64 -w 0)
TYPE_PARAMS="$TYPE_PARAMS --indexWithTokenizedField"
TYPE_PARAMS="$TYPE_PARAMS --indexFieldCounts --indexSubfieldCounts"

TYPE_PARAMS="$TYPE_PARAMS --picaSchemaFile=$AVRAM"

TYPE_PARAMS="$TYPE_PARAMS --fieldPrefix bib"

# -----------------------------
# Docker Compose: Orphans entfernen & Container starten
# -----------------------------
docker compose -f backend.yml down --remove-orphans
docker compose -f backend.yml run --rm \
  -e TYPE_PARAMS \
  -e MASK \
  -e SCHEMA \
  -e SOLR_HOST \
  backend /opt/qa-catalogue/qa-catalogue "$@"
