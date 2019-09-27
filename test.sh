#!/bin/bash

set -e

exec docker-compose -f ./back/test.yml run phoenix
