#!/bin/bash

set -uex

cd graypaper
export VERSION="$(git rev-parse HEAD)"
cd -

# Fetch docker image
PDF2HTMLEX_IMG="pdf2htmlex/pdf2htmlex:0.18.8.rc2-master-20200820-ubuntu-20.04-x86_64"
docker pull $PDF2HTMLEX_IMG

./scripts/build-pdf-docker.sh

# Now build HTML from the PDF
docker run --platform linux/amd64 -ti --rm \
  -v "$(pwd)/dist:/pdf" \
  -w /pdf $PDF2HTMLEX_IMG \
  --zoom 1.3 \
  --decompose-ligature 1 \
  --embed-font 0 \
  --embed-outline 1 \
  --process-outline 1 \
  --printing 0 \
  graypaper-$VERSION.pdf

./scripts/update-metadata.sh
