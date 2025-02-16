# DLT WORKSHOP Homework: 

See pipeline for all code to derive answers: 


**Question 1. Install DLT, identify version number?**

![Screenshot 2025-02-16 at 1 15 08 PM](https://github.com/user-attachments/assets/c8b13205-1d58-4e72-8f11-9bee448e202f)

Installed DLT in a venv using "pip install dlt[duckdb]"
Ran "dlt --version"
Result: 1.6.1



**Question 2. Define & Run the Pipeline (NYC Taxi API) **

Use dlt to extract all pages of data from the API.

Steps:

1️⃣ Use the @dlt.resource decorator to define the API source.

2️⃣ Implement automatic pagination using dlt's built-in REST client.

3️⃣ Load the extracted data into DuckDB for querying.

**How many tables were created?**

Created pipeline following examples ().
Connected to the data, running

```
with pipeline.sql_client() as client:
    res = client.execute_sql(
        """
        SHOW TABLES;
        """
    )
```

![Screenshot 2025-02-16 at 2 21 53 PM](https://github.com/user-attachments/assets/62664ff4-f9a3-4484-beb9-702473462e82)

Result: 4 tables created



**Question 3. Explore the loaded data**
**What is the total number of records extracted?**

Printed dataframe:

![Screenshot 2025-02-16 at 1 59 22 PM](https://github.com/user-attachments/assets/a7c33fdb-9bf4-44ea-9edc-6f0642f61ffd)

Printed dataframe length:

![Screenshot 2025-02-16 at 2 35 13 PM](https://github.com/user-attachments/assets/aed4a59b-4478-46cc-932e-264142d7a277)

Result:  10,000



**Question 4. Trip Duration Analysis**

Added query as suggested
```
sql = """
        SELECT AVG(date_diff('minute', trip_pickup_date_time, trip_dropoff_date_time))
        FROM rides;
        """
with pipeline.sql_client() as client:
    res = client.execute_sql(sql)
```

![Screenshot 2025-02-16 at 2 35 23 PM](https://github.com/user-attachments/assets/ae3f693c-d5ec-4097-a682-972a3bed2328)


Result: 12.3049




FOR RECORD, printed all answers via code in a single run.

![Screenshot 2025-02-16 at 2 34 39 PM](https://github.com/user-attachments/assets/251d6697-a5d5-4979-ab88-83e38c3373f6)


