#!/bin/bash

main() {
    npm install -g newman
    newman run ./Tests-collection.json --timeout 1800000 --timeout-request 1800000 --timeout-script 1800000 --bail
    status=$?
    exit $status
}

main

exec docker-compose -f ./back/test.yml run phoenix