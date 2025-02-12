-- HOMEWORK 03 - DATA WAREHOUSE

-- SETUP - CREATE EXTERNAL TABLE
CREATE OR REPLACE EXTERNAL TABLE `zoomcamp-sandbox.de_zoomcamp.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://zoomcamp-twa-kestra-bucket/yellow_tripdata_2024-*.parquet']
);

-- SETUP - CREATE REGULAR MATERIALIZED BQ TABLE (non-partitioned, clustered)
CREATE OR REPLACE TABLE `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`
AS SELECT * FROM `zoomcamp-sandbox.de_zoomcamp.external_yellow_tripdata`;


-- Question 1: What is count of records for the 2024 Yellow Taxi Data?
SELECT
  FORMAT("%'d", COUNT(*)) AS formatted_count
FROM
  `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`;



-- Question 2
-- Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
-- What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?

-- External table
SELECT
  COUNT(DISTINCT PULocationID)
FROM
  `zoomcamp-sandbox.de_zoomcamp.external_yellow_tripdata`;


-- Non-partitioned table
SELECT
  COUNT(DISTINCT PULocationID)
FROM
  `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`;



-- Question 3
-- Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery.
-- Now write a query to retrieve the PULocationID and DOLocationID on the same table.
-- Why are the estimated number of Bytes different?

SELECT
  PULocationID
FROM
  `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`;

SELECT
  PULocationID,
  DOLocationID
FROM
  `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`;


-- Question 4
-- How many records have a fare_amount of 0?
SELECT
  COUNT(*) AS zero_fare_amount_cnt
FROM
  `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`
WHERE
  fare_amount = 0;


-- Question 5
-- What is the best strategy to make an optimized table in Big Query if your query
-- will always filter based on tpep_dropoff_datetime and order the results by VendorID
-- (Create a new table with this strategy)
CREATE OR REPLACE TABLE `zoomcamp-sandbox.de_zoomcamp.partitioned_yellow_tripdata`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS (
  SELECT *
  FROM `zoomcamp-sandbox.de_zoomcamp.external_yellow_tripdata`
);


-- Question 6
-- Write a query to retrieve the distinct VendorIDs 
-- between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)

-- Use the materialized table you created earlier in your from clause and note
-- the estimated bytes. Now change the table in the from clause to the partitioned
-- table you created for question 5 and note the estimated bytes processed. What are these values? 

SELECT DISTINCT VendorID
FROM `zoomcamp-sandbox.de_zoomcamp.yellow_tripdata`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' and '2024-03-15';

SELECT DISTINCT VendorID
FROM `zoomcamp-sandbox.de_zoomcamp.partitioned_yellow_tripdata`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' and '2024-03-15';





