#!/bin/bash

echo 'Starting ksqlDB streams for schema fitting and filtering'
docker-compose exec ksqldb-cli bash -c "ksql http://ksqldb-server:8088 <<EOF
run script '/tmp/ksqlcommands';
exit ;
EOF
"
