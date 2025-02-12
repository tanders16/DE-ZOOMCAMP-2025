# Module 3 Homework: Data Warehouse

**Question 1. What is count of records for the 2024 Yellow Taxi Data?**

![Screenshot 2025-02-11 at 9 32 55 PM](https://github.com/user-attachments/assets/91f2b600-e7a9-4a73-b39d-da1f1ca04cc2)


Loaded 6 months of 2024 data as instructed.
Created simple count query.
Result: 20,332,093



**Question 2. Write a query to count the distinct number of _PULocationIDs_ for the entire dataset on both the tables. **

**What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?**

![Screenshot 2025-02-11 at 9 51 53 PM](https://github.com/user-attachments/assets/d5f31821-47a3-486b-aa1d-9bc9b107000f)

![Screenshot 2025-02-11 at 9 51 17 PM](https://github.com/user-attachments/assets/2602762b-9c0f-45fc-9169-fa7e30ebb4d1)

Inspected queries for estimates.
Result: 0MB for the external table, 155.12MB for the materialized table



**Question 3. Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?**

![Screenshot 2025-02-11 at 9 54 58 PM](https://github.com/user-attachments/assets/ce437fa6-9ebe-448f-a4b8-f0d954b9d880)

![Screenshot 2025-02-11 at 9 55 16 PM](https://github.com/user-attachments/assets/5d617c2b-f262-410b-8d28-cdf980b59201)

Created queries as defined. Reviewed estimate sizes.
Answer:  BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than queryig one column (PULocationID), leading to a higher estimated number of bytes processed.



**Question 4. How many records have a fare_amount of 0?**

![Screenshot 2025-02-11 at 9 59 02 PM](https://github.com/user-attachments/assets/2ffd39d1-ad09-4ee8-b8ca-2b6d50e56ed6)

Ran query as directed.
Result:  8,333



**Question 5. What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)**

![Screenshot 2025-02-11 at 10 04 28 PM](https://github.com/user-attachments/assets/94047730-4824-4ec7-aceb-098a5b4018d2)

Answer: Partition by tpep_dropoff_datetime and Cluster on VendorID

Filtering by tpep_dropoff_datetime (date portion)
Ordering by VendorID



**Question 6. Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)**

**Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values?**

![Screenshot 2025-02-11 at 10 10 06 PM](https://github.com/user-attachments/assets/113d9308-d172-4712-b228-10546b5351f9)

![Screenshot 2025-02-11 at 10 34 31 PM](https://github.com/user-attachments/assets/3ed62535-b5df-44cc-8c6b-9ddc1ab328cf)

Answer: 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table



**Question 7. Where is the data stored in the External Table you created?**

![Screenshot 2025-02-11 at 10 12 14 PM](https://github.com/user-attachments/assets/af283691-6d92-4073-bdcf-ac9094bc0845)

Answer: GCP Bucket



**Question 8. It is best practice in Big Query to always cluster your data:**

Answer: **False**

Question is disturbing by using the word **“always”**. Videos and online do suggest that a good practice is to use a clustered _OR_ partitioned table for cost reduction. However, the videos noted that you should not consider clustering for tables with a size < 1GB. That these smaller tables actually will cost _more_ with clustering due to overhead.








