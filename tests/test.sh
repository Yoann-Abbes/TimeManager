#!/bin/bash

main() {
    npm install -g newman
    newman run ./tests/Tests-collection.json -e ./tests/Tests-collection-env.json --timeout 1800000 --timeout-request 1800000 --timeout-script 1800000 --bail
    status=$?
    exit $status
}


exec docker-compose -f ./back/test.yml up
main

