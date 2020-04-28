SET 'auto.offset.reset' = 'earliest'; 

-- get raw data from twitter as a stream --
CREATE STREAM twitter_raw (
	  CreatedAt BIGINT,
	  Id BIGINT,
      User STRUCT<Id BIGINT,ScreenName VARCHAR,Location VARCHAR>, 
      Text VARCHAR)
WITH (KAFKA_TOPIC='twitter_json', VALUE_FORMAT='JSON');

-- select only the relevant tweet fields we wish to analyze.
CREATE STREAM twitter_out AS
	SELECT CreatedAt AS create_ts,
	  Id AS tweet_id,
      User->ScreenName AS username,
      User->Location AS location, 
      Text AS tweet_text
    FROM twitter_raw
EMIT CHANGES;

-- format as Avro to register a schema in the Confluent Schema Registry
CREATE STREAM twitter_out_avro
  WITH (VALUE_FORMAT = 'AVRO') AS
  SELECT * FROM twitter_out
  EMIT CHANGES;

-- time-windowed aggregation example
CREATE TABLE windowed_agg AS
  SELECT username, COUNT(*) as num_tweets
  FROM twitter_out_avro 
  WINDOW TUMBLING (SIZE 1 HOUR)
  GROUP BY username
  EMIT CHANGES;

-- count of tweets per location, to be persisted to our data sink and continuously updated.
-- filter included to weed out tweets with no location specified.
CREATE TABLE counts_agg AS
  SELECT location, count(*) as count
  FROM twitter_out_avro
  WHERE location != 'null' AND location != ''
  GROUP BY location
  EMIT CHANGES;
