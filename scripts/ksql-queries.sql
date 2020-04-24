-- get raw data from twitter as a stream --
CREATE STREAM twitter_raw (
	  CreatedAt BIGINT,
	  Id BIGINT,
      User STRUCT<Id BIGINT,ScreenName VARCHAR,Location VARCHAR>, 
      Text VARCHAR)
WITH (KAFKA_TOPIC='twitter_json', VALUE_FORMAT='JSON');

SET 'auto.offset.reset' = 'earliest'; 

-- select only the relevant tweet fields
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


--------------------------
-- CREATE TABLE agg AS
--   SELECT x, COUNT(*), SUM(y)
--   FROM twitter_raw WINDOW TUMBLING (SIZE 1 HOUR)
--   GROUP BY x EMIT CHANGES;
