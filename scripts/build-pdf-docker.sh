#!/bin/bash

set -uex

# Fetch docker images
docker build -t gp-pdf-build \
  -f ./scripts/build-pdf.Dockerfile .

# Build PDF first
docker run -v "$(pwd):/workspace" -e VERSION=${VERSION} -it gp-pdf-build 

# Clean up unused files
rm ./dist/*.aux ./dist/*.bcf ./dist/*.log ./dist/*.out ./dist/*.xml
