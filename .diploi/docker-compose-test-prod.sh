#!/bin/bash

#
# Script to test run the component in docker compose
#

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ..


rm -rf component-test
mkdir -p component-test/component
rsync -av --progress --exclude component-test  --exclude .diploi ./ component-test/component
docker compose --project-directory component-test --file .diploi/docker-compose-prod.yml  --progress plain up --build

# Test like this: 
# docker exec -it spin-component-test-prod bash