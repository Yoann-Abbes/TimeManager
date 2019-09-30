#!/bin/bash

main() {
    docker-compose up -d
    until curl --output /dev/null --silent --fail -d '{"user": { "username": "test", "password": "test"}}' -H "Content-Type: application/json" -X POST http://localhost:4000/api/users/sign_in; do
        echo "API - waiting to start"
        sleep 2
    done
    npm install -g newman
    newman run ./tests/Tests-collection.json -e ./tests/Tests-collection-env.json --timeout 1800000 --timeout-request 1800000 --timeout-script 1800000 --bail
    status=$?
    exit $status
}

main

