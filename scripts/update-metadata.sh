#!/bin/bash

set -uex

cd graypaper 
export GP_DATE="$(git show --no-patch --format=%aD)"
cd -

jq --arg ver "$VERSION" --arg dat "$GP_DATE" --arg name "$(cat graypaper/VERSION)" '.latest = $ver | .versions += { ($ver) : { name: $name, hash: $ver, date: $dat }}' ./dist/metadata.json > ./dist/temp-metadata.json
mv ./dist/temp-metadata.json ./dist/metadata.json
