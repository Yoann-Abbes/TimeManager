#!/bin/bash

main() {
    mix ecto.reset
    docker-compose up -d
    npm install -g newman
    newman run ./tests/Tests-collection.json -e ./tests/Tests-collection-env.json --timeout 18000000 --timeout-request 18000000 --timeout-script 18000000 --bail
    status=$?
    exit $status
}

main

