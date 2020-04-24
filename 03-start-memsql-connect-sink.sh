#!/bin/bash
# create memsql database and table(s)
echo 'Creating memsql db...'
mysql -uroot -h0 < scripts/memsql-start.sql

# init connector
echo 'Starting JDBC Sink Kakfa Connector'
curl -s -X POST -H 'Content-Type: application/json' --data @config/sink_memsql.json http://localhost:8083/connectors
