# Module 3 Homework: Data Warehouse

**Question 1. What is count of records for the 2024 Yellow Taxi Data?**

![Screenshot 2025-02-04 at 10 07 43 AM](https://github.com/user-attachments/assets/c266dccd-cc31-4c64-a2d3-06841ab982a1)

Ran data load pipeline in Kestra with file purge task removed.
Inspected output results.
Result: 128.3 MB

**Question 2. Write a query to count the distinct number of _PULocationIDs_ for the entire dataset on both the tables. **

**What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?**

![Screenshot 2025-02-04 at 10 10 38 AM](https://github.com/user-attachments/assets/a7f39edd-c2e7-4bc6-b857-178d6027e797)

Ran data load pipeline in Kestra. Inspected output for extract task.
Result: green_tripdata_2020-04.csv


**Question 3. Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?**

![Screenshot 2025-02-04 at 9 51 27 AM](https://github.com/user-attachments/assets/8f1929a7-50ac-4723-aa18-bc6a72763229)

Ran data backfills in Kestra/GCP for all files marked 2019, 2020, and 2021.
Ran query in BigQuery for annual totals.
Result:  24,648,663 --> closest provided answer, 24,648,499


**Question 4. How many records have a fare_amount of 0?**

![Screenshot 2025-02-04 at 9 52 03 AM](https://github.com/user-attachments/assets/8960e4c0-f16f-429d-ae1b-0198e3499853)

Ran data backfills in Kestra/GCP for all files marked 2019, 2020, and 2021.
Ran query in BigQuery for annual totals.
Result:  1,734,039 --> closest provided answer, 1,734,051


**Question 5. What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)**

![Screenshot 2025-02-04 at 10 36 42 AM](https://github.com/user-attachments/assets/fc6e5ebf-2bdb-4905-9617-79465fd750dd)

Ran data load pipeline in Kestra. Downloaded extract file. Inspected via Unix.
Result: 1,925,153 --> closest provied answer, 1,925,152

<img width="834" alt="Screenshot 2025-01-14 at 11 34 14 PM" src="https://github.com/user-attachments/assets/996e4433-c4a3-456a-ae09-421b790078cb" />


**Question 6. Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)**

**Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values?**


![Screenshot 2025-02-04 at 10 15 34 AM](https://github.com/user-attachments/assets/b5fa9102-f510-4806-882e-c98acd92d738)

Verified via Kestra online documentation. Instructions state to
"Add a timezone property set to America/New_York in the Schedule trigger configuration.


**Question 7. Where is the data stored in the External Table you created?**




**Question 8. It is best practice in Big Query to always cluster your data:**

True / **False**

Question is disturbing by using the word **“always”**. Videos and online do suggest that a good practice is to use a clustered _OR_ partitioned table for cost reduction. However, the videos noted that you should not consider clustering for tables with a size < 1GB. That these smaller tables actually will cost _more_ with clustering due to overhead.








