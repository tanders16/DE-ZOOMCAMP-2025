import dlt
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import PageNumberPaginator


# Define the API resource for NYC taxi data
@dlt.resource(name="rides")   # <--- The name of the resource (will be used as the table name)
def ny_taxi():
    client = RESTClient(
        base_url="https://us-central1-dlthub-analytics.cloudfunctions.net/data_engineering_zoomcamp_api",
        paginator=PageNumberPaginator(
            base_page=1,
            total_path=None
        )
    )

    for page in client.paginate("data_engineering_zoomcamp_api"):    # <--- API endpoint for retrieving taxi ride data
        yield page   # <--- yield data to manage memory


# define new dlt pipeline
pipeline = dlt.pipeline(
    pipeline_name="ny_taxi_pipeline",
    destination="duckdb",
    dataset_name="ny_taxi_data"
)

# run the pipeline with the new resource
load_info = pipeline.run(ny_taxi, write_disposition="replace")
print(load_info)

# explore loaded data
df = pipeline.dataset(dataset_type="default").rides.df()

print("QUESTION 2: Tables Created")
with pipeline.sql_client() as client:
    res = client.execute_sql(
        """
        SHOW TABLES;
        """
    )
    print("Results of running SQL: SHOW TABLES;")
    print(res)
    print("COUNT OF TABLES:  " + str(len(res)))

print("\n\n\n\n\n")
print("QUESTION 3: Total Extracted Records")
print("Number of rows in 'rides' dataframe: " + str(len(df)))

print("\n\n\n\n\n")
print("QUESTION 4: Trip Duration Analysis")
sql = """
        SELECT AVG(date_diff('minute', trip_pickup_date_time, trip_dropoff_date_time))
        FROM rides;
        """
with pipeline.sql_client() as client:
    res = client.execute_sql(sql)
    print("\n" + sql + "\n")
    print(res)

