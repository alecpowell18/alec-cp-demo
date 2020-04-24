# alec-cp-demo
Customized version of cp-demo.

Alec Powell (apowell@confluent.io)

Last Updated: 04-24-20 for Confluent Platform 5.5.0

## RUNBOOK
#### Pre-reqs:
```bash
sudo yum install git
sudo yum install docker-compose
git clone <this-repo>
```
#### Spin up the demo containers...
```bash
#SET NECESSARY ENV VARS [TODO]
docker-compose up -d
```
#### Make sure everything is "up"... (except for kafka-client which exists only to create the first topic)
```bash
docker-compose ps
```
#### Put the connectors in place and off we go!
```bash
./01-start-twitter-connector.sh
./02-init-ksqldb-streams.sh
./03-start-memsql-connect-sink.sh
```

## TEARDOWN
```bash
docker-compose down -v
```
