# Module 1 Homework: Workflow Orchestration

**Question 1. Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (i.e. the output file yellow_tripdata_2020-12.csv of the extract task)?**

![Screenshot 2025-02-04 at 10 07 43 AM](https://github.com/user-attachments/assets/c266dccd-cc31-4c64-a2d3-06841ab982a1)

Ran data load pipeline in Kestra with file purge task removed.
Inspected output results.
Result: 128.3 MB


**Question 2. What is the rendered value of the variable file when the inputs taxi is set to green, year is set to 2020, and month is set to 04 during execution?**

![Screenshot 2025-02-04 at 10 10 38 AM](https://github.com/user-attachments/assets/a7f39edd-c2e7-4bc6-b857-178d6027e797)

Ran data load pipeline in Kestra. Inspected output for extract task.
Result: green_tripdata_2020-04.csv


**Question 3. How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?**

![Screenshot 2025-02-04 at 9 51 27 AM](https://github.com/user-attachments/assets/8f1929a7-50ac-4723-aa18-bc6a72763229)

Ran data backfills in Kestra/GCP for all files marked 2019, 2020, and 2021.
Ran query in BigQuery for annual totals.
Result:  24,648,663 --> closest provided answer, 24,648,499


**Question 4. How many rows are there for the Green Taxi data for all CSV files in the year 2020?**

![Screenshot 2025-02-04 at 9 52 03 AM](https://github.com/user-attachments/assets/8960e4c0-f16f-429d-ae1b-0198e3499853)

Ran data backfills in Kestra/GCP for all files marked 2019, 2020, and 2021.
Ran query in BigQuery for annual totals.
Result:  1,734,039 --> closest provided answer, 1,734,051


**Question 5. How many rows are there for the Yellow Taxi data for the March 2021 CSV file?**

![Screenshot 2025-02-04 at 10 36 42 AM](https://github.com/user-attachments/assets/fc6e5ebf-2bdb-4905-9617-79465fd750dd)

Ran data load pipeline in Kestra. Downloaded extract file. Inspected via Unix.
Result: 1,925,153 --> closest provied answer, 1,925,152

<img width="834" alt="Screenshot 2025-01-14 at 11 34 14 PM" src="https://github.com/user-attachments/assets/996e4433-c4a3-456a-ae09-421b790078cb" />


**How would you configure the timezone to New York in a Schedule trigger?**

![Screenshot 2025-02-04 at 10 15 34 AM](https://github.com/user-attachments/assets/b5fa9102-f510-4806-882e-c98acd92d738)

Verified via Kestra online documentation. Instructions state to
"Add a timezone property set to America/New_York in the Schedule trigger configuration.






