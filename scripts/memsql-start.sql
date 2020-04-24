-- memsql sink -- 
create database IF NOT EXISTS db;use db;
CREATE TABLE IF NOT EXISTS tweets (
	create_ts BIGINT,
	tweet_id BIGINT,
	username VARCHAR(100),
	location VARCHAR(100),
	tweet_text VARCHAR(256)
);
