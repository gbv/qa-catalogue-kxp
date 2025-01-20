#!/usr/bin/bash
set -euo pipefail

echo "field,count"
for ppn in *-unknown.ppn; do wc -l $ppn; done | \
    sort -nr | \
    awk '{print $2,$1}' | \
    sed 's/_/\//;s/-unknown.ppn//;s/\./$/;s/ /,/;'
