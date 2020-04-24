#!/bin/bash

# init connector
# curl -s -X POST -H 'Content-Type: application/json' --data @config/connect_twitter.json http://localhost:8083/connectors
echo 'Starting Twitter source connector...'
curl -s -X POST -H 'Content-Type: application/json' --data @config/connect_twitter-alec.json http://localhost:8083/connectors
